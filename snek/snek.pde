////////////////////////////////////////////////////////////
/*
Snek
(Snake & Apple game)
*/
////////////////////////////////////////////////////////////


import java.util.LinkedList;
import java.util.Deque;
import java.util.ArrayList;
import java.util.Arrays;

int dim = 20;  // dimensions of board (including walls)
float squareSize;
boolean game_over = false;
Deque<int[]> snake_cells = new LinkedList<>();
ArrayList<int[]> available_cells = new ArrayList<>();
int[] snake_head = {9, 9};
int[] apple_cell = new int[2];
int score = 0;
String current_dir = "R";
Deque<String> directions = new LinkedList<>();

void setup() {
  size(800, 800);
  squareSize = 800/dim;
  frameRate(60);  // Increased frame rate
  snake_cells.addLast(snake_head);
  for (int i = 1; i < dim-1; i++) {
    for (int j = 1; j < dim-1; j++) {
      if (i != 9 || j != 9) {
        available_cells.add(new int[] {i, j});
      }
    }
  }
  spawn_apple();
}

void draw() {
  if (frameCount % 6 == 0) {  // Only update the snake's position every 6 frames
    background(255);
    noStroke();
    snake_head = snake_cells.peekLast();
    if (snake_head[0] == 0 || snake_head[0] == dim-1 || snake_head[1] == 0 || snake_head[1] == dim-1) {  // if snake runs into wall
      game_over = true;
    } else {
      for (int[] cell : snake_cells) {
        if (cell != snake_head && cell[0] == snake_head[0] && cell[1] == snake_head[1]) {  // if snake intersects itself
          game_over = true;
          break;
        }
      }
    }
    if (!directions.isEmpty()) {  // Change direction at the start of each frame
      current_dir = directions.removeFirst();
    }

    // Draw the board if the game is ongoing. Otherwise, draw the killscreen.
    if (game_over == false) {
      draw_board();
      update_snake(current_dir);
    } else {
      fill(255);
      draw_killscreen();
    }
  }
}

void draw_board() {
  /*
  Draws checkerboard pattern with walls, along with apple & snake
   */
  for (int i = 0; i < dim; i++) {
    for (int j = 0; j < dim; j++) {
      if (i == 0 || j == 0 || i == dim-1 || j == dim-1) {
        fill(0, 100, 0);
      } else {
        fill((i + j) % 2 == 0 ? 200 : 150, 255, (i + j) % 2 == 0 ? 200 : 150);
      }
      rect(i * squareSize, j * squareSize, squareSize, squareSize);
    }
  }
  
  // draw snek
  fill(0, 0, 255);
  for (int[] cell : snake_cells) {
    rect(cell[0] * squareSize, cell[1] * squareSize, squareSize, squareSize);
  }
  
  // draw apple
  fill(255, 0, 0);
  rect(apple_cell[0] * squareSize, apple_cell[1] * squareSize, squareSize, squareSize);
}


void update_snake(String current_dir) {
  /* updates the snake's cells */
  int[] new_head = new int[2];
  if (current_dir.equals("U")) {
    new_head[0] = snake_head[0];
    new_head[1] = snake_head[1] - 1;
  } else if (current_dir.equals("D")) {
    new_head[0] = snake_head[0];
    new_head[1] = snake_head[1] + 1;
  } else if (current_dir.equals("L")) {
    new_head[0] = snake_head[0] - 1;
    new_head[1] = snake_head[1];
  } else if (current_dir.equals("R")) {
    new_head[0] = snake_head[0] + 1;
    new_head[1] = snake_head[1];
  }

  snake_cells.addLast(new_head);
  //available_cells.remove(new Integer[]{new_head[0], new_head[1]});
  for (int i = 0; i < available_cells.size(); i++) {  // iterate over available_cells
    if (Arrays.equals(available_cells.get(i), new_head)) {  // if the i-th element is the same as new_head, remove the i-th element
      available_cells.remove(i);
      break;
    }
  }

  if (new_head[0] == apple_cell[0] && new_head[1] == apple_cell[1]) {
    score++;
    spawn_apple();
  } else {
    int[] tail = snake_cells.removeFirst();
    available_cells.add(tail);
  }
}

void keyPressed() {
  if ((key == 'w' || key == 'W' || keyCode == UP) && !current_dir.equals("D")) {
    directions.addLast("U");
  } else if ((key == 's' || key == 'S' || keyCode == DOWN) && !current_dir.equals("U")) {
    directions.addLast("D");
  } else if ((key == 'a' || key == 'A' || keyCode == LEFT) && !current_dir.equals("R")) {
    directions.addLast("L");
  } else if ((key == 'd' || key == 'D' || keyCode == RIGHT) && !current_dir.equals("L")) {
    directions.addLast("R");
  }
}


void draw_killscreen() {
  background(100);
  int text_size = 100;
  textSize(text_size);
  textAlign(CENTER);
  text("YOU LOSE!", width/2, width/2-text_size);
  text("Score = " + score, width/2, width/2+text_size);
}

void spawn_apple() {
  int randomIndex = (int)random(available_cells.size());
  apple_cell = available_cells.get(randomIndex);
}
