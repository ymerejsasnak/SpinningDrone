class Ring 
{
  PVector center;
  float radius;
  
  int linkSize;
  
  float rotationAngle;
  int direction;
  float speed;
  
  int numberOfLinks;
  float linkSpacing;
  ArrayList<Link> links;
  
  AudioContext ac;
    
  float baseFreq;
  
  
  final float[] POSSIBLE_FREQS = {110, 220, 440};
  final int RADIUS_MIN = 20;
  final int RADIUS_MAX = 300;
  
  final int LINK_SIZE_MIN = 10;
  final int LINK_SIZE_MAX = 40;
  
  final float SPEED_MIN = 0.001;
  final float SPEED_MAX = 0.02;
  
  final int LINK_NUMBER_MIN = 2;
  final int LINK_NUMBER_MAX = 12;
  
  
  Ring(AudioContext ac) 
  {
    this.ac = ac;
    baseFreq = POSSIBLE_FREQS[(int) random(POSSIBLE_FREQS.length)];
           
    center = new PVector(width/2, height/2);  
    radius = random(RADIUS_MIN, RADIUS_MAX);
    
    linkSize = (int) random(LINK_SIZE_MIN, LINK_SIZE_MAX);
    
    rotationAngle = 0;
    direction = random(-1, 1) > 0 ? 1 : -1;
    speed = random(SPEED_MIN, SPEED_MAX);
    
    numberOfLinks = (int) random(LINK_NUMBER_MIN, LINK_NUMBER_MAX);
    linkSpacing = TAU / numberOfLinks;
    
    links = new ArrayList<Link>();
    for (int i = 0; i < numberOfLinks; i++) {   
      links.add(new Link(ac, i, linkSize, calcLinkPosition(i), baseFreq));
    }
  }
   
  
  private PVector calcLinkPosition(int index) 
  {
    float posX = center.x + cos(linkSpacing * index + rotationAngle) * radius;
    float posY = center.y + sin(linkSpacing * index + rotationAngle) * radius;
    return new PVector(posX, posY);
  }
  
  
  void update()
  {
    rotationAngle += direction * speed; 
    for (Link l: links) {
      l.update(calcLinkPosition(l.index));
    }
  }
  
  
  void display()
  {
    for (Link l: links) {
      l.display(); 
    }
  }
  
  
  void killAll()
  {
    for (Link l: links) {
      l.kill(); 
    }
  }
  
  
  
}