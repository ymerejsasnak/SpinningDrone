class Mass
{
  ArrayList<Ring> rings;
  
  Mass() 
  {
    rings = new ArrayList<Ring>();
    
    for (int i = 0; i < 10; i++) {
      rings.add(new Ring()); 
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
  
}