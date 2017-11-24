import processing.serial.*;
import cc.arduino.*;
import processing.sound.*;
import gifAnimation.*;

Arduino arduino;

SoundFile file1;

String[] songs = {"1.mp3", "2.mp3", "3.mp3", "4.mp3", "5.mp3"};

int x=0;
int value = 0;
int previousValue = 0;

boolean isPlaying = false;
boolean isSwitching = false;

Gif myAnimation;
PFont myFont;

void setup() {
  size(1000, 1000);
  background(0);
  fill(255);
  imageMode(CENTER);

  arduino = new Arduino(this, "/dev/cu.usbmodem14611", 57600);
  
  arduino.pinMode(13, Arduino.OUTPUT);
  arduino.pinMode(0, Arduino.INPUT);
  arduino.pinMode(1, Arduino.INPUT);
  
  file1 = new SoundFile(this, songs[0]);

  myAnimation = new Gif(this, "ball.gif");
  myFont = createFont("Arial", 72);
  textFont(myFont);
  textMode(CENTER);
  textAlign(CENTER, CENTER);
}      

void draw() {
   int value = arduino.analogRead(0); // sound
   int light = arduino.analogRead(1); // light
   println("Light: ", light, " Sound: ", value);
 
   if (light >= 550) {
     myAnimation.play();
     background(0);
     text(songs[x], width / 2, height / 4 * 3);
     image(myAnimation, width / 2, height / 2);

     if (isPlaying == false) {
       file1.play();
       isPlaying = true;
     }
     
      if (value >= 40 && previousValue < 40) {
        if (!isSwitching) {
          isSwitching = true;
        }

        file1.stop();
        x++;

        if(x == songs.length) {
          x = 0;
        }

        background(0);
        text(songs[x], width / 2, height / 4 * 3);

        file1 = new SoundFile(this, songs[x]);
        file1.play();
      } else {
        if (isSwitching) {
          isSwitching = false;
        }
      }    
   } else {
     if (isPlaying == true){
       isPlaying = false;
       file1.stop();
     }
     background(0);
     text("No party", width / 2, height / 2);
   }

  previousValue = value;
}