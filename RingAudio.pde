class RingAudio
{
  AudioContext ac;
  
  int index;
  
  float baseFreq;
  int totalLinks;
  
  ArrayList<LinkAudio> linkAudios;
  
  
  RingAudio(AudioContext ac, int index)
  {
    this.ac = ac;
    
    linkAudios = new ArrayList<LinkAudio>();
    
    totalLinks = mass.getLinksInRing(index);
    
    for (int i = 0; i < totalLinks; i++) {
      linkAudios.add(new LinkAudio(ac, i, baseFreq));  
    }
    
  }
  
}