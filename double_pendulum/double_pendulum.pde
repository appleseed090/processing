////////////////////////////////////////////////////////////
/* 
Animation for double pendulum
Mass at end of two rods
Tracing out path
*/
////////////////////////////////////////////////////////////

// Constants
float g = 9.81/60; // gravity (adjusted for frame rate)

// Pendulum properties
float l1 = 150; // length of arm 1
float l2 = 150;  // length of arm 2
float m1 = 10;  // mass at pivot
float m2 = 10;  // mass at end
float a1 = PI/2; // initial angle of arm 1
float a2 = PI/2; // initial angle of arm 2
float a1_v = 0;  // initial angular velocity of arm 1
float a2_v = 0;  // initial angular velocity of arm 2

// For the trace
ArrayList<PVector> trace = new ArrayList<PVector>();

void setup() {
  size(800, 800);
  frameRate(60);
}

void draw() {
  background(0);
  translate(width/2, height/2); // re-center coordinate system
  fill(255);
  
  /* 
  Find acceleration for both angles
  Source: http://www.maths.surrey.ac.uk/explore/michaelspages/Double.htm
  */
  
  // acceleration for angle 1
  float num1Term1 = -m2 * cos(a1-a2) * l1 * (a1_v*a1_v) * sin(a1-a2);
  float num1Term2 = m2 * cos(a1-a2) * g * sin(a2);
  float num1Term3 = -m2 * l2 * (a2_v*a2_v) * sin(a1-a2);
  float num1Term4 = -(m1+m2) * g * sin(a1);
  float num1 = num1Term1 + num1Term2 + num1Term3 + num1Term4;
  float denom1 = l1 * (m1 + m2 - (m2 * cos(a1-a2) * cos(a1-a2)));
  float a1_a = num1 / denom1;
  
  // acceleration for angle 2
  float num2Term1 = l1 * (a1_v*a1_v) * sin(a1-a2);
  float num2Term2 = (a2_v*a2_v) * sin(a1-a2) * cos(a1-a2) * m2 * l2 / (m1+m2);
  float num2Term3 = cos(a1-a2) * g * sin(a1);
  float num2Term4 = -g * sin(a2);
  float num2 = (m1+m2) * (num2Term1 + num2Term2 + num2Term3 + num2Term4);
  float denom2 = l2 * (m1 + (m2 * sin(a1-a2) * sin(a1-a2)));
  float a2_a = num2 / denom2;
  
  // update velocities and angles
  a1_v += a1_a;
  a2_v += a2_a;
  a1 += a1_v;
  a2 += a2_v;
  
  // draw arm 1
  float x1 = l1 * sin(a1);
  float y1 = l1 * cos(a1);
  stroke(255);
  line(0, 0, x1, y1);
  circle(x1, y1, 10);

  // draw arm 2
  float x2 = x1 + l2 * sin(a2);
  float y2 = y1 + l2 * cos(a2);
  line(x1, y1, x2, y2);
  circle(x2, y2, 10);
  circle(x1, y1, 10);

  // draw path (appending new points and deleting old ones)
  trace.add(new PVector(x2, y2));
  if (trace.size() > 500) {
    trace.remove(0);  // removes path once there are >500 points
  }
  strokeWeight(3);
  stroke(100, 255, 100, 100);
  noFill();
  beginShape();
  for (PVector v : trace) {
    vertex(v.x, v.y);
  }
  endShape();
}
