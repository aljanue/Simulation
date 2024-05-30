PVector _s;
PVector _F;
PVector _v;
PVector _a;
float Kd;
float R;
float G;
float angle;
float M;


void setup(){
    size(1000, 1000);
    _s = new PVector(width/5, height/5);
    R = 10;
    Kd = 0.1;
    G = 9.81;
    angle = PI / 4;
    _F = new PVector(0, 0);
    _v = new PVector(0, 0);
    _a = new PVector(0, 0);
    M = 100;
}

void draw(){
  background(255);
  fill(0);
  ellipse(_s.x, _s.y, 2*R, 2*R);
  update();
  stroke(0);
  line(width, height, 0, height - width * tan(angle));
}

void update(){
    PVector _Fd = PVector.mult(_v, -Kd);
    PVector _Fg = new PVector(G * sin(angle), G * cos(angle));
    _F = PVector.add(_Fd, _Fg);
    _a = PVector.div(_F, M);
    _v.add(_a);
    _s.add(_v);
}