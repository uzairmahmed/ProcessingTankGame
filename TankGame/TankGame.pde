int blockHelth = 4;
PVector blockSize = new PVector (50,50);
int blockColor = 50; int blockColorG = 50; int blockColorB = 50;

//Audio Declarations
import ddf.minim.*;
Minim minim;
AudioPlayer Shoot;

//ArrayLists for Blocks and Explosions
ArrayList<Block> blocks;
ArrayList<Explosion> explosions;

//Array to hold Explosion Images
PImage [] explosion;

//Mouse, Turret, and Projectile Positions / Direction of Player 1
PVector mPos1;
PVector tPos1;
PVector pPos1;
PVector tDir1;
//Mouse, Turret, and Projectile Positions / Direction of Player 2
PVector mPos2;
PVector tPos2;
PVector pPos2;
PVector tDir2;

//Common Velocity and Gravity
PVector pVel;
PVector grav = new PVector(0, 2);

//Screen and Game Setup
void setup() {
  size(1200, 600);
  rectMode(CENTER);
  imageMode(CENTER);
  //Run init function
  init();
}

//Runs once, made to initialize/declare all objects/variables
void init() {
  //Declare ArrayLists
  blocks = new ArrayList<Block>();
  explosions = new ArrayList<Explosion>();
  
  //Load Explosion Images 
  explosion = new PImage[6];
  for (int i = 0; i< explosion.length; i++) {
    explosion[i]= loadImage("explo"+i+".png");
  }
  
  //Load Blocks
  for (int i = 0; i <= 6; i++){
    //delay(1);
    blocks.add(new Block(blocks));
  }
  
  //Initialize/Load Audio
  minim = new Minim(this);
  Shoot = minim.loadFile("shoot.wav");
  
  //Declare PVectors
  pVel = new PVector();

  mPos1 = new PVector();
  tPos1 = new PVector(width/8, height);
  pPos1 = new PVector(-1000, -1000);
  tDir1 = new PVector(0,0);
  
  mPos2 = new PVector();
  tPos2 = new PVector(width/8, height);
  pPos2 = new PVector(-1000, -1000);
  tDir2 = new PVector(0,0);
}

//HitDetect Function Made by Mr. Rowbottom 
boolean hitDetect(PVector pos1, PVector pos2, float size1, float size2){
  return(PVector.dist(pos1,pos2) < (size1 + size2)/2.);
}

//Runs when Mouse is Pressed -- WILL BE REPLACED
void mousePressed(){

}


void keyPressed(){
  if (keyCode == ' '){
    // Declare Explosion Size and Position
    PVector eSiz = new PVector (200, 200);
    PVector ePos = new PVector (tPos1.x + tDir1.x + (tDir1.x/2), tPos1.y + tDir1.y+(tDir1.y/2));
  
    //EXPLODE STUFF
    explosions.add(new Explosion(ePos, eSiz, explosion));
    Shoot.play(0);
    
    //Launch Projectile
    pPos1.set(tPos1);
    pVel.set(tDir1);
  }
  
  if (keyCode == ENTER){
    // Declare Explosion Size and Position
    PVector eSiz = new PVector (200, 200);
    PVector ePos = new PVector (tPos2.x + tDir2.x + (tDir2.x/2), tPos2.y + tDir2.y+(tDir2.y/2));
  
    //EXPLODE STUFF
    explosions.add(new Explosion(ePos, eSiz, explosion));
    Shoot.play(0);
    
    //Launch Projectile
    pPos2.set(tPos2);
    pVel.set(tDir2);
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
    
    if (hitDetect(pPos1, b.pos, 10, 100)){
      b.takeDamage();
      pPos1.set(-1000,-1000);
      delay(10);
    }
    if (hitDetect(pPos2, b.pos, 10, 100)){
      b.takeDamage();
      pPos2.set(-1000,-1000);
      delay(10);
    }
    
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
  
  if (pPos1.x!= -1000) {
    pVel.add((grav));
    pPos1.add(pVel);
  }
  
  if (pPos2.x!= -1000) {
    pVel.add((grav));
    pPos2.add(pVel);
  }
  
  mPos1.set(mouseX, mouseY);
  tDir1 = PVector.sub(mPos1,tPos1);
  tDir1.normalize();
  tDir1.mult(50);  
 
  mPos2.set(mouseX, mouseY);
  tDir2 = PVector.sub(mPos2,tPos2);
  tDir2.normalize();
  tDir2.mult(50);  
 
  //circle
  fill(255,0,0);
  ellipse(tPos1.x, tPos1.y, 40, 40);
  //terminalArm
  strokeWeight(5);
  line(tPos1.x, tPos1.y, tPos1.x + tDir1.x, tPos1.y + tDir1.y);
  //dotSight
  fill(255, 0, 0);
  ellipse(tPos1.x + tDir1.x, tPos1.y + tDir1.y, 10, 10);
  //bullet
  ellipse(pPos1.x, pPos1.y, 10, 10);
  
  
  //circle
  fill(255,0,0);
  ellipse(tPos2.x, tPos2.y, 40, 40);
  //terminalArm
  strokeWeight(5);
  line(tPos2.x, tPos2.y, tPos2.x + tDir2.x, tPos2.y + tDir2.y);
  //dotSight
  fill(255, 0, 0);
  ellipse(tPos2.x + tDir2.x, tPos2.y + tDir2.y, 10, 10);
  //bullet
  ellipse(pPos2.x, pPos2.y, 10, 10);
  
  
  
 if (keyPressed){
    if (key == 'a' && tPos1.x > 9){
      tPos1.x -= 10;
    }
    else if (key == 'd'&& tPos1.x < width-9){
      tPos1.x += 10;
    }
    else if (key == 'w'){
      //tPos1.y -= 100;
      
    }
    else if (key == 's'){
      //tPos1.y += 100;
    }
    
    
    if (keyCode == LEFT && tPos1.x > 9){
      tPos2.x -= 10;
    }
    else if (keyCode == RIGHT && tPos1.x < width-9){
      tPos2.x += 10;
    }
    else if (keyCode == UP){
      //tPos2.y -= 100;
    }
    else if (keyCode == DOWN){
      //tPos2.y += 100;
    }
  }
}