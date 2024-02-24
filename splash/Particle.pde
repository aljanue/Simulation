class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  final float dt = 0.2;

  Particle(PVector l) {
    acceleration = new PVector(0, 3);
    velocity = new PVector(random(-10, 10), random(-20, 10));
    position = l.copy();
    lifespan = 100.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(PVector.mult(acceleration, dt));
    position.add(PVector.mult(velocity, dt));
  }

  // Method to display
  void display() {
    stroke(255, lifespan);
    fill(255, lifespan);
    ellipse(position.x, position.y, 8, 8);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}