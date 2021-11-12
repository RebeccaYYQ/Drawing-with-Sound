void drawGUI() {
  background(255);
  strokeWeight(1);
  strokeCap(ROUND);
  //grey bg rectangle to separate UI from drawing area
  noStroke();
  fill(200);
  rect(0, topRowY-15, width, 105);

  stroke(0);
  //----------COLOURS
  fill(254, 39, 18); //red
  rect(column1, topRowY, boxSize, boxSize, boxCurve);
  fill(253, 83, 8); //red-orange
  rect(column2, topRowY, boxSize, boxSize, boxCurve);
  fill(249, 188, 2); //orange
  rect(column3, topRowY, boxSize, boxSize, boxCurve);
  fill(255, 254, 50); //yellow
  rect(column4, topRowY, boxSize, boxSize, boxCurve);
  fill(208, 233, 43); //light green
  rect(column5, topRowY, boxSize, boxSize, boxCurve);
  fill(102, 177, 50); //green
  rect(column6, topRowY, boxSize, boxSize, boxCurve);
  fill(2, 145, 205); //light blue
  rect(column1, bottomRowY, boxSize, boxSize, boxCurve);
  fill(2, 71, 254); //blue
  rect(column2, bottomRowY, boxSize, boxSize, boxCurve);
  fill(62, 1, 164); //blue-purple
  rect(column3, bottomRowY, boxSize, boxSize, boxCurve);
  fill(134, 1, 176); //purple
  rect(column4, bottomRowY, boxSize, boxSize, boxCurve);
  fill(167, 25, 75); //purple-red
  rect(column5, bottomRowY, boxSize, boxSize, boxCurve);
  fill(0); //black
  rect(column6, bottomRowY, boxSize, boxSize, boxCurve);

  fill(255);
  //----------LINE THICKNESS AND SHAPE
  //default/very thin
  rect(column8, topRowY, boxSize, boxSize, boxCurve);
  line(column8+15, topRowY+15, column8+15, topRowY+15);
  //thin
  rect(column9, topRowY, boxSize, boxSize, boxCurve);
  strokeWeight(4);
  line(column9+15, topRowY+15, column9+15, topRowY+15);
  //medium
  strokeWeight(1);
  rect(column10, topRowY, boxSize, boxSize, boxCurve);
  strokeWeight(8);
  line(column10+15, topRowY+15, column10+15, topRowY+15);
  //thick
  strokeWeight(1);
  rect(column11, topRowY, boxSize, boxSize, boxCurve);
  strokeWeight(12);
  line(column11+15, topRowY+15, column11+15, topRowY+15);
  //very thick
  strokeWeight(1);
  rect(column12, topRowY, boxSize, boxSize, boxCurve);
  strokeWeight(16);
  line(column12+15, topRowY+15, column12+15, topRowY+15);
  strokeWeight(1);

  //square
  strokeCap(SQUARE);
  //default/very thin
  rect(column8, bottomRowY, boxSize, boxSize, boxCurve);
  line(column8+15, bottomRowY+15, column8+16, bottomRowY+15);
  //thin
  rect(column9, bottomRowY, boxSize, boxSize, boxCurve);
  strokeWeight(4);
  line(column9+13, bottomRowY+15, column9+17, bottomRowY+15);
  //medium
  strokeWeight(1);
  rect(column10, bottomRowY, boxSize, boxSize, boxCurve);
  strokeWeight(8);
  line(column10+11, bottomRowY+15, column10+19, bottomRowY+15);
  //thick
  strokeWeight(1);
  rect(column11, bottomRowY, boxSize, boxSize, boxCurve);
  strokeWeight(12);
  line(column11+9, bottomRowY+15, column11+21, bottomRowY+15);
  //very thick
  strokeWeight(1);
  rect(column12, bottomRowY, boxSize, boxSize, boxCurve);
  strokeWeight(16);
  line(column12+7, bottomRowY+15, column12+23, bottomRowY+15);

  //----------MENU
  strokeWeight(1);
  strokeCap(ROUND);
  rect(column14, topRowY, boxSize, boxSize, boxCurve); //replay
  rect(column14, bottomRowY, boxSize, boxSize, boxCurve); //reset
  rect(column15, topRowY, boxSize, boxSize, boxCurve); //save
  fill(0);
  text("Re- play", column14+4, topRowY+1, boxSize, boxSize);
  text("Re- set", column14+5, bottomRowY+2, boxSize, boxSize);
  text("Save", column15+2, topRowY+19);
}

//function to get the position of the highest frequency noise
int getPos(float[] array) {
  float max = array[0];
  int arrayPos = 0;

  for (int i = 1; i < bands; i++) {
    if (array[i] > max) {
      max = array[i];
      arrayPos = i;
    }
  }
  //set some boundaries to remove noise
  if (arrayPos > 50) {
    arrayPos = 50;
  } else if (arrayPos < 5) {
    arrayPos = 5;
  }
  //println("[" + arrayPos + "]" + " " + max);
  return arrayPos;
}

//function to provide feedback in the second stage of transforming data
void feedbackBox(String text, int r, int g, int b) {
  fill(r, g, b);
  noStroke();
  rect(column14-20, topRowY-48, 150, 28);
  fill(0);
  text(text, column14-gapBetween, topRowY-30);
}

/*DISUSED CODE - used for testing, debugging, etc. Keeping here in case I need again
 
 ----old draw function, that lets you draw as you click
 //background(255);
 fft.analyze(spectrum);
 
 prevY = currentY;
 tempY = getPos(spectrum);
 currentY = (int)map(tempY, 0, 50, topRowY-15, 10);
 
 //drawing to the screen
 stroke(r, g, b);
 if (mousePressed) {
 //if the mouse is below the drawable area, don't draw
 //meant to prevent drawing due to users clicking on the UI buttons
 if (mouseY < topRowY-15) {
 line(mouseX, currentY, pmouseX, prevY);
 }
 } */
