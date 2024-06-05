// Definitions:

// Spring Layout
enum SpringLayout
{
   STRUCTURAL,
   SHEAR,
   BEND
}

// Simulation values:

final boolean REAL_TIME = true;   // To make the simulation run in real-time or not
final float TIME_ACCEL = 1.0;     // To simulate faster (or slower) than real-time


// Display and output parameters:

boolean DRAW_MODE = false;                            // True for wireframe
final int DRAW_FREQ = 100;                            // Draw frequency (Hz or Frame-per-second)
final int DISPLAY_SIZE_X = 1800;                      // Display width (pixels)
final int DISPLAY_SIZE_Y = 1000;                      // Display height (pixels)
final float FOV = 60;                                 // Field of view (º)
final float NEAR = 0.01;                              // Camera near distance (m)
final float FAR = 10000.0;                            // Camera far distance (m)
final color OBJ_COLOR = color(0);         // Object color (RGB)
final color BALL_COLOR = color(225, 127, 80);         // Ball color (RGB)
final color BACKGROUND_COLOR = color(190, 1800, 210); // Background color (RGB)
final int [] TEXT_COLOR = {0, 0, 0};                  // Text color (RGB)
final String FILE_NAME = "data.csv";                  // File to write the simulation variables

// Parameters of the problem:

final float TS = 0.001;     // Initial simulation time step (s)
final float G = 9.81;       // Acceleration due to gravity (m/(s·s))

final int N_H = 50;         // Number of nodes of the object in the horizontal direction
final int N_V = 50;         // Number of nodes of the object in the vertical direction

final float D_H = 5;     // Separation of the object's nodes in the horizontal direction (m)
final float D_V = 5;     // Separation of the object's nodes in the vertical direction (m)

// Added new parameters:
final float RADIUS_BALL = 50;        // Radius of the ball (m)
final float MASS_NODES = 0.1;     // Mass of the nodes (kg)
final float Ke = 200;            // Elastic constant (N/m)
final float Kd = 1;              // Damping constant (N·s/m)
final float R = 70;
final float Dm = R+2;
final float L0 =R+10;
final float Ke_ball=2;

boolean useDamping = true;     // True to consider damping
//...
//...
