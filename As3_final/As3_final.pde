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

//to switch to the second stage of transforming input data
boolean firstStage = true;

//Below variables for the replay function
List<Integer> lineX = new ArrayList<Integer>();
List<Integer> lineY = new ArrayList<Integer>();
int linesToDraw = 1;
int timeSinceLastLine;

//arrays to store changed parameters in the second stage
//i.e. if the user changes the visual appearance of the line at a certain point, store that so it can be displayed in the replay
List<Integer> lineThicknessList = new ArrayList<Integer>();
List<Integer> strokeTypeList = new ArrayList<Integer>();
List<Integer> rList = new ArrayList<Integer>();
List<Integer> gList = new ArrayList<Integer>();
List<Integer> bList = new ArrayList<Integer>();
List<Boolean> hasBeenUpdated = new ArrayList<Boolean>();

//for drawing lines
int tempY = 0;
int currentY = 0;

//for changing colour, thickness or shape
int r = 0;
int g = 0;
int b = 0;
int lineThickness = 1;
int strokeType = ROUND;

//for the UI
int boxSize = 30;
int gapBetween = 15;
int boxCurve = 10;

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

//for feedback
boolean saveNotif = false;

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
    rect(column14, bottomRowY, boxSize*2+15, boxSize, boxCurve);
    fill(0);
    text("Next", column14+25, bottomRowY+19);

    fft.analyze(spectrum);
    //getMax(spectrum);

    tempY = getPos(spectrum);
    currentY = (int)map(tempY, 0, 50, topRowY-15, 10);

    //presenting input, and storing data into the arrays
    fill(255, 0, 0);
    ellipse(mouseX, currentY, 30, 30);
    lineX.add(mouseX);
    lineY.add(currentY);
  } 
  //the second stage of presenting data. Code below is to simulate a replay feature
  else {
    //for everything in the X position array, fill the other arrays with filler values to avoid errors
    for (int i = 0; i < lineX.size(); i++) {
      lineThicknessList.add(1);
      strokeTypeList.add(ROUND);
      rList.add(0);
      gList.add(0);
      bList.add(0);
      hasBeenUpdated.add(false);
    }

    //refresh the screen
    drawGUI();

    /*
    the code below for drawing something in set time increments is adapted from Chrisir's code, 
     3rd post on https://forum.processing.org/one/topic/trying-to-delay-a-loop.html
     */

    //drawing the first line so there isn't an OutOfBounds error in the for loop below
    line(lineX.get(0), lineY.get(0), lineX.get(0), lineY.get(0));

    //the loop to redraw the lines, based on information stored in the ArrayLists.
    //linesToDraw variable limits the amount that can be drawn
    for (int i = 1; i < linesToDraw; i++) {
      //if that value has not been changed before, update it
      if (hasBeenUpdated.get(i) == false) {
        lineThicknessList.set(i, lineThickness);
        strokeTypeList.set(i, strokeType);
        rList.set(i, r);
        gList.set(i, g);
        bList.set(i, b);
        hasBeenUpdated.set(i, true);
      }
      //display the line based on stored data
      stroke(rList.get(i), gList.get(i), bList.get(i));
      strokeCap(strokeTypeList.get(i));
      strokeWeight(lineThicknessList.get(i));
      line(lineX.get(i), lineY.get(i), lineX.get(i-1), lineY.get(i-1));
    }
    //feedback text
    feedbackBox("Replaying...", 144, 255, 125);

    //if current time - timeSinceLast is greater than 50ms, increment linesToDraw and reset timeSinceLastDraw
    //to create an appearance of animation
    if (millis ()- timeSinceLastLine >= 50) {
      timeSinceLastLine = millis();
      linesToDraw++;
    }

    //catch to prevent OutOfBounds error, and end the loop to prevent constant redraws
    if (linesToDraw > lineX.size() ) {
      linesToDraw=lineX.size();
      println("replay end");
      //check to see if save is on, so feedback can be provided
      if (saveNotif) {
        feedbackBox("Image saved", 84, 217, 61);
        saveNotif = false;
      } else {
        feedbackBox("Replay finished", 255, 125, 125);
      }
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
    if (mouseX > column1 && mouseX < column1+boxSize && mouseY > topRowY && mouseY <topRowY+boxSize) {
      r = 254;  
      g = 39;  
      b = 18; //red
    } else if (mouseX > column2 && mouseX < column2+boxSize && mouseY > topRowY && mouseY <topRowY+boxSize) {
      r = 253;  
      g = 83;  
      b = 8; //red-orange
    } else if (mouseX > column3 && mouseX < column3+boxSize && mouseY > topRowY && mouseY <topRowY+boxSize) {
      r = 249;  
      g = 188;  
      b = 2; //orange
    } else if (mouseX > column4 && mouseX < column4+boxSize && mouseY > topRowY && mouseY <topRowY+boxSize) {
      r = 255;  
      g = 254;  
      b = 50; //yellow
    } else if (mouseX > column5 && mouseX < column5+boxSize && mouseY > topRowY && mouseY <topRowY+boxSize) {
      r = 208;  
      g = 233;  
      b = 43; //light green
    } else if (mouseX > column6 && mouseX < column6+boxSize && mouseY > topRowY && mouseY <topRowY+boxSize) {
      r = 102;  
      g = 177;  
      b = 50; //green
    } else if (mouseX > column1 && mouseX < column1+boxSize && mouseY > bottomRowY && mouseY <bottomRowY+boxSize) {
      r = 2;  
      g = 145;  
      b = 205; //light blue
    } else if (mouseX > column2 && mouseX < column2+boxSize && mouseY > bottomRowY && mouseY <bottomRowY+boxSize) {
      r = 2;  
      g = 71;  
      b = 254; //blue
    } else if (mouseX > column3 && mouseX < column3+boxSize && mouseY > bottomRowY && mouseY <bottomRowY+boxSize) {
      r = 62;  
      g = 1;  
      b = 164; //blue-purple
    } else if (mouseX > column4 && mouseX < column4+boxSize && mouseY > bottomRowY && mouseY <bottomRowY+boxSize) {
      r = 134;  
      g = 1;  
      b = 176; //purple
    } else if (mouseX > column5 && mouseX < column5+boxSize && mouseY > bottomRowY && mouseY <bottomRowY+boxSize) {
      r = 167;  
      g = 25;  
      b = 75; //purple-red
    } else if (mouseX > column6 && mouseX < column6+boxSize && mouseY > bottomRowY && mouseY <bottomRowY+boxSize) {
      r = 0;  
      g = 0;  
      b = 0; //black
    }

    //----------LINE THICKNESS AND SIZE
    else if (mouseX > column8 && mouseX < column8+boxSize && mouseY > topRowY && mouseY <topRowY+boxSize) {
      strokeType = ROUND;
      lineThickness = 1;
    } else if (mouseX > column9 && mouseX < column9+boxSize && mouseY > topRowY && mouseY <topRowY+boxSize) {
      strokeType = ROUND;
      lineThickness = 4;
    } else if (mouseX > column10 && mouseX < column10+boxSize && mouseY > topRowY && mouseY <topRowY+boxSize) {
      strokeType = ROUND;
      lineThickness = 8;
    } else if (mouseX > column11 && mouseX < column11+boxSize && mouseY > topRowY && mouseY <topRowY+boxSize) {
      strokeType = ROUND;
      lineThickness = 12;
    } else if (mouseX > column12 && mouseX < column12+boxSize && mouseY > topRowY && mouseY <topRowY+boxSize) {
      strokeType = ROUND;
      lineThickness = 16;
    } else if (mouseX > column8 && mouseX < column8+boxSize && mouseY > bottomRowY && mouseY <bottomRowY+boxSize) {
      strokeType = SQUARE;
      lineThickness = 1;
    } else if (mouseX > column9 && mouseX < column9+boxSize && mouseY > bottomRowY && mouseY <bottomRowY+boxSize) {
      strokeType = SQUARE;
      lineThickness = 4;
    } else if (mouseX > column10 && mouseX < column10+boxSize && mouseY > bottomRowY && mouseY <bottomRowY+boxSize) {
      strokeType = SQUARE;
      lineThickness = 8;
    } else if (mouseX > column11 && mouseX < column11+boxSize && mouseY > bottomRowY && mouseY <bottomRowY+boxSize) {
      strokeType = SQUARE;
      lineThickness = 12;
    } else if (mouseX > column12 && mouseX < column12+boxSize && mouseY > bottomRowY && mouseY <bottomRowY+boxSize) {
      strokeType = SQUARE;
      lineThickness = 16;
    }

    //----------MENU
    else if (mouseX > column14 && mouseX < column14+boxSize && mouseY > topRowY && mouseY <topRowY+boxSize) {
      println("replay");
      //reset the lineToDraw value, and start the draw loop again
      linesToDraw = 1;
      loop();
    } else if (mouseX > column15 && mouseX < column15+boxSize && mouseY > topRowY && mouseY <topRowY+boxSize) {
      println("Save an image");
      //flip it to true, so the check within the draw loop would work
      saveNotif = true;
      redraw();
      //below is so it saves a cropped image, without all the UI
      save("Drawing.png");
      PImage img = loadImage("Drawing.png");
      PImage cropped = img.get(0, 0, width, 356);
      cropped.save("Drawing.png");
    } else if (mouseX > column14 && mouseX < column14+boxSize && mouseY > bottomRowY && mouseY <bottomRowY+boxSize) {
      println("reset");
      //start the loop again, but wipe everything in the parameter lists to start fresh
      linesToDraw = 1;
      lineThicknessList.clear();
      strokeTypeList.clear();
      rList.clear();
      gList.clear();
      bList.clear();
      hasBeenUpdated.clear();
      lineThickness = 1;
      strokeType = ROUND;
      r = 0;
      g = 0;
      b = 0;
      for (int i = 0; i < lineX.size(); i++) {
        lineThicknessList.add(1);
        strokeTypeList.add(ROUND);
        rList.add(0);
        gList.add(0);
        bList.add(0);
        hasBeenUpdated.add(false);
      }
      loop();
    }
  }
}
