//////////////////////////////////
/*
Basic pong game with obstacles
*/
//////////////////////////////////

ArrayList<Rectangle> rectangles = new ArrayList<Rectangle>();

float bouncingRectWidth = 20;
float bouncingRectHeight = 20;
float bouncingRectX = 400 - (bouncingRectWidth / 2);
float bouncingRectY = 300 - (bouncingRectHeight / 2);
float bouncingRectSpeedX = 4;
float bouncingRectSpeedY = 2;

int rectWidth = 20;
int paddleWidth = rectWidth;
int paddleLength = 100;
int leftPaddleX = (int)(rectWidth * 1.5);
int leftPaddleY = (600-paddleLength) / 2;
int rightPaddleX = (int)(800 - (rectWidth * 2.5));
int rightPaddleY = leftPaddleY;
int paddleSpeed = 4;
int leftScore = 0;
int rightScore = 0;

// Add paddles
Rectangle leftPaddle = new Rectangle(leftPaddleX, leftPaddleY, paddleWidth, paddleLength);
Rectangle rightPaddle = new Rectangle(rightPaddleX, rightPaddleY, paddleWidth, paddleLength);

void setup() {
  size(800, 600);
  
  rectangles.add(leftPaddle);
  rectangles.add(rightPaddle);

  
  // Add goals & walls
  rectangles.add(new Rectangle(0, 0, rectWidth, height));  // left goal
  rectangles.add(new Rectangle(width-rectWidth, 0, rectWidth, height));  // right goal
  rectangles.add(new Rectangle(0, 0, width, rectWidth));  // top wall
  rectangles.add(new Rectangle(0, height-rectWidth, width, rectWidth)); // bottom wall
  
  // Add obstacles
  rectangles.add(new Rectangle(200 + (180 * random(0, 1)) - (bouncingRectWidth / 2), 200 + (80 * random(0, 1)) - (bouncingRectWidth / 2), rectWidth, rectWidth));
  rectangles.add(new Rectangle(200 + (180 * random(0, 1)) - (bouncingRectWidth / 2), 400 - (80 * random(0, 1)) - (bouncingRectWidth / 2), rectWidth, rectWidth));
  rectangles.add(new Rectangle(600 - (180 * random(0, 1)) - (bouncingRectWidth / 2), 200 + (80 * random(0, 1)) - (bouncingRectWidth / 2), rectWidth, rectWidth));
  rectangles.add(new Rectangle(600 - (180 * random(0, 1)) - (bouncingRectWidth / 2), 400 - (80 * random(0, 1)) - (bouncingRectWidth / 2), rectWidth, rectWidth));
}

void draw() {
  background(64);
  // Draw the score
  int text_size = 100;
  textSize(text_size);
  text(leftScore, width/2 - 200, text_size + 50);
  text(rightScore, width/2 + 200, text_size + 50);
  
  
  //iterate over the paddles & obstacles
  for (int i = 0; i < rectangles.size(); i++) {
    
    //check collision for this obstacle
    Rectangle rectangle = rectangles.get(i);

    //check X movment bounce
    if (bouncingRectX + bouncingRectWidth + bouncingRectSpeedX > rectangle.x && 
      bouncingRectX + bouncingRectSpeedX < rectangle.x + rectangle.rectWidth && 
      bouncingRectY + bouncingRectHeight > rectangle.y && 
      bouncingRectY < rectangle.y + rectangle.rectHeight) {
      if (i == 0) {  // left paddle
        if (l_up) {
          bouncingRectSpeedY = -4;
        } else if (l_down) {
          bouncingRectSpeedY = 4;
        } else {
          bouncingRectSpeedY = (bouncingRectSpeedY > 0) ? 2 : -2;
        }
      } else if (i == 1) {
        if (r_up) {
          bouncingRectSpeedY = -4;
        } else if (r_down) {
          bouncingRectSpeedY = 4;
        } else {
          bouncingRectSpeedY = (bouncingRectSpeedY > 0) ? 2 : -2;
        }
      } else if (i == 2) {
        rightScore++;
        reset();
      } else if (i == 3) {
        leftScore++;
        reset();
      }
      bouncingRectSpeedX *= -1;
    }

    //check Y movement bounce
    if (bouncingRectX + bouncingRectWidth> rectangle.x && 
      bouncingRectX< rectangle.x + rectangle.rectWidth && 
      bouncingRectY + bouncingRectHeight + bouncingRectSpeedY > rectangle.y && 
      bouncingRectY + bouncingRectSpeedY < rectangle.y + rectangle.rectHeight) {
      if (i == 2) {
        rightScore++;
        reset();
      } else if (i == 3) {
        leftScore++;
        reset();
      }
      bouncingRectSpeedY *= -1;
    }

    // draw the paddles & rectangles
    if (i == 0) {
      fill(0, 255, 0);
      rect(leftPaddleX, leftPaddleY, paddleWidth, paddleLength);
    } else if (i == 1) {
      fill(0, 255, 0);
      rect(rightPaddleX, rightPaddleY, paddleWidth, paddleLength);
    } else if (i == 4 || i == 5) {
      fill(125);
      rect(rectangle.x, rectangle.y, rectangle.rectWidth, rectangle.rectHeight);
    } else {
      fill(255, 0, 0);
      rect(rectangle.x, rectangle.y, rectangle.rectWidth, rectangle.rectHeight);
    }
    
  }

  bouncingRectX += bouncingRectSpeedX;
  bouncingRectY += bouncingRectSpeedY;

  //draw the bouncing rectangle
  fill(0, 255, 0);
  rect(bouncingRectX, bouncingRectY, bouncingRectWidth, bouncingRectHeight);
  
  if (l_up) {
    leftPaddleY -= paddleSpeed;
  } else if (l_down) {
    leftPaddleY += paddleSpeed;
  }
  if (r_up) {
    rightPaddleY -= paddleSpeed;
  } else if (r_down) {
    rightPaddleY += paddleSpeed;
  }
  rectangles.get(0).y = leftPaddleY;
  rectangles.get(1).y = rightPaddleY;
  
  // prevent paddles from moving off the screen
  leftPaddleY = constrain(leftPaddleY, rectWidth, height - paddleLength - rectWidth);
  rightPaddleY = constrain(rightPaddleY, rectWidth, height - paddleLength - rectWidth);
}

class Rectangle {
  float x;
  float y;
  float rectWidth;
  float rectHeight;

  public Rectangle(float x, float y, float rectWidth, float rectHeight) {
    this.x = x;
    this.y = y;
    this.rectWidth = rectWidth;
    this.rectHeight = rectHeight;
  }
}



// RESETTING

void reset() {
  rectangles = new ArrayList<Rectangle>();
  rectangles.add(leftPaddle);
  rectangles.add(rightPaddle);

  
  // Add goals & walls
  rectangles.add(new Rectangle(0, 0, rectWidth, height));  // left goal
  rectangles.add(new Rectangle(width-rectWidth, 0, rectWidth, height));  // right goal
  rectangles.add(new Rectangle(0, 0, width, rectWidth));  // top wall
  rectangles.add(new Rectangle(0, height-rectWidth, width, rectWidth)); // bottom wall
  
  // Add obstacles
  rectangles.add(new Rectangle(200 + (180 * random(0, 1)) - (bouncingRectWidth / 2), 200 + (80 * random(0, 1)) - (bouncingRectWidth / 2), rectWidth, rectWidth));
  rectangles.add(new Rectangle(200 + (180 * random(0, 1)) - (bouncingRectWidth / 2), 400 - (80 * random(0, 1)) - (bouncingRectWidth / 2), rectWidth, rectWidth));
  rectangles.add(new Rectangle(600 - (180 * random(0, 1)) - (bouncingRectWidth / 2), 200 + (80 * random(0, 1)) - (bouncingRectWidth / 2), rectWidth, rectWidth));
  rectangles.add(new Rectangle(600 - (180 * random(0, 1)) - (bouncingRectWidth / 2), 400 - (80 * random(0, 1)) - (bouncingRectWidth / 2), rectWidth, rectWidth));
  
  bouncingRectX = 400 - (bouncingRectWidth / 2);
  bouncingRectY = 300 - (bouncingRectHeight / 2);
  bouncingRectSpeedX *= 1;
  bouncingRectSpeedY = 2;
  leftPaddleY = (height-paddleLength) / 2;
  rightPaddleY = (height-paddleLength) / 2;
}





// PRESSING & RELEASING KEYS

boolean l_up = false;
boolean l_down = false;
boolean r_up = false;
boolean r_down = false;

void keyPressed() {
    if (key == 'w' || key == 'W') {
      l_up = true;
    } else if (key == 's' || key == 'S') {
      l_down = true;
    }

    if (keyCode == UP) {
      r_up = true;
    } else if (keyCode == DOWN) {
      r_down = true;
    }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
      l_up = false;
    } else if (key == 's' || key == 'S') {
      l_down = false;
    }

    if (keyCode == UP) {
      //rightPaddleY -= paddleSpeed;
      r_up = false;
    } else if (keyCode == DOWN) {
      //rightPaddleY += paddleSpeed;
      r_down = false;
    }
}
