class Mass
{
  final int TOTAL_RINGS = 10;  
  
  AudioContext ac;
   
  ArrayList<Ring> rings;
  
  Mass() 
  {
    
    ac = new AudioContext();
    ac.start();
    
    
    rings = new ArrayList<Ring>();
    
    for (int i = 0; i < TOTAL_RINGS; i++) {
      rings.add(new Ring(ac, i)); 
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