////////////////////////////////////////////////////////////
/*
Interactive Sierpinski Triangle
*/
////////////////////////////////////////////////////////////

int NUMITERS = 2;
float XMIN = 0;
float XMAX = width;
float YMIN = 0;
float YMAX = height;

void setup() {
  size(800, 800);
  background(255);
  stroke(0);
}

void draw() {
  background(255);
  sierpinski(0, 0, width, NUMITERS);
  fill(0);
  textSize(50);
  text("Number of iterations: " + NUMITERS, width-550, height-50);
}

void keyPressed() {
  if (keyCode == UP) {
    NUMITERS++;
  } else if (keyCode == DOWN) {
    NUMITERS = max(1, NUMITERS - 1);
  }
}

void sierpinski(float x, float y, float side, int NUMITERS) {
  /* recursive function drawing a Sierpinski triangle */
  float half = side/2;
  
  if (NUMITERS == 1) {
    triangle(x, y, x + side, y, x, y + side);
  } else if (NUMITERS > 1) {
    sierpinski(x, y, half, NUMITERS - 1);
    sierpinski(x + half, y, half, NUMITERS - 1);
    sierpinski(x, y + half, half, NUMITERS - 1);
  }
}
