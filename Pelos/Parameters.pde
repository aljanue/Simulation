// Definitions:

// Simulation values:

final boolean REAL_TIME = true;   // To make the simulation run in real-time or not
final float TIME_ACCEL = 1.0;     // To simulate faster (or slower) than real-time


// Display and output parameters:
final int DRAW_FREQ = 100;                            // Draw frequency (Hz or Frame-per-second)
final int DISPLAY_SIZE_X = 1000;                      // Display width (pixels)
final int DISPLAY_SIZE_Y = 800;                      // Display height (pixels)

// Parameters of the problem:
final float TS = 0.01;     // Initial simulation time step (s)
final float G = 9.81;       // Acceleration due to gravity (m/(s·s))

final int num_pelos = 100;         // Number of nodes of the object in the horizontal direction
final int num_muelles = 40;         // Number of nodes of the object in the vertical direction

final float tam_pelos = 100.0;     // Separation of the object's nodes in the horizontal direction (m)
final float M = 10;

final float Ke = 750;            // Elastic constant (N/m)+
final float Kd = 0.01;
//...
//...
