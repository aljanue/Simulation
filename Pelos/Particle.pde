static int _lastParticleId = 0; //<>//

public class Particle
{
   int _id;            // Unique id for each particle

   PVector _s;         // Position (m)
   PVector _v;         // Velocity (m/s)
   PVector _a;         // Acceleration (m/(s*s))
   PVector _F;         // Force (N)
   float _m;           // Mass (kg)


   Particle(PVector s)
   {
      _id = _lastParticleId++;

      _s = s.copy();
      _v = new PVector(0,0);
      _a = new PVector(0,0);
      _F = new PVector(0,0);
      _m = M;
   }

   void update(float simStep)
   {
      updateWeightForce();
      PVector Froz = PVector.mult(_v, -Kd);
      _F.add(Froz);
      // Simplectic Euler:
      // v(t+h) = v(t) + h*a(s(t),v(t))
      // s(t+h) = s(t) + h*v(t+h)
      _a = PVector.div(_F, _m);
      _v.add(PVector.mult(_a, simStep));
      _s.add(PVector.mult(_v, simStep));
      
      _F.set(0.0, 0.0);
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
      _a.set(0.0, 0.0);
      _F.set(0.0, 0.0);
   }

   void setVelocity(PVector v)
   {
      _v = v.copy();
   }


   void updateWeightForce()
   {
      PVector weigthForce = new PVector(0, G*_m);
      _F.add(weigthForce);
   }

   void addExternalForce(PVector F)
   {
      _F.add(F);
   }
}
