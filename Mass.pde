class Mass
{
  final int TOTAL_RINGS = 5;  
  
  AudioContext ac;
   
  ArrayList<Ring> rings;
  
  Mass() 
  {
    
    ac = new AudioContext();
    ac.start();
    
    
    rings = new ArrayList<Ring>();
    
    for (int i = 0; i < TOTAL_RINGS; i++) {
      rings.add(new Ring(ac)); 
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