////////////////////////////////////////////////////////////
/*
Interactive Menger Carpet
*/
////////////////////////////////////////////////////////////

int NUMITERS = 2;

void setup() {
  size(800, 800);
  noLoop();
  noStroke();
}

void draw() {
  noStroke();
  background(0);
  menger(0, 0, width, NUMITERS);
  textSize(50);
  fill(0, 150, 150);
  text("Number of iterations: " + NUMITERS, width - 550, height - 50);
}

void keyPressed() {
  if (keyCode == UP) {
    NUMITERS = min(7, NUMITERS + 1);
  } else if (keyCode == DOWN) {
    NUMITERS = max(1, NUMITERS - 1);
  }
  redraw();
}

void menger(float x, float y, float side, int iter) {
  fill(255);
  float third = side / 3.0;

  if (iter == 1) {
    square(x + third, y + third, third);  // Draw non-central squares
  } else if (iter > 1) {
    for (int i = 0; i < 3; ++i) {
      for (int j = 0; j < 3; ++j) {
        // Don't draw the central square
        if (i != 1 || j != 1) {
          menger(x + third * i, y + third * j, third, iter - 1);
        } else {
          square(x + third, y + third, third);
        }
      }
    }
  }
}
