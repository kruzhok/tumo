import processing.serial.*;
Serial port;
float nextValue = 0, minimum = 1023, maximum = 0;
int sizeRect = 500, cnt = 0;

String s, min, max;

FloatList oscill;

void setup()
{
size(1000, 500);
port = new Serial(this, "/dev/cu.wchusbserial1420", 115200);
port.bufferUntil('\n');
oscill = new FloatList();
s = new String("no data");
min = new String("min");
max = new String("max");
textSize(18);
}

void draw()
{
  background(0);
  stroke(50);
  fill(50);
  rect(0,0,sizeRect,sizeRect-(maximum*sizeRect/1023));
  rect(0,sizeRect-(minimum*sizeRect/1023),sizeRect,(minimum*sizeRect/1023));
  stroke(255);
  fill(255);
  text(s, 10, 30);
  text(min, 10, 50);
  text(max, 10, 70);
  
  for (int i=0; i<oscill.size()-2; ++i) {
    line(i, (sizeRect-(oscill.get(i)*sizeRect/1023)), i+1, (sizeRect-(oscill.get(i+1)*sizeRect/1023)));
  }

}

void serialEvent (Serial port)
{
try {
  nextValue = float(port.readStringUntil('\n'));
  if(cnt > 100)
  {
    if (nextValue > maximum) maximum = nextValue;
    if (nextValue < minimum) minimum = nextValue;
  }
  s= "current: "+int(nextValue);
  min = "min: "+int(minimum);
  max = "max: "+int(maximum);
  cnt++;
  
  if (!(oscill.size()<sizeRect)) {
    oscill.remove(0);
   }

  oscill.append(nextValue);
} catch (Exception e) {
  println("Connection...");
}

}

void mouseClicked()
{
  minimum = 1023;
  maximum = 0;
}

void stop()
{
port.clear();
port.stop();
}