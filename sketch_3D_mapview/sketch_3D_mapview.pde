import queasycam.*;
Terrain t;
QueasyCam cam;
float scl = 0.005;
int min = 0;
int max = 80;
void setup(){
  	size(1024,720,P3D);
  	
  	cam = new QueasyCam(this);
	cam.speed = 5;              // default is 3
	cam.sensitivity = 0.5;      // default is 2
  	 //<>//
  	t = new Terrain(width, height, min, max, scl, 1);

}

void draw(){
  background(255);
  //stroke(255);
  noStroke();
  //lights();
  image(t.texture,0,0);
  t.show();
}
