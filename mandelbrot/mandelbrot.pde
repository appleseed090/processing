////////////////////////////////////////////////////////////
/*
mandelbrot - interactive mandelbrot set
adapted from CS5 Mandelbrot assignment
*/
////////////////////////////////////////////////////////////

int NUMITER = 10; // Default number of iterations
int FACTOR = 2;
float XMIN = -2.0;
float XMAX = 1.0;
float YMIN = -1.0;
float YMAX = 1.0;
int imgWidth = 600*FACTOR;
int imgHeight = 400*FACTOR;
PImage img;

void settings() {
  size(imgWidth, imgHeight);
}

void setup() {
  img = createImage(imgWidth, imgHeight, RGB);
  mset();
}

void draw() {
  image(img, 0, 0, imgWidth, imgHeight);
  fill(255);
  int text_size = 20;
  textSize(text_size);
  text("UP/DOWN to increase/decrease # of iterations", 20, text_size + 20);
  text("Number of iterations: " + NUMITER, 20, 2 * text_size + 40);
}

void keyPressed() {
  if (keyCode == UP) {
    NUMITER += 1;
    mset();
  } else if (keyCode == DOWN) {
    NUMITER = max(1, NUMITER - 1);
    mset();
  }
}

float scale(float pix, float pixMax, float floatMin, float floatMax) {
  /* converts pixel coordinates to complex plane coordinates */
  return floatMin + (pix/pixMax) * (floatMax - floatMin);
}

void mset() {  // displays the set
  for (int col = 0; col < imgWidth; col++) {
    for (int row = 0; row < imgHeight; row++) {
      float z_real = 0;
      float z_imag = 0;
      float c_real = scale(col, imgWidth, XMIN, XMAX);
      float c_imag = scale(row, imgHeight, YMIN, YMAX);
      int n = 0;  // n is the # of iterations it took for a point to escape the set (|z| > 2)
      while (n < NUMITER) {
        float z_real_temp = z_real*z_real - z_imag*z_imag + c_real;
        float z_imag_temp = 2*z_real*z_imag + c_imag;
        z_real = z_real_temp;
        z_imag = z_imag_temp;
        if (z_real*z_real + z_imag*z_imag > 4.0) break;
        n++;
      }
      if (n == NUMITER) {
        img.pixels[col + row*imgWidth] = color(0, 0, 0);
      } else {
        float norm = map(n, 0, NUMITER, 0, 1);
        float bright = map(sqrt(norm), 0, 1, 0, 255);
        // img.pixels[col + row*imgWidth] = color(bright, bright, bright);
        img.pixels[col + row*imgWidth] = color(bright, bright, 255-bright);
      }
    }
  }
  img.updatePixels();
}
