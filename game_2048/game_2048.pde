import java.util.*;

final int SIZE = 4;
float squareSize = 800 / SIZE;
float text_size = squareSize / 3;
int[][] grid = new int[SIZE][SIZE];
boolean moved = false;  // check if numbers have actually moved
boolean gameOver = false;
int[][] rgbValues = {{238,228,218},  // 2
                     {237,224,200},  // 4
                     {242,177,121},  // 8
                     {245,149,99},   // 16
                     {246,124,95},   // 32
                     {246,94,59},    // 64
                     {237,207,114},  // 128
                     {237,204,97},   // 256
                     {237,200,80},   // 512
                     {237,197,63},   // 1024
                     {237,194,46}    // 2048
                    };
int numColors = rgbValues.length;

void setup() {
  size(800, 800);
  textSize(50);
  addNumber();
  addNumber();
}

void draw() {
  background(155);
  noStroke();
  if (!gameOver) {
    drawBoard();
    //for (int i = 0; i < SIZE; i++) {
    //  for (int j = 0; j < SIZE; j++) {
    //    text(grid[i][j], j * width/SIZE, (i + 1) * height/SIZE);
    //  }
    //}
  } else {
    drawKillscreen();
  }
}

void drawBoard() {
  int value;
  int power;
  int[] rgb;
  int r;
  int g;
  int b;
  for (int i = 0; i < SIZE; i++) {
    for (int j = 0; j < SIZE; j++) {
      translate((j + 0.5) * squareSize, (i + 0.5) * squareSize);
      value = grid[i][j];
      if (value == 0) {
        fill(205, 193, 180);
      } else {
        power = (int)(Math.log(grid[i][j]) / Math.log(2));
        if (power > numColors) {
          fill(0);
        } else {
          rgb = rgbValues[power-1];
          r = rgb[0];
          g = rgb[1];
          b = rgb[2];
          fill(r, g, b);
        }
      }
      
      square(-0.5 * squareSize, -0.5 * squareSize, squareSize);
      // set text color & print text
      if (value != 0) {
        if (value == 2 || value == 4) {
          fill(119,110,101);
        } else {
          fill(249, 246, 242);
        }
      }
      textSize(text_size);
      textAlign(CENTER, CENTER);
      text(grid[i][j], 0, 0 - text_size / 3);
      translate(-(j + 0.5) * squareSize, -(i + 0.5) * squareSize);
    }
  }
}

void drawKillscreen() {
  textAlign(CENTER, CENTER);
  textSize(80);
  text("GAME OVER", width / 2, height/2);
}

void keyPressed() {
  moved = false;
  if (!gameOver) {
    if (keyCode == UP) {
      for (int i=0; i<SIZE; i++) {
        mergeAndMove(i, 0, 0, 1);
      }
    } else if (keyCode == DOWN) {
      for (int i=0; i<SIZE; i++) {
        mergeAndMove(i, SIZE-1, 0, -1);
      }
    } else if (keyCode == LEFT) {
      for (int i=0; i<SIZE; i++) {
        mergeAndMove(0, i, 1, 0);
      }
    } else if (keyCode == RIGHT) {
      for (int i=0; i<SIZE; i++) {
        mergeAndMove(SIZE-1, i, -1, 0);
      }
    }
  }
  if (moved) {
    addNumber();
  }
  gameOver = isGameOver();
}

void addNumber() {
  ArrayList<Integer> emptyCells = new ArrayList<Integer>();
  // put all empty cells into an arraylist
  for (int i = 0; i < SIZE; i++) {
    for (int j = 0; j < SIZE; j++) {
      if (grid[i][j] == 0) {
        emptyCells.add(i * SIZE + j);
      }
    }
  }
  if (emptyCells.size() > 0) {
    // get random cell to put new number in
    int cellIndex = emptyCells.get(int(random(emptyCells.size())));
    // 10% chance to generate a 4; 90% chance to generate a 2.
    int row = cellIndex / SIZE;
    int col = cellIndex % SIZE;
    grid[row][col] = random(1) < 0.9 ? 2 : 4;
    moved = true;
  }
}

void mergeAndMove(int x, int y, int dx, int dy) {
  int[] line = new int[SIZE];
  boolean[] merged = new boolean[SIZE];
  
  // Get the line
  for (int i = 0; i < SIZE; i++) {
    line[i] = grid[y][x];
    x += dx;
    y += dy;
  }

  for (int i = 0; i < SIZE; i++) {
    for (int j = i + 1; j < SIZE; j++) {
      if (line[j] != 0) {
        if (line[i] == 0) {
          // move numbers to the left, filling in the "zero" spaces
          line[i] = line[j];
          line[j] = 0;
          i--;  // in this case, after the break statement, i retains its previous value
          // ^ (i effectively does not iterate.)
        } else if (line[i] == line[j] && !merged[i]) {
          /* if i & j match (and are adjacent/separated by only 0's),
             then combine them and multiply the resulting value by 2 */
          line[i] *= 2;
          line[j] = 0;
          merged[i] = true;
        }
        break;
      }
    }
  }

  // Set the line
  x -= SIZE * dx;
  y -= SIZE * dy;
  for (int i = 0; i < SIZE; i++) {
    if (grid[y][x] != line[i]) {
      moved = true;
    }
    grid[y][x] = line[i];
    x += dx;
    y += dy;
  }
}


boolean isGameOver() {
  for (int i = 0; i < SIZE; i++) {
    for (int j = 0; j < SIZE; j++) {
      if (grid[i][j] == 0) {
        return false;
      }
      if (j < SIZE - 1 && grid[i][j] == grid[i][j + 1]) {
        return false;
      }
      if (i < SIZE - 1 && grid[i][j] == grid[i + 1][j]) {
        return false;
      }
    }
  }
  return true;
}
