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
  
  
  Link(AudioContext ac, int index, int size, PVector position, float baseFreq)
  {
    this.size = size + (int) random(-9, 9);
    this.position = position;
    
    this.ac = ac;
    
    this.index = index;
    
    this.baseFreq = baseFreq;
    
    linkGainGlide = new Glide(ac, 0, 100);
    linkGainUgen = new Gain(ac, 1, linkGainGlide);
    linkPitchGlide = new Glide(ac, baseFreq, 50);
    linkPanGlide = new Glide(ac, 0, 50);
    linkPanUgen = new Panner(ac, linkPanGlide);
    
    linkWave = new WavePlayer(ac, linkPitchGlide, Buffer.SINE);
    
    linkGainUgen.addInput(linkWave);
    linkPanUgen.addInput(linkGainUgen);
    ac.out.addInput(linkPanUgen);
  }
  
  
  void update(PVector position)
  {
    this.position = position;
    
    linkPitchGlide.setValue(map(position.y, height, 0, baseFreq / 1.02, baseFreq * 1.02));
    linkGainGlide.setValue(map(size, 1, 49, 0.01, .2));
    linkPanGlide.setValue(map(position.x, 0, width, -1, 1));
  }
  
  
  void display()
  {
    fill(100, 50);
    ellipse(position.x, position.y, size, size);
  }
  
  
  void kill()
  {
    linkWave.pause(true);
    linkWave.kill(); 
  }
  
}