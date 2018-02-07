class Mass
{
  
  AudioContext ac;
   
  ArrayList<Ring> rings;
  
  Mass() 
  {
    
    ac = new AudioContext();
    ac.start();
    
    
    rings = new ArrayList<Ring>();
    
    for (int i = 0; i < 1; i++) {
      rings.add(new Ring(ac, 0)); 
    }
    
  }
   
  
  void update() 
  {
    for (Ring r: rings) {
      r.update(); 
    }
  }
  
  
  void display()
  {
    for (Ring r: rings) {
      r.display(); 
    }
  }
  
  
  void killAll()
  {
    for (Ring r: rings) {
      r.killAll(); 
    }
  }
  
  
}