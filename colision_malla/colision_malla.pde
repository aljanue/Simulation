// Problem description: //<>//
// Deformable object simulation
import peasy.*;

// Display control:

PeasyCam _camera;   // Mouse-driven 3D camera

// Simulation and time control:

float _timeStep;              // Simulation time-step (s)
int _lastTimeDraw = 0;        // Last measure of time in draw() function (ms)
float _deltaTimeDraw = 0.0;   // Time between draw() calls (s)
float _simTime = 0.0;         // Simulated time (s)
float _elapsedTime = 0.0;     // Elapsed (real) time (s)

// Output control:

boolean _writeToFile = false;
PrintWriter _output;

// System variables:
DeformableObject _defOb;              // Deformable object
SpringLayout _springLayout;           // Current spring layout

// Main code:

void settings()
{
   size(DISPLAY_SIZE_X, DISPLAY_SIZE_Y, P3D);
}

void setup()
{
   frameRate(DRAW_FREQ);
   _lastTimeDraw = millis();

   float aspect = float(DISPLAY_SIZE_X)/float(DISPLAY_SIZE_Y);
   perspective((FOV*PI)/180, aspect, NEAR, FAR);
   _camera = new PeasyCam(this, 0, 0, 50, 600); // Center the camera on the origin
   _camera.rotateX(0.9);
   _camera.rotateZ(PI);

   initSimulation();
}

void initSimulation()
{
   _simTime = 0.0;
   _timeStep = TS*TIME_ACCEL;
   _elapsedTime = 0.0;
   _defOb = new DeformableObject(_springLayout.BEND,  color(61, 210, 255));
}


void draw()
{
   int now = millis();
   _deltaTimeDraw = (now - _lastTimeDraw)/1000.0;
   _elapsedTime += _deltaTimeDraw;
   _lastTimeDraw = now;

   //println("\nDraw step = " + _deltaTimeDraw + " s - " + 1.0/_deltaTimeDraw + " Hz");

   background(0);
   directionalLight(255, 255, 255, 1, 1, -1); // Luz blanca desde arriba
   ambientLight(100, 100, 100); // Luz de relleno gris


   drawStaticEnvironment();
   drawDynamicEnvironment();

   if (REAL_TIME)
   {
      float expectedSimulatedTime = TIME_ACCEL*_deltaTimeDraw;
      float expectedIterations = expectedSimulatedTime/_timeStep;
      int iterations = 0;

      for (; iterations < floor(expectedIterations); iterations++)
         updateSimulation();

      if ((expectedIterations - iterations) > random(0.0, 1.0))
      {
         updateSimulation();
         iterations++;
      }
   } 
   else
      updateSimulation();
}

void drawStaticEnvironment()
{
   noStroke();
   fill(255, 0, 0);
   box(1000.0, 1.0, 1.0);

   fill(0, 255, 0);
   box(1.0, 1000.0, 1.0);

   fill(0, 0, 255);
   box(1.0, 1.0, 1000.0);

   fill(255, 255, 255);
   sphere(1.0);

   stroke(0);
   noStroke();
   fill(254, 132, 152);
   pushMatrix();
   rotateX(0.9);
   sphere(R);
   popMatrix();
}

void drawDynamicEnvironment()
{
   _defOb.render();
}

void updateSimulation()
{
   _defOb.update(_timeStep);
   _simTime += _timeStep;
}

