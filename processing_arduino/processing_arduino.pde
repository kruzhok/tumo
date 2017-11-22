import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

void setup() {
  size(500, 500);
  
  arduino = new Arduino(this, "/dev/cu.usbmodem14111", 57600);
  
  arduino.pinMode(13, Arduino.OUTPUT);
  arduino.pinMode(0, Arduino.INPUT);
  arduino.pinMode(1, Arduino.INPUT);
}

void draw() {
  int a = arduino.analogRead(0);
  int b = arduino.analogRead(1);
  println(a);
  println(b);
}