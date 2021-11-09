/*
Program to record a drawing, and then replays it. Clicking the top left corner will replay.
Doesn't really work if you stop clicking, and then click again elsewhere - will draw a line in between
those points. 

Potential fix: add something like lineX.add(999) and then a check to see if its 999
*/

import java.util.*;

boolean firstStage = true;

//Below variables for the replay function
List<Integer> lineX = new ArrayList<Integer>();
List<Integer> lineY = new ArrayList<Integer>();
int linesToDraw = 1;
int timeSinceLastLine;

void setup() {
  size(640, 360);
  background(102);
  fill(255, 0, 0);
  rect(0, 0, 50, 50);
  stroke(255);
}

void draw() {
  if (firstStage) {
    if (mousePressed == true) {
      line(mouseX, mouseY, pmouseX, pmouseY);
      //println(mouseX, pmouseX);
      //WILL ADD MOUSE CLICKS IN THE buttons so beware
      lineX.add(mouseX);
      lineY.add(mouseY);
    }
  } else {
    /*
    the code below for drawing something in set time increments is adapted from Chrisir's code, 
     3rd post on https://forum.processing.org/one/topic/trying-to-delay-a-loop.html
     */

    //refresh the screen
    background(102);

    //drawing the first line so there isn't an OutOfBounds error in the for loop below
    line(lineX.get(0), lineY.get(0), lineX.get(0), lineY.get(0));

    //the loop to replay the lines, based on information stored in the ArrayLists.
    //linesToDraw variable limits the amount that can be drawn
    for (int i = 1; i < linesToDraw; i++) {
      line(lineX.get(i), lineY.get(i), lineX.get(i-1), lineY.get(i-1));
    }

    //if current time - timeSinceLast is greater than 50ms, increment linesToDraw and reset timeSinceLastDraw
    if (millis ()- timeSinceLastLine >= 50) {
      timeSinceLastLine = millis();
      linesToDraw++;
    }
    //catch to prevent OutOfBounds error, and end the loop to prevent constant redraws
    if (linesToDraw > lineX.size() ) {
      linesToDraw=lineX.size();
      println("replay end");
      noLoop();
    }

    /*
    end of adapting someone's code
     */
  }
}

//if the top left corner is selected
void mousePressed() {
  if (mouseX < 50 && mouseY <50) {
    //if its still the first stage, trigger the second stage
    if (firstStage) {
      //clear screen
      background(102);

      //triggers the second stage, and sets the current time
      firstStage = false;
      timeSinceLastLine = millis();
    }
    //if its the second stage, replay the loop
    else {
      linesToDraw = 1;
      loop();
    }
  }
}

//old code when I tried another way to do the delay. doesn't work
void replay() {
  stroke(255);
  //the first line
  line(lineX.get(0), lineY.get(0), lineX.get(0), lineY.get(0)); 
  //try {
  //  for (int i = 1; i < lineX.size(); i++) {

  //    //println(lineX.get(i), lineY.get(i));
  //    line(lineX.get(i), lineY.get(i), lineX.get(i-1), lineY.get(i-1));
  //    println("drawn");
  //  }
  //  Thread.sleep(1000);
  //}
  //catch (InterruptedException ex) {
  //  //catch
  //}
  println("for loop finished");
}
