class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  final float dt = 0.2;
  float limite;

  Particle(PVector l) {
    acceleration = new PVector(0, 3);
    velocity = new PVector(random(-10, 10), random(-25, 0));
    position = l.copy();
    limite = l.y;
    lifespan = 100.0;
  }

  void run() {
    update();
    display();
  }

  void update() {
    velocity.add(PVector.mult(acceleration, dt));
    position.add(PVector.mult(velocity, dt));
  }

  void display() {
    noStroke();
    fill(0, 0, 255, 50);
    ellipse(position.x, position.y, 8, 8);
  }

  boolean isDead() {
    if (lifespan < 0.0 || position.y > limite) {
      return true;
    } else {
      return false;
    }
  }
}