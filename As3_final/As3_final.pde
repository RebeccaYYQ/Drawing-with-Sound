/*
Two stages: first is recording user input (sound input), and second is presenting that input data in visual form
 The presentation can be replayed, and buttons are available to change the visualisation
 i.e. change colour, line thickness, line shape
 */

import processing.sound.*;
import java.util.*;

//audio input
FFT fft;
AudioIn in;
int bands = 512;
float[] spectrum = new float[bands];

//for drawing lines
//int prevY = 0;
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

int bottomRowY = 455;
int topRowY = bottomRowY - boxSize - gapBetween;

//to switch to the second stage of transforming input data
boolean firstStage = true;

//Below variables for the replay function
List<Integer> lineX = new ArrayList<Integer>();
List<Integer> lineY = new ArrayList<Integer>();
int linesToDraw = 1;
int timeSinceLastLine;

void setup() {
  size(690, 500);
  // Create an Input stream 
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);

  // start the Audio Input
  in.start();
  fft.input(in);
}      

void draw() { 
  //for the first stage of recording
  if (firstStage) {
    background(0);
    fill(255);
    rect(column14, bottomRowY, boxSize*2+15, boxSize);
    fill(0);
    text("Next", column14+25, bottomRowY+19);

    fft.analyze(spectrum);
    //getMax(spectrum);

    tempY = getPos(spectrum);
    currentY = (int)map(tempY, 0, 50, topRowY-15, 10);

    //presenting input
    fill(255, 0, 0);
    ellipse(mouseX, currentY, 30, 30);
    lineX.add(mouseX);
    lineY.add(currentY);
  } 
  //the second stage of presenting data. Code below is to simulate a replay feature
  else {
    /*
    the code below for drawing something in set time increments is adapted from Chrisir's code, 
     3rd post on https://forum.processing.org/one/topic/trying-to-delay-a-loop.html
     */

    //refresh the screen
    drawGUI();

    //drawing the first line so there isn't an OutOfBounds error in the for loop below
    line(lineX.get(0), lineY.get(0), lineX.get(0), lineY.get(0));

    //the loop to replay the lines, based on information stored in the ArrayLists.
    //linesToDraw variable limits the amount that can be drawn
    for (int i = 1; i < linesToDraw; i++) {
      line(lineX.get(i), lineY.get(i), lineX.get(i-1), lineY.get(i-1));
    }
    //feedback text
    fill(144, 255, 125);
    noStroke();
    rect(column14-20, topRowY-48, 150, 28);
    fill(0);
    text("Replaying...", column14-gapBetween, topRowY-30);

    //if current time - timeSinceLast is greater than 50ms, increment linesToDraw and reset timeSinceLastDraw
    if (millis ()- timeSinceLastLine >= 50) {
      timeSinceLastLine = millis();
      linesToDraw++;
    }

    //catch to prevent OutOfBounds error, and end the loop to prevent constant redraws
    if (linesToDraw > lineX.size() ) {
      linesToDraw=lineX.size();
      println("replay end");
      fill(255, 125, 125);
      noStroke();
      rect(column14-20, topRowY-48, 150, 28);
      fill(0);
      text("Replay finished", column14-gapBetween, topRowY-30);
      noLoop();
    }

    /*
    end of adapting someone's code
     */
  }
}

//UI stuff
void mousePressed() {  
  //for the 'next' button' in the recording stage
  if (firstStage) {
    if (mouseX > column14 && mouseX < column15+boxSize && mouseY > bottomRowY && mouseY <bottomRowY+boxSize) {
      //println("next");
      background(255);
      drawGUI();

      //triggers the second stage, and sets the current time
      firstStage = false;
      timeSinceLastLine = millis();
    }
  }
  //for the UI options in the output stage
  else {
    //----------COLOURS
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
    }
    //----------LINE THICKNESS AND SIZE

    //----------MENU
    else if (mouseX > column14 && mouseX < column14+boxSize && mouseY > topRowY && mouseY <topRowY+boxSize) {
      println("replay");
      linesToDraw = 1;
      loop();
    }
  }
}
