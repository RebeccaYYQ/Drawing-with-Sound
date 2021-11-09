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
