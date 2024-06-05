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
DeformableObject _defOb1, _defOb2, _defOb3, _defOb4;              // Deformable object
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
   _camera = new PeasyCam(this, 0, 0, 200, 600); // Center the camera on the origin
   _camera.rotateX(PI/2);
   _camera.rotateZ(PI);

   initSimulation();
}




void initSimulation()
{
   _simTime = 0.0;
   _timeStep = TS*TIME_ACCEL;
   _elapsedTime = 0.0;
   _defOb1 = new DeformableObject(_springLayout.STRUCTURAL, 200, color(250, 142, 65));
   _defOb2 = new DeformableObject(_springLayout.SHEAR, 0, color(61, 210, 255));
   _defOb3 = new DeformableObject(_springLayout.BEND, -200, color(242, 212, 114));
}


void draw()
{
   int now = millis();
   _deltaTimeDraw = (now - _lastTimeDraw)/1000.0;
   _elapsedTime += _deltaTimeDraw;
   _lastTimeDraw = now;

   //println("\nDraw step = " + _deltaTimeDraw + " s - " + 1.0/_deltaTimeDraw + " Hz");

   background(0, 100, 170);
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
   fill(82, 79, 78);
   translate(0, 0, -10);
   rect(-width/2, -height/2, width,height);

   // Draw the flagpole
   fill(128); // Gray color for the flagpole
   pushMatrix(); // Save the current transformation matrix
   translate(-198-N_H*D_H/2, 0, height/8); // Move the flagpole to its position
   box(1, 1, height/4); // Draw the flagpole as a tall, thin box
   popMatrix(); // Restore the transformation matrix
   pushMatrix(); // Save the current transformation matrix
   translate(2-N_H*D_H/2, 0, height/8); // Move the flagpole to its position
   box(1, 1, height/4); // Draw the flagpole as a tall, thin box
   popMatrix(); // Restore the transformation matrix
   pushMatrix(); // Save the current transformation matrix
   translate(199-N_H*D_H/2, 0, height/8); // Move the flagpole to its position
   box(1, 1, height/4); // Draw the flagpole as a tall, thin box
   popMatrix(); // Restore the transformation matrix
}

void drawDynamicEnvironment()
{
   _defOb1.render();
   _defOb2.render();
   _defOb3.render();

   // Draw labels
   fill(0); // Black text
   textSize(20); // Set text size
   textAlign(CENTER, CENTER); // Center the text

   pushMatrix(); // Save the current transformation matrix
   rotateX(PI/2); // Rotate the text 180 degrees
   rotateZ(PI);
   text("STRUCTURAL", -200, -350, 0); // Label for the first flag
   popMatrix(); // Restore the transformation matrix

   pushMatrix(); // Save the current transformation matrix
   rotateX(PI/2); // Rotate the text 180 degrees
   rotateZ(PI);
   text("SHEAR", 0, -350, 0); // Label for the first flag
   popMatrix(); // Restore the transformation matrix

   pushMatrix(); // Save the current transformation matrix
   rotateX(PI/2); // Rotate the text 180 degrees
   rotateZ(PI);
   text("BEND", 200, -350, 0); // Label for the first flag
   popMatrix(); // Restore the transformation matrix
}

void updateSimulation()
{
   _defOb1.update(_timeStep);
   _defOb2.update(_timeStep);
   _defOb3.update(_timeStep);
   _simTime += _timeStep;
}

