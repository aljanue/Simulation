public class DeformableObject
{
   int _numNodesH;   // Number of nodes in horizontal direction
   int _numNodesV;   // Number of nodes in vertical direction

   float _sepH;      // Separation of the object's nodes in the X direction (m)
   float _sepV;      // Separation of the object's nodes in the Y direction (m)

   SpringLayout _springLayout;   // Physical layout of the springs that define the surface of each layer
   color _color;                 // Color (RGB)
   color _color2;

   Particle[][] _nodes;                             // Particles defining the object
   ArrayList<DampedSpring> _springs;                // Springs joining the particles



   DeformableObject(SpringLayout layout, color c)
   {
    _numNodesH = N_H;
    _numNodesV = N_V;
    _sepH = D_H;
    _sepV = D_V;
    _springLayout = layout;

    _color=c;
    _color2 = OBJ_COLOR;

    _nodes = new Particle[_numNodesH][_numNodesV];
    _springs = new ArrayList<DampedSpring>();
    
    createForm();
    createSprings();
   }

   int getNumNodes()
   {
      return _numNodesH*_numNodesV;
   }

   int getNumSprings()
   {
      return _springs.size();
   }

  void createForm(){
      for (int j = 0; j < _numNodesV; j++)
      {  
        for (int i = 0; i < _numNodesH; i++)
        {
          PVector pos = new PVector(i*_sepH - _numNodesH*_sepH/2-25, j*_sepV - _numNodesV*_sepV/2, 100);
          _nodes[i][j] = new Particle(pos, new PVector(0, 0, 0), MASS_NODES);
        }
      }
  }

   void update(float simStep)
   {
      for(int i = 0; i < _springs.size(); i++){
        _springs.get(i).update(simStep);
      }
      for(int i = 0; i < _numNodesH; i++){
        for(int j = 0; j < _numNodesV; j++){
          if(_nodes[i][j] != null){
            _nodes[i][j].update(simStep);
          }
        }
      }
   }


   void createSprings()
   {
      if(_springLayout == _springLayout.STRUCTURAL){
        createStructural();
      } else if(_springLayout == _springLayout.SHEAR){
        createShear();
      } else if(_springLayout == _springLayout.BEND){
        createBend();
      }
   }
   void createStructural()
   {
      for (int i = 0; i < _numNodesH; i++){
        for (int j = 0; j < _numNodesV; j++) {
          if(i > 0){          
            _springs.add(new DampedSpring(_nodes[j][i-1], _nodes[j][i], _sepV));
          }
          if(j>0){
            _springs.add(new DampedSpring(_nodes[j-1][i], _nodes[j][i], _sepH));
          }
        }
      }
   }
   void createShear()
   {
      float l0 = sqrt(_sepH*_sepH + _sepV*_sepV);
      for (int y = 1; y < _numNodesH; y++){
        for (int x = 1; x < _numNodesV; x++) {
          _springs.add(new DampedSpring(_nodes[x-1][y-1], _nodes[x][y], l0));
          _springs.add(new DampedSpring(_nodes[x-1][y], _nodes[x][y-1], l0));
         }
      }
   }
    void createBend()
    {
      createStructural();
      for (int i = 0; i < _numNodesH; i++){
        for (int j = 0; j < _numNodesV; j++) {
          if(i > 1){          
            _springs.add(new DampedSpring(_nodes[j][i-2], _nodes[j][i], _sepV*2));
          }
          if(j>1){
            _springs.add(new DampedSpring(_nodes[j-2][i], _nodes[j][i], _sepH*2));
          }
        }
      }
    }
    

   void render()
   {
      if (DRAW_MODE)
         renderWithSegments();
      else
         renderWithQuads();
   }

   void renderWithQuads()
   {
     int i, j;

     fill(_color);
     stroke(_color2);
     noStroke();

     for (j = 0; j < _numNodesV - 1; j++)
     {
       beginShape(QUAD_STRIP);
       for (i = 0; i < _numNodesH; i++)
       {
         if ((_nodes[i][j] != null) && (_nodes[i][j+1] != null))
         {
           PVector pos1 = _nodes[i][j].getPosition();
           PVector pos2 = _nodes[i][j+1].getPosition();

           vertex(pos1.x, pos1.y, pos1.z);
           vertex(pos2.x, pos2.y, pos2.z);
         }
       }
       endShape();
     }
  }

  void renderWithSegments()
  {
    stroke(_color2);

    for (DampedSpring s : _springs) 
    {
      if (s.isEnabled())
      {
        PVector pos1 = s.getParticle1().getPosition();
        PVector pos2 = s.getParticle2().getPosition();

        line(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z);
      }
    }
  }
}
