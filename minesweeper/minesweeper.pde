import java.util.*;

int dim = 20;
float squareSize;
int numMines = (dim * dim) / 10;
Cell[][] board = new Cell[dim][dim];
boolean won = false;
boolean lost = false;
ArrayList<PVector> mineLocations = new ArrayList<PVector>();

void setup() {
  size(800, 800);
  squareSize = 800/dim;
  for (int i = 0; i < dim; i++) {
    for (int j = 0; j < dim; j++) {
      board[i][j] = new Cell();
    }
  }
  placeMines();
}

void draw() {
  background(255);
  drawBoard();
  if (lost) {
    revealMines();
  }
}

void mousePressed() {
  int x = (int)(mouseX / (squareSize));
  int y = (int)(mouseY / (squareSize));
  if (mouseButton == LEFT) {
    openSquare(x, y);
  } else if (mouseButton == RIGHT) {
  }
}

class Cell {
  boolean isOpen = false;
  boolean isMine = false;
  boolean isFlagged = false;
  int mineCount = 0;

  void open() {
    if (this.isFlagged == false) {
      this.isOpen = true;
    }
  }
  
  void flag() {
    if (this.isOpen == false) {
      this.isFlagged = true;
    }
  }
}

void placeMines() {
  for (int i = 0; i < numMines; i++) {
    int x = int(random(dim));
    int y = int(random(dim));
    if (board[x][y] == null) {
      board[x][y] = new Cell();
      board[x][y].isMine = true;
      mineLocations.add(new PVector(x, y));
    } else {
      i--;
    }
  }
}

void drawBoard() {
  for (int i = 0; i < dim; i++) {
    for (int j = 0; j < dim; j++) {
      drawSquare(i, j, board[i][j]);
    }
  }
}

void drawSquare(int i, int j, Cell c) {
  // check if c is open, mine, flagged, and the number of mines adjacent to it
  if (c.isOpen) {
    fill(150);
  } else {
    fill(200);
    square(i * (squareSize), j * (squareSize), squareSize);
    if (c.isFlagged) {
      drawFlag(i, j);
    }
    return;
  }
  
}
  
void drawFlag(int i, int j) {
  fill(255, 0, 0);
  triangle((i+0.1) * (squareSize), (j+0.1) * (squareSize), 
           (i+0.1) * (squareSize), (j+0.9) * (squareSize),
           (i+0.9) * (squareSize), (j+0.5) * (squareSize));
}

void openSquare(int x, int y) {
  board[x][y].open();
  if (board[x][y].isMine) {
    lost = true;
    return;
  }
}

void revealMines() {
  // open all cells with mines and show bomb
}
