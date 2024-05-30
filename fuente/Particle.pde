class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  final float dt = 0.2;
  PVector a = new PVector();
  PVector F = new PVector(0, 9.81);
  float speedFactor;

  Particle(PVector l, PVector v) {
    velocity = v;
    position = l.copy();
    lifespan = 80;
    speedFactor = random(0.5, 1);
  }

  void run() {
    update();
    display();
  }

  void update() {
    acceleration = PVector.div(F, 1);
    velocity.add(PVector.mult(acceleration, dt));
    position.add(PVector.mult(velocity, dt).mult(speedFactor));
    lifespan -= 1;
  }

  void display() {
    noStroke();
    fill(37, 150, 190, lifespan);
    ellipse(position.x, position.y, 4, 4);
  }

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}