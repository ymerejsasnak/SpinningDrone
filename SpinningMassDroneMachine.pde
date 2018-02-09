//cleanup code stuff

// fix audio, esp loading/start and end/kill stuff
//(fade in, fade out?)

// freq should be able to go very high (4 or 5?)(maybe have keyboard command to tgoggl multiplier to freq range?)

//smooth out changes in noise rate control (ie changes to target value, actual value approaches mathematically)

// also some sort of glitch/error related to panner...only occasionally, not sure how to reproduce yet


import beads.*;


Mass mass;


final int GLIDE_TIME = 5;

final float FREQ_RANGE_MIN = 1.005;
final float FREQ_RANGE_MAX = 1.1;

float currentFreqRange;
boolean rightButtonToggle;

final float NOISE_SCALING_MIN = 0.1;
final float NOISE_SCALING_MAX = 100;

float userNoiseScaling = 1;

void setup()
{
  size(1000, 800);
  background(10);  
  
  rectMode(CENTER);
  ellipseMode(CENTER);
  
  mass = new Mass();
  currentFreqRange = FREQ_RANGE_MIN; 
  rightButtonToggle = true;
}


void draw()
{
  //background(100);
  float c = random(100, 220);
  fill((currentFreqRange - 1) * 2000, c, c, 5);
  rect(width/2, height/2, width, height);
  mass.update();
  mass.display();
  
  fill(200);
  text((int) frameRate, 10, 10);
  
}


void mousePressed()
{
  if (mouseButton == LEFT) {
    mass.addRing();
  } else if (mouseButton == RIGHT) {
    rightButtonToggle = !rightButtonToggle; 
  }
}

void mouseWheel(MouseEvent e)
{
  if (rightButtonToggle) {
    if (e.getCount() < 0) {
       currentFreqRange *= 1.004;
     } else {
       currentFreqRange /= 1.004;
     }
    currentFreqRange = constrain(currentFreqRange, FREQ_RANGE_MIN, FREQ_RANGE_MAX);
  } else {
     if (e.getCount() < 0) {
       userNoiseScaling *= 1.1;
     } else {
       userNoiseScaling /= 1.1; 
     }
    userNoiseScaling = constrain(userNoiseScaling, NOISE_SCALING_MIN, NOISE_SCALING_MAX);
  }
}