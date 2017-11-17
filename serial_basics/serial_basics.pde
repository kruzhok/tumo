import processing.serial.*;

Serial port;
String data;

void setup() {
  size(1000, 1000);
  
  port = new Serial(this, "/dev/cu.usbmodem14111", 115200);
}

void draw() {
  if (data != null) {
    background(map(float(data), 0, 1023, 255, 0));
    println(data);
  }
}

void serialEvent(Serial port) {
  if (port.available() > 0) {
    data = port.readStringUntil('\n');
  }
}
