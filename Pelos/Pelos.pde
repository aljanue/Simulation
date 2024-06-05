// Simulation and time control:

float _timeStep;              // Simulation time-step (s)
int _lastTimeDraw = 0;        // Last measure of time in draw() function (ms)
float _deltaTimeDraw = 0.0;   // Time between draw() calls (s)
float _simTime = 0.0;         // Simulated time (s)
float _elapsedTime = 0.0;     // Elapsed (real) time (s)

// System variables:
ArrayList<Pelo> pelos;

// Main code:

void settings()
{
   size(DISPLAY_SIZE_X, DISPLAY_SIZE_Y);
}

void setup()
{
   frameRate(DRAW_FREQ);
   _lastTimeDraw = millis();

   initSimulation();
}




void initSimulation()
{
   _simTime = 0.0;
   _timeStep = TS*TIME_ACCEL;
   _elapsedTime = 0.0;
   pelos = new ArrayList<Pelo>();
   for(int i = 0; i < num_pelos; i++){
        PVector pos = new PVector(width/2+random(-70, 70), height/3+random(-40, 40)); 
        pelos.add(new Pelo(pos));
    }
}


void draw()
{
   int now = millis();
   _deltaTimeDraw = (now - _lastTimeDraw)/1000.0;
   _elapsedTime += _deltaTimeDraw;
   _lastTimeDraw = now;

   //println("\nDraw step = " + _deltaTimeDraw + " s - " + 1.0/_deltaTimeDraw + " Hz");

   background(255);
   drawDynamicEnvironment();
   updateSimulation();
}

void drawDynamicEnvironment()
{
   for (int i = 0; i < pelos.size(); i++)
      pelos.get(i).render();
}

void updateSimulation()
{
   for(Pelo p : pelos)
      p.update(_timeStep);
   _simTime += _timeStep;
}

