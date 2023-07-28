/* Card class:
A card in Set has 3 properties: shape, color, and number.
*/

int score = 0;

class Card {
  String shape;  // shape
  String c;  // color
  String shading; // shading
  int num;   // number
  int row;
  int col;
  boolean selected;
  

  public Card(String shape, String c, String shading, int num, int row, int col, boolean selected) {
    this.shape = shape;
    this.c = c;
    this.shading = shading;
    this.num = num;
    this.row = row;
    this.col = col;
    this.selected = false;
  }
}

ArrayList<Card> deck = new ArrayList<Card>();
ArrayList<Card> current = new ArrayList<Card>();


void setup() {
  size(1000, 800);
  for (int i = 0; i < 12; i++) {
    current.add(new Card("", "", "", 0, i / 4, i % 4, false));
  }
  for (int i = 0; i < 12; i++) {
    System.out.println(current.get(i).col);
  }
}

void draw() {
  background(64);
  
  // draw cards
  for (int row = 0; row < 3; row++) {
    for (int col = 0; col < 4; col++) {
      Card newCard = new Card("", "", "", 0, row, col, false);
      drawCard(newCard);
    }
  }
}

void drawCard(Card card) {
  int row = card.row;
  int col = card.col;
  int cardSize = 200;
  int marginSize = 40;
  int cardX = 40 + (col * (marginSize + cardSize));
  int cardY = 40 + (row * (marginSize + cardSize));
  fill(100);
  rect(cardX, cardY, cardSize, cardSize);
  
  int text_size = 80;
  fill(255);
  textSize(text_size);
  textAlign(CENTER, CENTER);
  text("Score: " + score, width / 2, height-50);
}

void drawShapes(Card card) {
  String shape = card.shape;
  String c = card.c;
  String shading = card.shading;
  int num = card.num;
  int r = card.row;
  int col = card.col;
}
