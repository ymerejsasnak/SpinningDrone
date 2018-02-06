class Ring 
{
  int index;
  
  PVector center;
  float radius;
  
  int linkSize;
  
  float rotationAngle;
  int direction;
  float speed;
  
  int numberOfLinks;
  float linkSpacing;
  ArrayList<Link> links;
  
  Ring() 
  {
    center = new PVector(width/2, height/2);  
    radius = random(20, 300);
    
    linkSize = (int) random(10, 40);
    
    rotationAngle = 0;
    direction = random(-1, 1) > 0 ? 1 : -1;
    speed = random(.001, .02);
    
    numberOfLinks = (int) random(3, 12);
    linkSpacing = TAU / numberOfLinks;
    
    links = new ArrayList<Link>();
    for (int i = 0; i < numberOfLinks; i++) {   
       links.add(new Link(i, linkSize, calcLinkPosition(i)));
    }
    
  }
  
  
  int getTotalLinks()
  {
    return numberOfLinks; 
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
  
  
  
  
  
}