// more interaction

//cleanup code stuff

// fix audio, esp loading/start and end/kill stuff

// right click to turn from constant to 0 with adding env segments whenever 0 gain (then mousex also controls env length?)

// add delay/verb before main out?

// mousewheel should control something too? -- y pos freq range!

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
  
  fill(200);
  text((int) frameRate, 10, 10);
  
}


void mousePressed()
{
  mass.addRing();
}