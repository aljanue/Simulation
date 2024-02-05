float dt = 0.1, t = 0, acc1=0.8, acc2=1.3, acc3=-0.07, acc4=10, acc;
PVector a, b, p, c, d, e, vel1, vel2, vel3, vel4, vel;

void setup(){
  size(640, 600); // Definimos tamaño ventana
  
  float px_init = 0.3 * width / 2;
  float py_init = height / 2;
  float px_end = 0.6 * width / 2;
  float py_end = 0.8 * height / 2;
  float px_end_2 = width / 2;
  float py_end_2 = height / 2;
  float px_end_3 = 1.3 * width / 2;
  float py_end_3 = 0.5 * height / 2;
  float px_end_4 = 1.6 * width / 2;
  float py_end_4 = 1.5 * height / 2;
  
  a = new PVector(px_init, py_init); // Punto 1
  b = new PVector(px_end, py_end); // Punto 2
  c = new PVector(px_end_2, py_end_2); // Punto 3
  d = new PVector(px_end_3, py_end_3); // Punto 3
  e = new PVector(px_end_4, py_end_4); // Punto 3
  p = new PVector(px_init, py_init); // Particula
  
  // Obtenemos vector entre puntos
  vel1 = PVector.sub(b, a); // Resta de vectores (Restamos los puntos para obtener el vector que los une)
  vel2 = PVector.sub(c, b);
  vel3 = PVector.sub(d, c);
  vel4 = PVector.sub(e, d);
  
  // Normalizamos (obtenemos direccion a 1 pixel/segundo)
  vel1.normalize();
  vel2.normalize();
  vel3.normalize();
  vel4.normalize();
  
  // Aumentamos la velocidad
  vel1.mult(5);
  vel2.mult(20);
  vel3.mult(6);
  vel4.mult(35);
  
}

void draw(){ 
  background(255); // Color de fondo (sirve para borrar lo que hay dibujado)
  
  stroke(0);
  line(a.x, a.y, b.x, b.y);
  line(b.x, b.y, c.x, c.y);
  line(c.x, c.y, d.x, d.y);
  line(d.x, d.y, e.x, e.y);

  fill(255);
  ellipse(p.x, p.y, 10, 10);
  
  stroke(255, 0, 0); // Color del contorno del circulo
  fill(255, 150, 150); // Color del circulo
  ellipse(a.x, a.y, 20, 20); // Creamos un circulo
  
  stroke(0, 0, 255); // Color del contorno del circulo
  fill(150, 150, 255); // Color del circulo
  ellipse(b.x, b.y, 20, 20);
  
  stroke(0, 255, 0); // Color del contorno del circulo
  fill(150, 255, 150); // Color del circulo
  ellipse(c.x, c.y, 20, 20);
  
  stroke(163, 73, 164); // Color del contorno del circulo
  fill(204, 169, 221); // Color del circulo
  ellipse(d.x, d.y, 20, 20);
  
  stroke(79, 49, 37); // Color del contorno del circulo
  fill(226, 196, 172); // Color del circulo
  ellipse(e.x, e.y, 20, 20);
  
  t += dt;
  // Actualizamos la velocidad y la posición usando aceleración en funcion del tramo en el que nos encontramos
  if(p.x < b.x){
    vel = vel1;
    acc = acc1;
  } else if(p.x < c.x){
    vel = vel2;
    acc = acc2;
  } else if(p.x < d.x){
    vel = vel3;
    acc=acc3;
  } else if(p.x < e.x){
    vel = vel4;
    acc=acc4;
  } else{
    vel = new PVector(0, 0);
    acc= 0;
  }
  
  
  PVector v_copy = vel.copy();
  v_copy.normalize();
  float a_t = acc*dt;
  vel.add(PVector.mult(v_copy, a_t));
  p.add(PVector.mult(vel, dt));
}
