ParticleSystem[] ps = new ParticleSystem[7];
PVector s = new PVector();


void setup() {
  size(800, 600);
  for (int i = 0; i < 6; i++) {
    float angle = 45 + i * 18;
    s = new PVector(width/2, height/2);
    ps[i] = new ParticleSystem(s, angle);
  }
}
void draw() {
  background(255);
  noStroke();
  fill(255);
  for (int i = 0; i < 6; i++) {
    ps[i].addParticle();
    ps[i].run();
  }
}

