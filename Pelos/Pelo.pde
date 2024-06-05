public class Pelo
{
   
   PVector _s;
   float l;
   ArrayList<DampedSpring> _muelles;
   ArrayList<Particle> _particulas;
   Pelo(PVector pos)
   {
      _s = pos;
      l = tam_pelos;
      _muelles = new ArrayList<DampedSpring>();
      _particulas = new ArrayList<Particle>();
      float tam_muelle = tam_pelos/num_muelles;
      for(int i = 0; i <=num_muelles; i++){
         _particulas.add(new Particle(new PVector(_s.x + i*tam_muelle, _s.y)));
         if(i>0){
            _muelles.add(new DampedSpring(_particulas.get(i-1), _particulas.get(i), tam_muelle));
         }
      }
   }

   void update(float simStep)
   {
      for(int i = 0; i < _muelles.size(); i++){
            _muelles.get(i).update(simStep);
      }
      for(int i = 1; i < _particulas.size(); i++){
            _particulas.get(i).update(simStep);
      }
   }
   void render(){
      for(int i = 0; i < _muelles.size(); i++){
         _muelles.get(i).render();
      }
   }
}
