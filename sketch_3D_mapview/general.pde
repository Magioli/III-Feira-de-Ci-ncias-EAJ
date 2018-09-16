ArrayList <Integer> gradient(String string){
  ArrayList <Integer> gradient = new ArrayList<Integer>();
  PImage im;
  im = loadImage("C:\\Users\\luanl\\Pictures\\PDI\\Gradient\\"+string);
  im.loadPixels();
  for(int i=1; i<im.width; i++)
  gradient.add(color(im.pixels[i]));
  return gradient;
}
