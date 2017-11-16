int i = 0;
PFont font;
PImage image = loadImage("http://www.freeiconspng.com/uploads/red-brain-20.png");

void setup() {
  size(1000, 1000); // размер холста

  fill(255, 255, 255); // заливка фигуры
  background(0, 0, 255); // заливка фона
  stroke(255, 255, 0); // цвет обводки
  strokeWeight(2); // толщина обводки
  
  image.resize(300, 0);
  imageMode(CENTER);
  font = loadFont("Druk-WideSuper-180.vlw");
  textFont(font, 120);
  textAlign(CENTER, CENTER);
}

void draw() {
  i = i + 1;
  fill(mouseX, mouseY, mouseX);
  
  if (mousePressed) {
    background(0, 0, 255); // заливка фона
  }
  
  if (key == 'r') {
    rect(mouseX, mouseY, 400, 400);
  } else {
    ellipse(mouseX, mouseY, 400, 400);
  }
  
  if (i > width + 100) {
    i = -100;
  }
  
  image(image, width / 2, height / 2);
  fill(0, 0, 255);
  text("TUMO", width / 2, height / 2);
}