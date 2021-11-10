void drawGUI() {
  background(255);
  stroke(0);
  
  //the line that seperates GUI from drawing window
  line(0, topRowY-15, width, topRowY-15);
  
  //----------COLOURS
  fill(254, 39, 18); //red
  rect(column1, topRowY, boxSize, boxSize);
  fill(253, 83, 8); //red-orange
  rect(column2, topRowY, boxSize, boxSize);
  fill(251, 153, 2); //orange
  rect(column3, topRowY, boxSize, boxSize);
  fill(249, 188, 2); //orange-yellow
  rect(column4, topRowY, boxSize, boxSize);
  fill(255, 254, 50); //yellow
  rect(column5, topRowY, boxSize, boxSize);
  fill(208, 233, 43); //light green
  rect(column6, topRowY, boxSize, boxSize);
  fill(102,177,50); //green
  rect(column1, bottomRowY, boxSize, boxSize);
  fill(2,145,205); //light blue
  rect(column2, bottomRowY, boxSize, boxSize);
  fill(2,71,254); //blue
  rect(column3, bottomRowY, boxSize, boxSize);
  fill(62,1,164); //blue-purple
  rect(column4, bottomRowY, boxSize, boxSize);
  fill(134,1,176); //purple
  rect(column5, bottomRowY, boxSize, boxSize);
  fill(167,25,75); //purple-red
  rect(column6, bottomRowY, boxSize, boxSize);

  //----------LINE THICKNESS AND SHAPE
  fill(255);
  stroke(0);
  //default/very thin
  rect(column8, topRowY, boxSize, boxSize);
  line(column8+15, topRowY+15, column8+15, topRowY+15);
  //thin
  rect(column9, topRowY, boxSize, boxSize);
  strokeWeight(4);
  line(column9+15, topRowY+15, column9+15, topRowY+15);
  //medium
  strokeWeight(1);
  rect(column10, topRowY, boxSize, boxSize);
  strokeWeight(8);
  line(column10+15, topRowY+15, column10+15, topRowY+15);
  //thick
  strokeWeight(1);
  rect(column11, topRowY, boxSize, boxSize);
  strokeWeight(12);
  line(column11+15, topRowY+15, column11+15, topRowY+15);
  //very thick
  strokeWeight(1);
  rect(column12, topRowY, boxSize, boxSize);
  strokeWeight(16);
  line(column12+15, topRowY+15, column12+15, topRowY+15);
  strokeWeight(1);
  
  //square
  strokeCap(SQUARE);
  //default/very thin
  rect(column8, bottomRowY, boxSize, boxSize);
  line(column8+15, bottomRowY+15, column8+16, bottomRowY+15);
  //thin
  rect(column9, bottomRowY, boxSize, boxSize);
  strokeWeight(4);
  line(column9+13, bottomRowY+15, column9+17, bottomRowY+15);
  //medium
  strokeWeight(1);
  rect(column10, bottomRowY, boxSize, boxSize);
  strokeWeight(8);
  line(column10+11, bottomRowY+15, column10+19, bottomRowY+15);
  //thick
  strokeWeight(1);
  rect(column11, bottomRowY, boxSize, boxSize);
  strokeWeight(12);
  line(column11+9, bottomRowY+15, column11+21, bottomRowY+15);
  //very thick
  strokeWeight(1);
  rect(column12, bottomRowY, boxSize, boxSize);
  strokeWeight(16);
  line(column12+7, bottomRowY+15, column12+23, bottomRowY+15);
  
  //----------MENU
  strokeWeight(1);
  strokeCap(ROUND);
  //replay
  rect(column14, topRowY, boxSize, boxSize);
  //stop
  rect(column14, bottomRowY, boxSize, boxSize);
  //save
  rect(column15, topRowY, boxSize, boxSize);
  fill(0);
  text("Re- play", column14+4, topRowY+2, boxSize, boxSize);
  text("Stop", column14+3, bottomRowY+19);
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

  return arrayPos;
}

//DISUSED METHODS AND CODE SNIPPETS
//code that was used for testing, debugging, etc. Keeping here in case I need again

//get the max and its position, specifically for the spectrum array
void getMax(float[] array) {
  float max = array[0];
  int arrayPos = 0;

  for (int i = 1; i < bands; i++) {
    if (array[i] > max) {
      max = array[i];
      arrayPos = i;
    }
  }

  println("[" + arrayPos + "]" + " " + max);
}

/* old draw function, that lets you draw as you click
   //background(255);
   fft.analyze(spectrum);
   //getMax(spectrum);
   
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
   }
   */
