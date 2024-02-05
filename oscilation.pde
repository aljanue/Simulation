float v = 0.5;
ArrayList<PVector> d_pos;
PVector pos, pos_ini;

void setup() {
  size(600, 600);
  pos_ini = new PVector();
  pos_ini.x = 0;
  pos_ini.y = height / 2;
  pos = pos_ini;

  d_pos = new ArrayList<PVector>();
}

void draw() {
  background(255);

  pos.x += v;

  pos.y = height/2 + 10 * (0.5 * sin(1 * pos.x) + 2 * sin(2.5 * pos.x));

  d_pos.add(new PVector(pos.x, pos.y));

  stroke(255, 0, 0);
  fill(255, 200, 200);
  ellipse(pos.x, pos.y, 25, 25);

  noFill();
  stroke(255, 0, 0);
  beginShape();
  for (PVector punto : d_pos) {
    vertex(punto.x, punto.y);
  }
  endShape();
}
