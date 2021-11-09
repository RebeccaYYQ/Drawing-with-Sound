void drawGUI() {
  background(255);
  //the line that seperates GUI from drawing window
  line(0, topRowY-15, width, topRowY-15);

  stroke(0);
  //----------COLOURS
  //yellow
  fill(255, 255, 0);
  rect(column1, topRowY, boxSize, boxSize);
  //pink
  fill(255, 0, 255);
  rect(column2, topRowY, boxSize, boxSize);
  //cyan
  fill(0, 255, 255);
  rect(column3, topRowY, boxSize, boxSize);
  //--------------------------------------------------Filler
  fill(255);
  rect(column4, topRowY, boxSize, boxSize);
  fill(255);
  rect(column5, topRowY, boxSize, boxSize);
  fill(255);
  rect(column6, topRowY, boxSize, boxSize);
  //red
  fill(255, 0, 0);
  rect(column1, bottomRowY, boxSize, boxSize);
  //green
  fill(0, 255, 0);
  rect(column2, bottomRowY, boxSize, boxSize);
  //blue
  fill(0, 0, 255);
  rect(column3, bottomRowY, boxSize, boxSize);
  //black
  fill(0);
  rect(column4, bottomRowY, boxSize, boxSize);
  //'clear' button
  fill(255);
  rect(column5, bottomRowY, boxSize, boxSize);
  fill(0);
  text("Clear", column5+1, bottomRowY+19);
  //--------------------------------------------------Filler
  fill(255);
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
  if (arrayPos > 48) {
    arrayPos = 48;
  }

  return arrayPos;
}
