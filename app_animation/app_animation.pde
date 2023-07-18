////////////////////////////////////////////////////////////
/* 
Animation for app icons.
When app is moused over, the circle grows.
Otherwise it shrinks back to its original size.
*/
////////////////////////////////////////////////////////////


//int[] x = new int[30];
//int[] y = new int[30];
Circle[] circles = new Circle[30];

void setup() {
  size(800, 800);
  for (int i = 0; i < 30; i++) {
    circles[i] = new Circle(0.0, 0.0, (float)(width / 8));
  }
  for(int i = 0; i < 6; i++) {
    for(int j = 0; j < 5; j++) {
      Circle circle = circles[(5*i)+j];
      circle.y = -300 + (150 * i);
      circle.x = -300 + (150 * j);
    }
  }
  for(int i = 0; i < 6; i++) {
    if(i % 2 == 1) {
      for(int j = 0; j < 5; j++) {
        circles[(5*i)+j].x += 50;
      }
    }
    else {
      for(int j = 0; j < 5; j++) {
        circles[(5*i)+j].x -= 25;
      }
    }
  }
}


void draw() {
  background(50);
  translate(width/2, height/2);
  fill(255);
  //for(int i = 0; i < 6; i++) {
  //  for(int j = 0; j < 5; j++) {
  //    ellipse(x[(5*i)+j], y[(5*i)+j], 5, 5);
  //  }
  //}
  for (int i = 0; i < 30; i++) {
    Circle c = circles[i];
    c.drawCircle();
    c.adjustSize();
  }
}


// TODO: Make the circle into a class

class Circle {
  float minDiam = width / 8;
  float maxDiam = minDiam * 1.25;
  float circleDiam;
  float x = 0;
  float y = 0;
  
  public Circle(float x, float y, float circleDiam) {
    this.x = x;
    this.y = y;
    this.circleDiam = circleDiam;
  }
  
  void adjustSize() {
    float mouseXTranslated = mouseX - width / 2;
    float mouseYTranslated = mouseY - height / 2;
    if (dist(mouseXTranslated, mouseYTranslated, this.x, this.y) < this.circleDiam / 2) {
      if(circleDiam < maxDiam) this.circleDiam += 5;
    }
    else {
      if(this.circleDiam > minDiam) this.circleDiam -= 5;
    }
  }
  
  void drawCircle() {
    fill(100, 150, 100);
    circle(this.x, this.y, this.circleDiam);
  }
}
