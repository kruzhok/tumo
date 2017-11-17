import processing.serial.*;

Serial port;
float data = 0;

void setup() {
 size(1000, 1000);
 
 port = new Serial(this, "/dev/cu.usbmodem14111", 115200);
 port.bufferUntil('\n');
}

void draw() {
  background(map(data, 0, 1023, 0, 255));
  
  println(data);
}

void serialEvent (Serial port) {
  try {
    data = float(port.readStringUntil('\n'));
  } catch (Exception e) {
    println("Connection...");
  }
}