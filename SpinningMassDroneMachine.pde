import beads.*;


Mass mass;


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
  mass = new Mass(); 
}