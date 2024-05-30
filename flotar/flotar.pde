PVector s = new PVector();
PVector v = new PVector();
PVector a = new PVector();
PVector F = new PVector();
PVector G = new PVector(0, 9.81);
PVector Fv = new PVector();
float g = -9.81;
float dt = 0.01; 
float m = 0.1;
float limite;
float rho = 0.000005; 
float Vs; 
float FB; 
float r = 50;

void setup(){
    size(600,600);
    limite = 2*height/3;
    s.x = width/2;
    s.y= height/3;
}

void draw(){
    background(255);
    
    update();

    fill(255, 165, 0);
    ellipse(s.x, s.y, r*2, r*2);

    fill(0, 0, 255, 50);
    rect(0, limite, width, height);

}

void update(){
    F.set(G);

    if (s.y - r >= limite){
        Vs = 4 * PI * r * r * r / 3;
        FB = rho * g * Vs;
        F.add(0, FB);
    } else if (s.y + r > limite){
        float h = s.y + r - limite;
        float a_f = sqrt(2 * h * r - h * h);
        Vs = (3 * a_f * a_f + h * h) * PI * h / 6;
        FB = rho * g * Vs;
        F.set(0, FB);
    }
    println("F"+F);
    a = PVector.div(F, m);
    v.add(PVector.mult(a, dt));
    s.add(PVector.mult(v, dt));

    
}