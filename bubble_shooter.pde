float dt = 0.1, r = 150, c_r, c_g, c_b;
PVector pos_ini, p, dir;
boolean shotFired = false;

void setup() {
  size(600, 600);
  pos_ini = new PVector(width / 2, height);
  dir = new PVector();
  p = new PVector();
}

void draw() {
  background(255);

  stroke(0);
  fill(255);
  circle(pos_ini.x, pos_ini.y, r / 2);

  line(pos_ini.x, pos_ini.y, mouseX, mouseY);
  fill(c_r, c_g, c_b);
  stroke(0);
  
  if (shotFired) {
    p.add(PVector.mult(dir, dt));
    circle(p.x, p.y, 25);

    if (p.y < 0 || p.x < 0 || p.x > width) {
      shotFired = false;
      p.set(pos_ini);
    }
  }
}

void mousePressed() {
  if (!shotFired) {
    c_r=random(150, 255);
    c_g=random(150, 255);
    c_b=random(150, 255);
    p.set(pos_ini);
    dir = PVector.sub(new PVector(mouseX, mouseY), pos_ini).normalize().mult(45);
    shotFired = true;
  }
}
