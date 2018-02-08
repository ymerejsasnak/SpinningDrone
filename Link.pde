class Link
{
  final int SIZE_VARIATION = 20;
  final float FREQ_RANGE = 1.02; // mousewheel changes this! (for subtle drone, 1.015 is good, but higher values are cool too!)
  
  final float GAIN_MIN = 0.001;
  final float GAIN_MAX = 0.02;
  
  
  int index; 
  
  PVector position;
  int linkSize;
  float variation;
  
  AudioContext ac;
  
  WavePlayer linkWave;
  Glide linkGainGlide;
  Gain linkGainUgen;
  Glide linkPitchGlide;
  Panner linkPanUgen;
  Glide linkPanGlide;
  
  float baseFreq;
  
  Buffer waveType;
  
  
  Link(AudioContext ac, int index, PVector position, float baseFreq, Buffer waveType, BiquadFilter lpUgen)
  {
    this.index = index; 
        
    this.position = position;
    
    this.ac = ac;

    this.baseFreq = baseFreq;
    this.waveType = waveType;
    
    linkGainGlide = new Glide(ac, 0, GLIDE_TIME);
    linkGainUgen = new Gain(ac, 1, linkGainGlide);
    linkPitchGlide = new Glide(ac, baseFreq, GLIDE_TIME);
    linkPanGlide = new Glide(ac, 0, GLIDE_TIME);
    linkPanUgen = new Panner(ac, linkPanGlide);
    
    linkWave = new WavePlayer(ac, linkPitchGlide, waveType);
    
    linkGainUgen.addInput(linkWave);
    linkPanUgen.addInput(linkGainUgen);
    lpUgen.addInput(linkPanUgen);
  }
  
  
  void update(int linkSize, PVector position)
  {
    this.position = position;
    
    this.linkSize = linkSize;
    variation = map(noise((float)millis() *  0.001 + index * 100), 0, 1, -SIZE_VARIATION, SIZE_VARIATION);
    
    linkPitchGlide.setValue(map(position.y, height, 0, baseFreq / FREQ_RANGE, baseFreq * FREQ_RANGE));
    linkGainGlide.setValue(map(linkSize + variation, 0, 50, GAIN_MIN, GAIN_MAX));
    linkPanGlide.setValue(map(position.x, 0, width, -1, 1));
  }
  
  
  void display()
  {
    int c = (int)baseFreq / 4;
    int alpha = 150;
    
    
    if (waveType == Buffer.NOISE) {
      fill(random(c), alpha);
      rect(position.x + randomGaussian() * 2, position.y + randomGaussian() * 2, linkSize + variation, linkSize + variation);
      return;
    }
    
    if      (waveType == Buffer.TRIANGLE) fill(0, 0, c, alpha);
    else if (waveType == Buffer.SQUARE)   fill(0, c, 0, alpha);
    else if (waveType == Buffer.SAW)      fill(c, 0, 0, alpha);
    
    ellipse(position.x, position.y, linkSize + variation, linkSize + variation);
  }
    
}