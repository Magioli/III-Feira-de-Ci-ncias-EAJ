class Player extends QueasyCam {
  PVector dimensions;
  PVector velocity;
  PVector gravity;
  boolean grounded;
  
  Player(PApplet applet){
    super(applet);
    speed = 0.4;
    dimensions = new PVector(1, 3, 1);
    velocity = new PVector(0, 0, 0);
    gravity = new PVector(0, 0.02, 0);
    grounded = false;
  }
  
}
