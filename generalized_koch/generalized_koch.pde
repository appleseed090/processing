////////////////////////////////////////////////////////////
/*
Interactive Generalized Koch Curve
NOTE: NUMSIDES = 6 creates the same fractal as NUMSIDES = 3.
*/
////////////////////////////////////////////////////////////

int NUMITERS = 2;
int NUMSIDES = 3;

void setup() {
  size(800, 800);
  background(255);
  stroke(0);
}

void draw() {
  background(255);
  translate(width/2, height/2);
  float angleShift = 2 * PI / NUMSIDES;
  float radius = width * 0.3;
  ArrayList<PVector> coords = new ArrayList<PVector>();
  float coordX;
  float coordY;
  for (int i = 0; i < NUMSIDES; i++) {
    coordX = radius * cos(angleShift * i);
    coordY = radius * sin(-angleShift * i);
    coords.add(new PVector(coordX, coordY));
  }
  coords.add(new PVector(radius, 0));
  PVector currentCoord;
  PVector nextCoord;
  float currentX;
  float currentY;
  float nextX;
  float nextY;
  for (int i = 0; i < NUMSIDES; i++) {
    currentCoord = coords.get(i);
    nextCoord = coords.get((i+1)%NUMSIDES);
    currentX = currentCoord.x;
    currentY = currentCoord.y;
    nextX = nextCoord.x;
    nextY = nextCoord.y;
    KochLine(currentX, currentY, nextX, nextY, NUMITERS);
  }
  fill(0);
  textSize(25);
  text("UP/DOWN to increase/decrease # of iterations", 50 - width/2, 50 - height/2);
  text("Number of sides: " + NUMSIDES, 50 - width/2, height/2-75);
  text("Number of iterations: " + NUMITERS, 50 - width/2, height/2-25);
}

void keyPressed() {
  if (keyCode == UP) {
    NUMITERS = min(6, NUMITERS + 1);
  } else if (keyCode == DOWN) {
    NUMITERS = max(1, NUMITERS - 1);
  } else if (keyCode == LEFT) {
    NUMSIDES = max(3, NUMSIDES - 1);
  } else if (keyCode == RIGHT) {
    NUMSIDES = min(6, NUMSIDES + 1);
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
    float external_angle = PI - ((NUMSIDES - 2) * PI) / NUMSIDES;
    float current_angle = angle - PI;
    float p1_x = x1 + unit*cos(angle);
    float p1_y = y1 + unit*sin(angle);
    float p2_x;
    float p2_y;
    KochLine(x1, y1, p1_x, p1_y, iter - 1);
    for (int i = 0; i < NUMSIDES - 1; i++) {
      current_angle -= external_angle;
      p2_x = p1_x + unit*cos(current_angle);
      p2_y = p1_y + unit*sin(current_angle);
      KochLine(p1_x, p1_y, p2_x, p2_y, iter - 1);
      p1_x = p2_x;
      p1_y = p2_y;
    }
    KochLine(p1_x, p1_y, x2, y2, iter - 1);
  }
}
