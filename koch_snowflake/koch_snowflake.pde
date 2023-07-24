////////////////////////////////////////////////////////////
/*
Interactive Koch Snowflake
*/
////////////////////////////////////////////////////////////

int NUMITERS = 2;

void setup() {
  size(800, 800);
  background(255);
  stroke(0);
}

void draw() {
  background(255);
  float initialLength = width/1.5;
  float startX = width/2 - initialLength/2;
  float startY = height/2 + sqrt(3)*initialLength/6;
  KochLine(startX, startY, startX + initialLength, startY, NUMITERS);
  KochLine(startX + initialLength, startY, startX + initialLength/2, startY - sqrt(3)*initialLength/2, NUMITERS);
  KochLine(startX + initialLength/2, startY - sqrt(3)*initialLength/2, startX, startY, NUMITERS);
  fill(0);
  textSize(25);
  text("UP/DOWN to increase/decrease # of iterations", 50, 50);
  textSize(50);
  text("Number of iterations: " + NUMITERS, 50, height-50);
}

void keyPressed() {
  if (keyCode == UP) {
    NUMITERS = min(8, NUMITERS + 1);
  } else if (keyCode == DOWN) {
    NUMITERS = max(1, NUMITERS - 1);
  }
}

void KochLine(float x1, float y1, float x2, float y2, int iter) {
  /* recursive function drawing a Koch line */
  float dx = x2 - x1;
  float dy = y2 - y1;
  float dist = sqrt(dx*dx + dy*dy);
  float unit = dist/3.0;
  
  if (iter == 1) {
    line(x1, y1, x2, y2);
  } else if (iter > 1) {
    float angle = atan2(dy, dx);
    /*
    midpt1 is one quarter of the way from point 1 to point 2
    midpt2 is halfway
    midpt3 is 3/4 of the way.
    */
    float midpt1_x = x1 + unit*cos(angle);
    float midpt1_y = y1 + unit*sin(angle);
    float midpt2_x = midpt1_x + unit*cos(angle + PI/3);
    float midpt2_y = midpt1_y + unit*sin(angle + PI/3);
    float midpt3_x = x1 + 2*unit*cos(angle);
    float midpt3_y = y1 + 2*unit*sin(angle);
    
    // recursive calls for each of the 4 parts of the Koch Line
    KochLine(x1, y1, midpt1_x, midpt1_y, iter - 1);
    KochLine(midpt1_x, midpt1_y, midpt2_x, midpt2_y, iter - 1);
    KochLine(midpt2_x, midpt2_y, midpt3_x, midpt3_y, iter - 1);
    KochLine(midpt3_x, midpt3_y, x2, y2, iter - 1);
  }
}
