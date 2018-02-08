class Mass
{
  AudioContext ac;
   
  ArrayList<Ring> rings;
  int ringIndex;
  
  Mass() 
  {   
    ac = new AudioContext();
    ac.start();

    rings = new ArrayList<Ring>();    
  }
  
  
  void addRing()
  {
    rings.add(new Ring(ac, rings.size())); 
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
    
}