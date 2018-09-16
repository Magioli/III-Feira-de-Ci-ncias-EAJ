class Terrain{
	int[]  map;
	PImage texture;
	PShape ground;
	float  Xsize;
	float  Zsize;
	float  Ymin;
	float  Ymax;
	float scale;
	ArrayList <Integer> gradient;

	Terrain(float Xsize, float Zsize, float Ymin, float Ymax, float scale, int scl){
		this.Zsize = Zsize;
		this.Xsize = Xsize;
		this.Ymin  = Ymin;
		this.Ymax  = Ymax;
		this.scale = scale;
		mapGenerator();
		textureGenerator();
		groundGenerator(scl);
	}

	Terrain(float Xsize, float Zsize, float Ymin, float Ymax, float scale, int scl, int[] map){
		this.Zsize = Zsize;
		this.Xsize = Xsize;
		this.Ymin  = Ymin;
		this.Ymax  = Ymax;
		this.scale = scale;
		this.map   = map;
		textureGenerator();
		groundGenerator(scl);
	}

	Terrain(float Xsize, float Zsize, float Ymin, float Ymax, float scale, int scl, int[] map, PImage texture){
		this.Zsize   = Zsize;
		this.Xsize   = Xsize;
		this.Ymin    = Ymin;
		this.Ymax    = Ymax;
		this.scale = scale;
		this.map     = map;
		this.texture = texture;
		groundGenerator(scl);
	}

	void mapGenerator(){
		map = new int[int(Xsize + (Zsize*Xsize))];
		float xoff = 0;
		float yoff = 0;
		int index;
		for (int x = 0; x < Xsize; x++) {
			yoff = 0;
			for (int y = 0; y < Zsize; y++) {
				index = int(x + (y*Xsize));
				map[index] = int(map(noise(xoff, yoff), 0, 1, 0, 2047));
				yoff += scale;
			}
			xoff += scale;
		}
	}

	void textureGenerator(){
		this.gradient = gradient("gradient1.jpg"); //<>// //<>// //<>// //<>//
		float rows = max(this.map);
		float cols = min(this.map);
		int index;
		this.texture = createImage(int(Xsize), int(Zsize), RGB); //<>// //<>// //<>// //<>//
		for (int x = 0; x < Xsize; x++) {
			for (int y = 0; y < Zsize; y++) {
				index = int(x + (y*Xsize));
				color c = gradient.get(int(map(this.map[index], cols, rows, 0, gradient.size()-1)));
				texture.pixels[index] = c;
			}
		}
	}

	void groundGenerator(int scale){
		texture.resize(int(Xsize/scale),int(Zsize/scale));
		ground = createShape(GROUP);
		int index;
		float changeU = texture.width; 
		float changeV = texture.height;
		float u = 0;
		float v = 0;
		for(int y=0; y<Zsize; y++) {
			PShape d = createShape();
			d.beginShape(TRIANGLE_STRIP);
			d.noStroke();
			d.textureMode(IMAGE);
			textureWrap(REPEAT);
			d.texture(texture);
			for(int x=0; x<Xsize; x++) {
				index = int(x + (y*Xsize));
				d.vertex(x*scale, y*scale,this.map[index],u,v);
				d.vertex(x*scale, (y+1)*scale,this.map[index],u,v+changeV);
        color c = texture.pixels[index];
        fill(c);
				u+=changeU;
			}
			v+=changeV;
			u=0;
			
			d.endShape(CLOSE);
			ground.addChild(d);
		}
		ground.rotateX(-HALF_PI);
	}

  	void show(){
		//background(0);
		//shape(ground, 0, height/2);
		rotateX(PI/2);
  
		float rows = max(this.map);
		float cols = min(this.map);
		int index;
		for (int x = 0; x < Xsize; x++) {
			for (int y = 0; y < Zsize; y++) {
				index = int(x + (y*Xsize));
				color c = texture.pixels[index];
				pushMatrix();
				fill(c);
				translate(0, 0,map(this.map[index], cols, rows, min, max));
				ellipse(x, y, 1, 1);
				popMatrix();
			}
		}
//		shape(ground, 0, height/2);
	}
}
