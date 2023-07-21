////////////////////////////////////////////////////////////
/*
Interactive Julia set
*/
////////////////////////////////////////////////////////////

int NUMITER = 10; // Default number of iterations
int FACTOR = 2;
float XMIN = -2.0;
float XMAX = 2.0;
float YMIN = -2.0;
float YMAX = 2.0;
int imgWidth = 400*FACTOR;
int imgHeight = 400*FACTOR;
PImage img;
float c_real = 0; // Constant for Julia set z^2 - 1
float c_imag = 0;

void settings() {
  size(imgWidth, imgHeight);
}

void setup() {
  img = createImage(imgWidth, imgHeight, RGB);
  jset();
}

void draw() {
  image(img, 0, 0, imgWidth, imgHeight);
  fill(255);
  int text_size = 20;
  textSize(text_size);
  String iterInstrText = "UP/DOWN to increase/decrease # of iterations";
  String c_realInstrText = "D/A to increase/decrease Re(c)";
  String c_imagInstrText = "W/S to increase/decrease Im(c)";
  String iterText = "Number of iterations: " + NUMITER;
  String cText = "c = " + c_real + " + " + c_imag + "i";
  String finalText = iterInstrText + "\n" + c_realInstrText + "\n" + c_imagInstrText + "\n" + iterText + "\n" + cText;
  text(finalText, 20, text_size + 20);
  //text("UP/DOWN to increase/decrease # of iterations", 20, text_size + 20);
  //text("D/A to increase/decrease real component of c", 20, text_size + 20);
  //text("W/S to increase/decrease complex component of c", 20, text_size + 20);
  //text("Number of iterations: " + NUMITER, 20, 2 * text_size + 40);
}

public static float round2(float number, int scale) {
  int pow = 10;
  for (int i = 1; i < scale; i++)
    pow *= 10;
  float tmp = number * pow;
  if (number > 0) {
    return ( (float) ( (int) ((tmp - (int) tmp) >= 0.5f ? tmp + 1 : tmp) ) ) / pow;
  } else {
    return ( (float) ( (int) ((tmp - (int) tmp) <= -0.5f ? tmp - 1 : tmp) ) ) / pow;
  }
}

void keyPressed() {
  if (keyCode == UP) {
    NUMITER += 1;
    jset();
  } else if (keyCode == DOWN) {
    NUMITER = max(1, NUMITER - 1);
    jset();
  } else if ((key == 'a' || key == 'A')) {
    c_real -= 0.01;
    c_real = round2(c_real, 2);
    jset();
  } else if ((key == 'd' || key == 'D')) {
    c_real += 0.01;
    c_real = round2(c_real, 2);
    jset();
  } else if ((key == 's' || key == 'S')) {
    c_imag -= 0.01;
    c_imag = round2(c_imag, 2);
    jset();
  } else if ((key == 'w' || key == 'W')) {
    c_imag += 0.01;
    c_imag = round2(c_imag, 2);
    jset();
  }
}

float scale(float pix, float pixMax, float floatMin, float floatMax) {
  /* converts pixel coordinates to complex plane coordinates */
  return floatMin + (pix/pixMax) * (floatMax - floatMin);
}

void jset() {  // displays the set
  for (int col = 0; col < imgWidth; col++) {
    for (int row = 0; row < imgHeight; row++) {
      float z_real = scale(col, imgWidth, XMIN, XMAX);
      float z_imag = scale(row, imgHeight, YMIN, YMAX);
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
        //img.pixels[col + row*imgWidth] = color(bright, bright, bright);
        img.pixels[col + row*imgWidth] = color(bright, bright, 255-bright);
      }
    }
  }
  img.updatePixels();
}
