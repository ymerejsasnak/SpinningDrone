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
  
  AudioContext ac;
    
  float baseFreq;
  
  float changeRate;
  
  Glide lpFreqGlide;
  Glide lpRezGlide;
  LPRezFilter lpUgen;
  
  final Buffer[] WAVE_TYPES = {Buffer.SQUARE, Buffer.TRIANGLE, Buffer.SAW, Buffer.SAW};  
  
  final float[] POSSIBLE_FREQS = {110, 165, 220, 330, 440, 550, 660};
  final int RADIUS_MIN = 20;
  final int RADIUS_MAX = 300;
  
  final int LINK_SIZE_MIN = 10;
  final int LINK_SIZE_MAX = 40;
  
  final float SPEED_MIN = 0.001;
  final float SPEED_MAX = 0.02;
  
  final int LINK_NUMBER_MIN = 3;
  final int LINK_NUMBER_MAX = 12;
  
  
  Ring(AudioContext ac, int index)
  {
    this.index = index;
    
    this.ac = ac;
    baseFreq = POSSIBLE_FREQS[index % POSSIBLE_FREQS.length];
    
    lpFreqGlide = new Glide(ac, 0, GLIDE_TIME);
    lpRezGlide = new Glide(ac, 0, GLIDE_TIME);
    lpUgen = new LPRezFilter(ac, lpFreqGlide, lpRezGlide);
           
    center = new PVector(width/2, height/2);  
    radius = random(RADIUS_MIN, RADIUS_MAX);
    
    linkSize = (int) random(LINK_SIZE_MIN, LINK_SIZE_MAX);
    
    rotationAngle = 0;
    direction = random(-1, 1) > 0 ? 1 : -1;
    speed = random(SPEED_MIN, SPEED_MAX);
    
    numberOfLinks = (int) random(LINK_NUMBER_MIN, LINK_NUMBER_MAX);
    linkSpacing = TAU / numberOfLinks;
    
    Buffer waveType = WAVE_TYPES[(int)random(WAVE_TYPES.length)];
    links = new ArrayList<Link>();
    for (int i = 0; i < numberOfLinks; i++) {   
      links.add(new Link(ac, i, linkSize, calcLinkPosition(i), baseFreq, waveType, lpUgen));
    }
    
    changeRate = random(0.0001, 0.001);
    
    ac.out.addInput(lpUgen);
  }
   
  
  private PVector calcLinkPosition(int index) 
  {
    float posX = center.x + cos(linkSpacing * index + rotationAngle) * radius;
    float posY = center.y + sin(linkSpacing * index + rotationAngle) * radius;
    return new PVector(posX, posY);
  }
  
  
  void update()
  {
    speed = map(noise((float)millis() * changeRate + index * 10), 0, 1, SPEED_MIN, SPEED_MAX);
    radius = map(noise((float)millis() * changeRate + index * 11), 0, 1, RADIUS_MIN, RADIUS_MAX);
    rotationAngle += direction * speed; 
    for (Link l: links) {
      l.update(calcLinkPosition(l.index));
    }
    
    lpFreqGlide.setValue(map(radius, RADIUS_MIN, RADIUS_MAX, 200, 7000));
    lpRezGlide.setValue(map(speed, SPEED_MIN, SPEED_MAX, .5, 1));
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