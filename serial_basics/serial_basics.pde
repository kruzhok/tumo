import processing.serial.*;

Serial port;
String data;

void setup() {
  size(1000, 1000); // размер холста
  
  port = new Serial(this, "/dev/cu.usbmodem14111", 115200);
}

void draw() {
  if (port.available() > 0) {
    data = port.readStringUntil('\n');
  }

  if (data != null) {
    background(map(float(data), 0, 1023, 255, 0));
    println(data);
  }
}