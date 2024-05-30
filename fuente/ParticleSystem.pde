class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  float angle;

  ParticleSystem(PVector position, float angle) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
    this.angle = angle;
  }

  void addParticle() {
    int numParticles = 100; 
    for (int i = 0; i < numParticles; i++) {
      PVector v = PVector.fromAngle(radians(angle));
      v.mult(30);
      v.y = 2*-v.y; 
      particles.add(new Particle(origin, v));
    }
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}