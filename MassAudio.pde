class MassAudio
{
  AudioContext ac;
  
  
  ArrayList<RingAudio> ringAudios;
  
  
  MassAudio()
  {
    ringAudios.add(new RingAudio(ac, 0));
    
    ac.start();
    
  }
  
  
 
  
}