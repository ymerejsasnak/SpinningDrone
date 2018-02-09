class Ring 
{
  final Buffer[] WAVE_TYPES = {Buffer.SAW, Buffer.SQUARE, Buffer.TRIANGLE};
                             
  final float[] POSSIBLE_FREQS = {55,
                                  110, 110 * 3.0/2,
                                  220, 220 * 81.0/64, 220 * 3.0/2, 
                                  440, 440 * 9.0/8, 440 * 81.0/64, 440 * 3.0/2, 
                                  880, 440 * 243.0/128};
  
  final int RADIUS_MIN = 40;
  final int RADIUS_MAX = 300;
  
  final int LINK_SIZE_MIN = 20;
  final int LINK_SIZE_MAX = 30;
  
  final float SPEED_MIN = 0.001;
  final float SPEED_MAX = 0.1;
  
  final int LINK_NUMBER_MIN = 2;
  final int LINK_NUMBER_MAX = 5;
  
  
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
  BiquadFilter lpUgen;
   
  
  Ring(AudioContext ac, int index)
  {
    this.index = index;
    
    this.ac = ac;
    baseFreq = POSSIBLE_FREQS[index % POSSIBLE_FREQS.length];
    
    lpFreqGlide = new Glide(ac, 0, GLIDE_TIME);
    lpRezGlide = new Glide(ac, 0, GLIDE_TIME);
    lpUgen = new BiquadFilter(ac, 2, BiquadFilter.Type.LP);
    lpUgen.setFrequency(lpFreqGlide);
    lpUgen.setQ(lpRezGlide);
           
    center = new PVector(width/2, height/2);  
        
    rotationAngle = 0;
    direction = random(-1, 1) > 0 ? 1 : -1;
        
    numberOfLinks = (int) random(LINK_NUMBER_MIN, LINK_NUMBER_MAX);
    linkSpacing = TAU / numberOfLinks;
    
    Buffer waveType = WAVE_TYPES[(int)random(WAVE_TYPES.length)];
    
    links = new ArrayList<Link>();
    for (int i = 0; i < numberOfLinks; i++) {   
      links.add(new Link(ac, index * 100 + i, calcLinkPosition(i), baseFreq, waveType, lpUgen));
    }
    
    changeRate = random(0.0001, 0.0002);
    
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
    float mY = map(mouseY, height, 0, .25, 1.5);
    float mX = map(mouseX, 0, width, 0, 4);
    speed = map(noise((float)millis() * changeRate * userNoiseScaling + index * 10), 0, 1, SPEED_MIN, SPEED_MAX);
    radius = map(noise((float)millis() * changeRate * userNoiseScaling + index * 11), 0, 1, RADIUS_MIN, RADIUS_MAX) * mY;
    linkSize = (int) map(noise((float)millis() * changeRate + index * 12), 0, 1, LINK_SIZE_MIN, LINK_SIZE_MAX);
    rotationAngle += direction * (speed * mX); 
    for (Link l: links) {
      l.update(linkSize, calcLinkPosition(l.index));
    }
    
    lpFreqGlide.setValue(map(radius, RADIUS_MIN * .25, RADIUS_MAX * 1.5, 100, 9000));
    lpRezGlide.setValue(map(speed * mX, SPEED_MIN * .2, SPEED_MAX * 4, .1, 1));

  }
  
  
  void display()
  {
    for (Link l: links) {
      l.display(); 
    }
  }
  
}