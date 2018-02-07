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
  
  
  final int SIZE_VARIATION = 9;
  final float FREQ_RANGE = 1.01;
  
  final float GAIN_MIN = 0.01;
  final float GAIN_MAX = 0.02;
  
  
  Link(AudioContext ac, int index, int size, PVector position, float baseFreq)
  {
    this.index = index; 
    
    this.size = size + (int) random(-SIZE_VARIATION, SIZE_VARIATION);
    this.position = position;
    
    this.ac = ac;

    this.baseFreq = baseFreq;
    
    linkGainGlide = new Glide(ac, 0, 100);
    linkGainUgen = new Gain(ac, 1, linkGainGlide);
    linkPitchGlide = new Glide(ac, baseFreq, 100);
    linkPanGlide = new Glide(ac, 0, 100);
    linkPanUgen = new Panner(ac, linkPanGlide);
    
    linkWave = new WavePlayer(ac, linkPitchGlide, Buffer.TRIANGLE);
    
    linkGainUgen.addInput(linkWave);
    linkPanUgen.addInput(linkGainUgen);
    ac.out.addInput(linkPanUgen);
  }
  
  
  void update(PVector position)
  {
    this.position = position;
    
    linkPitchGlide.setValue(map(position.y, height, 0, baseFreq / FREQ_RANGE, baseFreq * FREQ_RANGE));
    linkGainGlide.setValue(map(size, 1, 49, GAIN_MIN, GAIN_MAX));
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