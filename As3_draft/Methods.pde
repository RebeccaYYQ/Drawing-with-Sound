void drawGUI() {
  background(255);
  stroke(0);
  fill(255, 0, 0);
  rect(column1, bottomRowY, boxSize, boxSize);
  fill(0, 255, 0);
  rect(column2, bottomRowY, boxSize, boxSize);
  fill(0, 0, 255);
  rect(column3, bottomRowY, boxSize, boxSize);
  fill(0);
  rect(column4, bottomRowY, boxSize, boxSize);
  fill(255);
  rect(column5, bottomRowY, boxSize, boxSize);
  fill(0);
  text("Clear", column5+1, bottomRowY+19);
  fill(255, 255,0);
  rect(column1, topRowY, boxSize, boxSize);
  fill(255, 0, 255);
  rect(column2, topRowY, boxSize, boxSize);
  fill(0, 255, 255);
  rect(column3, topRowY, boxSize, boxSize);
  
  fill(255);
  rect(655, topRowY, boxSize, boxSize);
  fill(0);
  text("Save", 655+1, 410+19);

  line(0, topRowY-15, width, topRowY-15);
}

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

void drawNewGUI() {
  println("new Screen");
  background(255);
  img = loadImage("filler.png");
  image(img, 0, 0);
  stroke(0);
  fill(255);
  rect(0, topRowY-15, 700, 500);
  rect(column5, topRowY, boxSize, boxSize);
  fill(0);
  text("Neg", column5+2, topRowY+19);
}

void negativeImg() {
  println("negative");
  background(255);
  img = loadImage("negative.png");
  image(img, 0, 0);
  stroke(0);
  fill(255);
  rect(0, topRowY-15, 700, 500);
  rect(column5, topRowY, boxSize, boxSize);
  fill(0);
  text("Neg", column5+2, topRowY+19);
}
