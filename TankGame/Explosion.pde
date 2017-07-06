class Explosion{

  PImage[] images ;
  
  PVector pos = new PVector();
  int siz;// = new PVector();
  float scale = 1.2;
  int count;
  int currentFrame;
  int framePerImage = 5;
  
  Explosion(PVector _pos, int _siz, PImage[] _images){
    pos = _pos;
    siz = _siz;
    images = _images;
    count = 0;
  }
 
  void draw(){

    image(images[currentFrame], pos.x,pos.y+10, siz*scale, siz*scale);
  }

  boolean checkActive(){
      count ++;
    currentFrame = count/framePerImage;
     return currentFrame < images.length; 
  }
}