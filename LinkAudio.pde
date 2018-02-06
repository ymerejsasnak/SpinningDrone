class LinkAudio
{
  AudioContext ac;
  
  int index;
  
  WavePlayer linkWave;
  Glide linkGainGlide;
  Gain linkGainUgen;
  Glide linkPitchGlide;
  
  float baseFreq;
  
  LinkAudio(AudioContext ac, int index, float baseFreq)
  {
    this.ac = ac;
    
    this.index = index;
    
    this.baseFreq = baseFreq;
    
    linkGainGlide = new Glide(ac, .1, 100);
    linkGainUgen = new Gain(ac, 1, linkGainGlide);
    linkPitchGlide = new Glide(ac, baseFreq, 100);
    
    linkWave = new WavePlayer(ac, linkPitchGlide, Buffer.SINE);
    
    linkGainUgen.addInput(linkWave);
    ac.out.addInput(linkGainUgen);
  }
  
}