import processing.sound.*;

FFT fft;
AudioIn in;
int bands = 512;
float[] spectrum = new float[bands];

//for drawing lines
int prevY = 0;
int tempY = 0;
int currentY = 0;

//for changing colour
int r = 0;
int g = 0;
int b = 0;

//for the UI
int boxSize = 30;
int gapBetween = 15;

//for the UI boxes. Left to right
int column1 = gapBetween; 
int column2 = column1 + boxSize + gapBetween; 
int column3 = column2 + boxSize + gapBetween; 
int column4 = column3 + boxSize + gapBetween;
int column5 = column4 + boxSize + gapBetween;
int column6 = column5 + boxSize + gapBetween;
int column7 = column6 + boxSize + gapBetween;
int column8 = column7 + boxSize + gapBetween;
int column9 = column8 + boxSize + gapBetween;
int column10 = column9 + boxSize + gapBetween;
int column11 = column10 + boxSize + gapBetween;
int column12 = column11 + boxSize + gapBetween;
int column13 = column12 + boxSize + gapBetween;
int column14 = column13 + boxSize + gapBetween;
int column15 = column14 + boxSize + gapBetween;

//remember the save button

int bottomRowY = 455;
int topRowY = bottomRowY - boxSize - gapBetween;

//second stage
PImage img;

void setup() {
  size(690, 500);
  // Create an Input stream 
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);

  // start the Audio Input
  in.start();
  fft.input(in);

  drawGUI();
}      

void draw() { 
  //background(255);
  fft.analyze(spectrum);
  //getMax(spectrum);

  prevY = currentY;
  tempY = getPos(spectrum);
  currentY = (int)map(tempY, 0, 48, topRowY-15, 10);

  //drawing to the screen
  stroke(r, g, b);
  if (mousePressed) {
    //if the mouse is below the drawable area, don't draw
    if (mouseY < topRowY-15) {
      line(mouseX, currentY, pmouseX, prevY);
    }
  }
}

//UI stuff
void mousePressed() {  
    if (mouseX > column1 && mouseX < column1+boxSize && mouseY > bottomRowY && mouseY <bottomRowY+boxSize) {
    //println("Red");
    r = 255;
    g = 0;
    b = 0;
  } else if (mouseX > column2 && mouseX < column2+boxSize && mouseY > bottomRowY && mouseY <bottomRowY+boxSize) {
    //println("green");
    r = 0;
    g = 255;
    b = 0;
  } else if (mouseX > column3 && mouseX < column3+boxSize && mouseY > bottomRowY && mouseY <bottomRowY+boxSize) {
    //println("blue");
    r = 0;
    g = 0;
    b = 255;
  } else if (mouseX > column4 && mouseX < column4+boxSize && mouseY > bottomRowY && mouseY <bottomRowY+boxSize) {
    //println("black");
    r = 0;
    g = 0;
    b = 0;
  } else if (mouseX > column5 && mouseX < column5+boxSize && mouseY > bottomRowY && mouseY <bottomRowY+boxSize) {
    //println("clear");
    drawGUI();
  }
}
