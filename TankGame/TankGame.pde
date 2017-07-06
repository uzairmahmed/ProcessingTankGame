ArrayList<Block> blocks;
ArrayList<Explosion> explosions;
//PImage array to hold images
PImage [] explosion;

void setup() {
  size(800, 600);
  rectMode(CENTER);
  imageMode(CENTER);
  init();
}
void init() {
  //finish declaring the arraylist 
  blocks = new ArrayList<Block>();
  explosions = new ArrayList<Explosion>();
  //load the explosions images
  explosion = new PImage[6];
  //use for loop 
  for (int i = 0; i< explosion.length; i++) {
    //load image in the 
    explosion[i]= loadImage("explo"+i+".png");
  }
}
void mousePressed(){
  PVector mouse = new PVector (mouseX, mouseY);
  PVector siz = new PVector (60, 30);
  explosions.add(new Explosion(mouse, siz, explosion)); //position vector, size vector, pimage array
  blocks.add(new Block(blocks));
}
void keyPressed(){
  if (keyCode ==LEFT && blocks.size()>0){
    blocks.get(0).takeDamage();
  }
}
void draw() {
  background(150);
  //use a forloop to go through each block 
  for (int i = 0; i < blocks.size(); i++) {
    //make a temp Block reference
    Block b = blocks.get(i);
    //update each block
    b.update();
    //check each block 
    b.check();
    //draw each block
    b.draw();
  }
  //use a for loop to go through each explosion
  for (int i = 0; i<explosions.size();i++){
    //make a temp explosion variable 
    Explosion e = explosions.get(i);
    //update each explosion
    if (e.checkActive()){
      e.draw();
    }
     else{
       explosions.remove(e);
  }
}
}