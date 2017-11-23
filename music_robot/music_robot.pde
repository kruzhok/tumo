import processing.sound.*;
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
Serial port;

SoundFile file1;
SoundFile file2;
SoundFile file3;

String[] songs = {"1.mp3", "2.mp3","3.mp3","4.mp3","5.mp3"};

boolean isPlaying = false;
boolean isSwitching = false;

int x = 0;
int value = 0;
int previousValue = 0;

void setup() {
  size(640, 360);
  background(255);
  
  arduino = new Arduino(this, "/dev/cu.usbmodem1411", 57600);
  
  arduino.pinMode(13, Arduino.OUTPUT);
  arduino.pinMode(0, Arduino.INPUT);
  arduino.pinMode(1, Arduino.INPUT);

  file1 = new SoundFile(this, songs[0]);
}      

void draw() {
   int value = arduino.analogRead(0);
   int abc = arduino.analogRead(1);

   if(abc>=850){
     if (!isPlaying) {
       file1.play();
       isPlaying = true;
     }

    if (value >= 35 && previousValue < 35) {
      if (!isSwitching) {
        isSwitching = true;
      }
      file1.stop();
      x++;

      if(x == (songs.length - 1)) {
        x=0;
      }
      file1 = new SoundFile(this, songs[x]);
      file1.play();
    } else {
      if (isSwitching) {
        isSwitching = false;
      }
    }

  } else {
    if (isPlaying) {
       file1.stop();
       isPlaying = false;
    }
  }

  previousValue = value;
}