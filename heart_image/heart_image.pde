import processing.serial.*;

Serial port;
float data = 0;
int h = 0;

PImage image = loadImage("http://www.pngmart.com/files/1/3D-Red-Heart-PNG-Image.png", "png");

void setup() {
 size(1000, 1000);
 
 port = new Serial(this, "/dev/cu.usbmodem14111", 115200);
 port.bufferUntil('\n');
 
 background(255, 0, 0);
 imageMode(CENTER);
}

void draw() { 
  background(255, 0, 255);
  
  int imgWidth = int(data);
  
  try {
    image(image, width / 2, height / 2, imgWidth, imgWidth);
  } catch (Exception e) {
    println("Error...");
  }
  
  println(data);
}

void serialEvent (Serial port) {
  try {
    data = float(port.readStringUntil('\n'));
  } catch (Exception e) {
    println("Connection...");
  }
}