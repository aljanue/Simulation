static int _lastParticleId = 0; //<>//

public class Particle
{
   int _id;            // Unique id for each particle

   PVector _s;         // Position (m)
   PVector _v;         // Velocity (m/s)
   PVector _a;         // Acceleration (m/(s*s))
   PVector _F;         // Force (N)
   float _m;           // Mass (kg)

   boolean _noGravity; // If true, the particle will not be affected by gravity
   boolean _clamped;   // If true, the particle will not move


   Particle(PVector s, PVector v, float m, boolean noGravity, boolean clamped)
   {
      _id = _lastParticleId++;

      _s = s.copy();
      _v = v.copy();
      _m = m;

      _noGravity = noGravity;
      _clamped = clamped;

      _a = new PVector(0.0, 0.0, 0.0);
      _F = new PVector(0.0, 0.0, 0.0);
   }

   void update(float simStep)
   {
      if (_clamped)
         _F.set(0, 0, 0);

      else if (!_noGravity)
         updateWeightForce();
      
      if(!_clamped)
         updateWindForce();
      // Simplectic Euler:
      // v(t+h) = v(t) + h*a(s(t),v(t))
      // s(t+h) = s(t) + h*v(t+h)
      _a = PVector.div(_F, _m);
      _v.add(PVector.mult(_a, simStep));
      _s.add(PVector.mult(_v, simStep));
      _F.set(0.0, 0.0, 0.0);
   }

   int getId()
   {
      return _id;
   }

   PVector getPosition()
   {
      return _s;
   }

   void setPosition(PVector s)
   {
      _s = s.copy();
      _a.set(0.0, 0.0, 0.0);
      _F.set(0.0, 0.0, 0.0);
   }

   void setVelocity(PVector v)
   {
      _v = v.copy();
   }

   void setClamped(boolean clamped)
   {
      _clamped = clamped;
   }

   void setNoGravity(boolean noGravity)
   {
      _noGravity = noGravity;
   }

   void updateWeightForce()
   {
      PVector weigthForce = new PVector(0, 0, -G*_m);
      _F.add(weigthForce);
   }

   void updateWindForce(){
      float windX = 0.15 + random(300, 800) * 0.12;
      float windY = 0.015 + random(300, 800) * 0.012;
      float windZ = -0.01 - random(300, 800) * 0.01;
      PVector windForce = new PVector(windX, windY, windZ);
      _F.add(windForce);
   }

   void addExternalForce(PVector F)
   {
      _F.add(F);
   }
}
