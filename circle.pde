float r=300, dt=0.1, f=1;
PVector p_circle, p_particle;
void setup(){
  size(600, 600);
  float x_0 = width/2;
  float y_0 = height/2;
  p_circle = new PVector(x_0, y_0);
  

}

void draw(){
  background(255);
  stroke(0);
  fill(255);
  circle(p_circle.x, p_circle.y, r);
  PVector pos = new PVector(r, r);
  
  pos.x = p_circle.x + r/2 * cos(2*PI*f* millis() / 1000);
  pos.y = p_circle.x + r/2 * sin(2*PI*f* millis() / 1000);
  
  stroke(255, 0, 0);
  fill(255, 200, 200);
  circle(pos.x, pos.y, 30);
  
}
