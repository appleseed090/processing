////////////////////////////////////////////////////////////
/* 
V2 of circumcenter
Moves each point on the triangle to a new random position
every 3 seconds.
*/
////////////////////////////////////////////////////////////
float circleRadius = 200;
PVector[] vertices = new PVector[3];
float[] targetAngles = new float[3];
int currentVertex = -1;
int frameCounter = 0;

void setup() {
  size(500, 500);
  
  // Initialise the vertices positions on the circle
  for (int i = 0; i < vertices.length; i++) {
    float angle = map(i, 0, vertices.length, 0, TWO_PI);
    vertices[i] = new PVector(circleRadius * cos(angle), circleRadius * sin(angle));
    targetAngles[i] = angle;
  }
}

void draw() {
  background(0); // Set the background to gray
  translate(width/2, height/2); // Move the origin to the center
  stroke(255); // Set the line color to white
  
  // Draw the circle
  noFill();
  ellipse(0, 0, circleRadius*2, circleRadius*2);

  // Every 5 seconds, change the target angles
  if (frameCounter % (3 * 60) == 0) {
    for (int i = 0; i < vertices.length; i++) {
      targetAngles[i] += random(-PI, PI);
    }
  }
  frameCounter++;

  fill(255);
  // Move and draw the vertices
  for (int i = 0; i < vertices.length; i++) {
    float currentAngle = atan2(vertices[i].y, vertices[i].x);
    targetAngles[i] = currentAngle + smallestAngleDifference(currentAngle, targetAngles[i]);
    float newAngle = lerp(currentAngle, targetAngles[i], 0.05); // Adjust the 0.05 to make the movement faster or slower
    vertices[i] = new PVector(circleRadius * cos(newAngle), circleRadius * sin(newAngle));
    ellipse(vertices[i].x, vertices[i].y, 10, 10);
  }

  // Draw the center of the circle
  ellipse(0, 0, 10, 10);
  
  // Check if the triangle contains the center of the circle
  if (pointInTriangle(vertices[0], vertices[1], vertices[2], new PVector(0, 0))) {
    fill(0, 0, 255, 100); // Fill with blue if the center is inside the triangle
  } else {
    fill(255, 0, 0, 100); // Fill with red otherwise
  }
  // Draw the triangle
  triangle(vertices[0].x, vertices[0].y, vertices[1].x, vertices[1].y, vertices[2].x, vertices[2].y);
  //for (int i = 0; i < vertices.length; i++) {
  //  PVector v1 = vertices[i];
  //  PVector v2 = vertices[(i+1)%vertices.length];
  //  line(v1.x, v1.y, v2.x, v2.y);
  //}
}

void mousePressed() {
  // When mouse is pressed, check if it is close to a vertex
  float mouseXTranslated = mouseX - width / 2;
  float mouseYTranslated = mouseY - height / 2;
  for (int i = 0; i < vertices.length; i++) {
    if (dist(mouseXTranslated, mouseYTranslated, vertices[i].x, vertices[i].y) < 10) {
      currentVertex = i;
      break;
    }
  }
}

void mouseDragged() {
  // If a vertex is selected and the mouse is dragged, move the vertex
  if (currentVertex != -1) {
    float mouseXTranslated = mouseX - width / 2;
    float mouseYTranslated = mouseY - height / 2;
    float angle = atan2(mouseYTranslated, mouseXTranslated);
    vertices[currentVertex] = new PVector(circleRadius * cos(angle), circleRadius * sin(angle));
  }
}

void mouseReleased() {
  // When the mouse is released, deselect the vertex
  currentVertex = -1;
}

boolean pointInTriangle(PVector p0, PVector p1, PVector p2, PVector p) {
  // Compute barycentric coordinates
  PVector v0 = PVector.sub(p2, p0);  // vector from p0 to p2
  PVector v1 = PVector.sub(p1, p0);  // vector from p0 to p1
  PVector v2 = PVector.sub(p, p0);  // vector from p0 to p
  
  /* Calculate dot products
  These are used to calculate the barycentric coordinates of the circumcenter */
  float d00 = v0.dot(v0);
  float d01 = v0.dot(v1);
  float d11 = v1.dot(v1);
  float d20 = v2.dot(v0);
  float d21 = v2.dot(v1);
  
  float denom = d00 * d11 - d01 * d01;
  
  float v = (d11 * d20 - d01 * d21) / denom;
  float w = (d00 * d21 - d01 * d20) / denom;
  float u = 1.0f - v - w;
  
  // Check if point is in triangle
  return (v >= 0) && (w >= 0) && (u >= 0);
}

// Function to compute the smallest angle difference
float smallestAngleDifference(float angle1, float angle2) {
  float diff = angle2 - angle1;
  while (diff < -PI) diff += TWO_PI;
  while (diff > PI) diff -= TWO_PI;
  return diff;
}
