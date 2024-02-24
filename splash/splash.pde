ParticleSystem ps;
boolean isClicked = false;
PVector ellipsePosition;

void setup() {
  size(1000, 300);
  ellipsePosition = new PVector(width/2, height/3);
}

void draw() {
  background(0);
  fill(255);
  ellipse(ellipsePosition.x, ellipsePosition.y, 30, 30); // Dibuja una elipse en el centro de la pantalla
textAlign(CENTER, CENTER);
textSize(28); 
  text("Click me!", ellipsePosition.x, ellipsePosition.y - 50); // Añade texto encima de la elipse
  if (ps != null) {
    ps.run();
  }
}

void mousePressed() {
  float d = dist(mouseX, mouseY, ellipsePosition.x, ellipsePosition.y);
  if (d < 15) { // Si el clic está dentro de la elipse
    ps = new ParticleSystem(new PVector(mouseX, mouseY)); // Crea un nuevo sistema de partículas en la ubicación del clic
    ps.addParticle();
  }
}
