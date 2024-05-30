ParticleSystem ps;
int contador = 0;
PVector ellipsePosition;
PVector v = new PVector();
PVector a = new PVector();
PVector F = new PVector();
PVector G = new PVector(0, 9.81);
float kd = 0.5; 
PVector Fv = new PVector();
float g = -9.81;
float dt = 0.01; 
float m = 0.1;
float limite;
float rho = 0.0002; 
float Vs; 
float FB; 
float r = 15;

void setup() {
    size(600,600);
    limite = 2*height/3;
    ellipsePosition = new PVector(width/2, height/2);
    
    ps= new ParticleSystem(new PVector(ellipsePosition.x, limite));
    ps.addParticle();
} 

void draw() {
    background(255);
    noStroke();
    fill(255);
    update();
    fill(255,170, 0);
    ellipse(ellipsePosition.x, ellipsePosition.y, 2*r, 2*r);
    fill(0, 0, 255, 50);    
    rect(0, limite, width, height);
}

void update(){
    F.set(G);
    F.add(PVector.mult(v, -kd));
    if (ellipsePosition.y - r >= limite){   
        Vs = 4 * PI * r * r * r / 3;
        FB = rho * g * Vs;
        F.add(0, FB);
    } else if (ellipsePosition.y + r > limite){ 
        contador++;
        float h = ellipsePosition.y + r - limite;
        float a_f = sqrt(2 * h * r - h * h);
        Vs = (3 * a_f * a_f + h * h) * PI * h / 6;
        FB = rho * g * Vs;
        F.set(0, FB);
        if (contador == 1) {
            ps= new ParticleSystem(new PVector(ellipsePosition.x, limite));
            ps.addParticle();
        }
    }
    a = PVector.div(F, m);
    v.add(PVector.mult(a, dt));
    ellipsePosition.add(PVector.mult(v, dt));

    if (contador > 0) {
        ps.run();
    }
}


