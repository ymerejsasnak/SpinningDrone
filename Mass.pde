public class Mass
{
  AudioContext ac;
   
  ArrayList<Ring> rings;
  int ringIndex;
  
  String samplePath;
  
  Mass() 
  {   
    ac = new AudioContext();
    ac.start();
    
    samplePath = "";
    
    rings = new ArrayList<Ring>();    
  }
  
  
  void chooseSample()
  {
    selectInput("load a file", "getFile", sketchFile(""), this); 
  }
  
  public void getFile(File selection) {
    if (selection == null) {
      println("nothing selected");  
    } else {
      samplePath = selection.getAbsolutePath();
    }
    
  }
  
  void addRing()
  {
    rings.add(new Ring(ac, rings.size(), samplePath)); 
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