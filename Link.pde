class Link
{
  int index; 
  
  PVector position;
  int size;
  
  AudioContext ac;
  
  WavePlayer linkWave;
  Glide linkGainGlide;
  Gain linkGainUgen;
  Glide linkPitchGlide;
  Panner linkPanUgen;
  Glide linkPanGlide;
  
  float baseFreq;
  
  //LPRezFilter lpUgen;
  
  final int SIZE_VARIATION = 15;
  final float FREQ_RANGE = 1.025;
  
  final float GAIN_MIN = 0.01;
  final float GAIN_MAX = 0.02;
  
  Buffer waveType;
  
  Link(AudioContext ac, int index, int size, PVector position, float baseFreq, Buffer waveType, BiquadFilter lpUgen)
  {
    this.index = index; 
    
    this.size = size + (int) random(-SIZE_VARIATION, SIZE_VARIATION);
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
  
  
  void update(PVector position)
  {
    this.position = position;
    
    linkPitchGlide.setValue(map(position.y, height, 0, baseFreq / FREQ_RANGE, baseFreq * FREQ_RANGE));
    linkGainGlide.setValue(map(size, 5, 45, GAIN_MIN, GAIN_MAX));
    linkPanGlide.setValue(map(position.x, 0, width, -1, 1));
  }
  
  
  void display()
  {
    fill(baseFreq / 2, 150);
    ellipse(position.x, position.y, size, size);
  }
  
  
  void kill()
  {
    linkWave.pause(true);
    linkWave.kill(); 
  }
  
}