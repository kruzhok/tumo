#include <fft.h>
#define num 256

int8_t im[num], data[num];
int i=0, val;

int sped = 0;

bool fail = false;

int lastMillis = 0;
int blue = 0; 

void setup() {
    Serial.begin(115200);
    pinMode(11,OUTPUT); //Control motor
    pinMode(3,OUTPUT); //Error signal
}

void loop() {
  
  int8_t sum = 0;
  for (i=0; i < num; i++){                                     
    data[i] = analogRead(0)/8;   
    if (data[i] < 2 || data[i] > 120){
      fail = true;
    }
   
    delay(2);
    im[i] = 0;                                               
    sum = sum+data[i];
  }
 
 if (!fail){
   digitalWrite(3,LOW);
   
   for (i=0; i < num; i++){                                     
     data[i] = data[i] - sum/num;
   }
    
   fix_fft(data,im,8,0);
   
    bool flag = false;
    for (i=6; i<15; i++){
      if(sqrt(data[i]*data[i] + im[i]*im[i]) > 3){
        flag = true;
      }
    }
    
    if (!flag){
      if (sped != 0){
        sped = sped - 25;
      }
    }
    if(flag){
      sped = 50;
      flag = false; 
    }
    analogWrite(11,sped);
    blue = blue + (millis() - lastMillis);
    if (sped == 0) {
      blue = 0;  
    }
 }
 else{
   blue = 0;
   digitalWrite(3,HIGH);
   analogWrite(11,0);
 }

 lastMillis = millis();
 fail = false;

 Serial.println(blue);
}
