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
