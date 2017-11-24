import processing.serial.*;

String[] music = {"HOLD STRONG By Rob Bailey and The Hustle Standard.mp3", "Kaleo - Way Down We Go (Official Video).mp3", "Imagine Dragons - Whatever It Takes.mp3"};
int songId;
import processing.serial.*;
import processing.sound.*;
SoundFile file;
Serial port;

float data = 0;
boolean isPlaying = false;

PFont myFont;

void setup()
{
  port = new Serial (this, "/dev/cu.usbmodem14611", 115200);
  port.bufferUntil('\n');
  size(1500, 950);
  background(0);

  songId = int(random(music.length));
  file = new SoundFile (this, music[songId]);
  file.play();
  isPlaying = true;
  
  myFont = createFont("Helvetica", 120);
  textMode(CENTER);
  textAlign(CENTER, CENTER);
  textFont(myFont);
  fill(255);
}    

int last = 0;
int m = 0;
  
void draw() {
  println(data);

  if (data > 4000) {
    if (isPlaying == true) {
      background(0, 0, 255);
      text("You win: " + str(data), width / 2, height / 2);
      file.stop();
      isPlaying = false;
    }
  } else {
    if (isPlaying) {
      background(255, 0, 0);
      if (data == data) {
        text(str(data), width / 2, height / 2);
      }
      if ((millis() > last + 10000)){
        file.stop();
        songId = int(random(music.length));
        file = new SoundFile (this, music[songId]);
        file.play();
        last = millis();
      }
    }
  }
}

  
void serialEvent(Serial port)
  {
    try{
      data = float(port.readStringUntil('\n'));
    } catch (Exception e)
    {
      println("Error");
    }
  }