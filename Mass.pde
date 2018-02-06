class Mass
{
  ArrayList<Ring> rings;
  
  Mass() 
  {
    rings = new ArrayList<Ring>();
    
    for (int i = 0; i < 1; i++) {
      rings.add(new Ring()); 
    }
    
  }
  
  
  int getLinksInRing(int index)
  {
    return rings.get(index).getTotalLinks();
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