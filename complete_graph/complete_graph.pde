int n = 5;
ArrayList<Vertex> vertices;
int minN = 1;
int maxN = 100;

void setup() {
  size(600, 600);
  background(200);
  
  vertices = new ArrayList<Vertex>();
  float circlerad = 0.4 * width;
  for (int i = 0; i < n; i++) {
    float angle = (float)(i * ((2 * Math.PI) / n));
    float x = (float)((width/2) + circlerad * Math.cos(angle));
    float y = (float)((height/2) + circlerad * Math.sin(angle));
    //System.out.println(x);
    //System.out.println(y);
    vertices.add(new Vertex(x, y));
  }
}

void draw() {
  //translate(width*.5,height*.5);
  //scale(1,-1);

  int text_size = 50;
  textSize(text_size);
  text("n = " + n, 0, text_size);
  text_size = 20;
  textSize(text_size);
  text("UP arrow to increase n, DOWN arrow to decrease n", 10, height - 10);
  drawVertices(vertices);
  complete(vertices);
}


/* Draws the vertices on the graph */
void drawVertices(ArrayList<Vertex> vs) {
  fill(0);
  for (int i = 0; i < vs.size(); i++) {
    Vertex v = vs.get(i);
    circle(v.x, v.y, 10);
  }
}

/* Draws the edges for a complete graph */
void complete(ArrayList<Vertex> vs) {
  for (int i = 0; i < vs.size() - 1; i++) {
    Vertex v1 = vs.get(i);
    for (int j = i; j < vs.size(); j++) {
      Vertex v2 = vs.get(j);
      line(v1.x, v1.y, v2.x, v2.y);
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      n++;
      n = constrain(n, minN, maxN);
      setup();
    } else if (keyCode == DOWN) {
      n--;
      n = constrain(n, minN, maxN);
      setup();
    } 
  }
}

class Vertex {
  float x;
  float y;
  
  public Vertex(float x, float y) {
    this.x = x;
    this.y = y;
  }
}
