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
  mPos1 = new PVector();
  tPos1 = new PVector(width/8, height);
  pPos1 = new PVector(-1000, -1000);
  tDir1 = new PVector(); //
  pVel = new PVector();
}

//HitDetect Function Made by Mr. Rowbottom 
boolean hitDetect(PVector pos1, PVector pos2, float size1, float size2){
  return(PVector.dist(pos1,pos2) < (size1 + size2)/2.);
}

//Runs when Mouse is Pressed -- WILL BE REPLACED
void mousePressed(){
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


void keyPressed(){
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
  
  if (keyPressed){
    if (key == 'a' && tPos1.x > 9){
      tPos1.x -= 10;
    }
    else if (key == 'd'&& tPos1.x < width-9){
      tPos1.x += 10;
    }
    else if (key == 'w' && tPos1.y > 9){
      tPos1.y -= 10;
    }
    else if (key == 's'&& tPos1.y < height-9){
      tPos1.y += 10;
    }
  }
  if (pPos1.x!= -1000) {
    pVel.add((grav));
    pPos1.add(pVel);
  }
  mPos1.set(mouseX, mouseY);
  tDir1 = PVector.sub(mPos1, tPos1);
  tDir1.normalize();
  tDir1.mult(50);  
      
  fill(255);
  ellipse(tPos1.x, tPos1.y, 40, 40);
  strokeWeight(5);
  line(tPos1.x, tPos1.y, tPos1.x + tDir1.x, tPos1.y + tDir1.y);
  fill(255, 0, 0);
  ellipse(tPos1.x + tDir1.x, tPos1.y + tDir1.y, 10, 10);
  //bullet
  ellipse(pPos1.x, pPos1.y, 10, 10);
}