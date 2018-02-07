import beads.*;


Mass mass;


final int GLIDE_TIME = 25;
  

void setup()
{
  size(600, 600);
  background(10);  
  
  rectMode(CENTER);
  ellipseMode(CENTER);
  
  
  mass = new Mass();
  
}


void draw()
{
  background(10);
  
  mass.update();
  mass.display();
  
  println(frameRate);
  
}


void mousePressed()
{
  // this is only temporary...need to do this cleaner
  mass.killAll();
  mass = new Mass(); 
}