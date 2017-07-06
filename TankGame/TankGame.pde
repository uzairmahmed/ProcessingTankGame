/*
Uzair
TODO:
use arrow keys to aim
*/


//-----------------Constants-----------------//


//Import Audio Library
import ddf.minim.*; 
Minim minim;
AudioPlayer Shoot;
AudioPlayer Block;
AudioPlayer Dead;
AudioPlayer Time;
AudioPlayer Win;

//Initialize Fonts for display on Screen
PFont f;

//ArrayLists for Blocks, Explosions, and Bullets      
ArrayList<Block> blocks;
ArrayList<Explosion> explosions;
ArrayList<Bullet> bullets1;
ArrayList<Bullet> bullets2;

//Import Turret Objects
Turret turret1;
Turret turret2;

//Import Powerup Block
UnlAmmo powerup;

//Array to hold Explosion Images
PImage [] explosion;

//Velocity and MousePos PVector Initializations
PVector pVel;
PVector mPos;

int ammo = 100;
int turret1Ammo = 0;
int turret2Ammo = 0;

//GameState Variable
int gameState = 0;


//-----------------Core-----------------//


//Screen and Game Setup
void setup() {
  size(1200, 600);
  f = loadFont("ComicSansMS-48.vlw");
  rectMode(CENTER);
  imageMode(CENTER);
  //Run init function
  init();
}

//Runs once, made to initialize/declare all objects/variables
void init() {
  //Declare ArrayLists
  blocks     = new ArrayList<Block>    ();
  explosions = new ArrayList<Explosion>();
  bullets1   = new ArrayList<Bullet>   ();
  bullets2   = new ArrayList<Bullet>   ();

  //Load Explosion Images 
  explosion = new PImage[6];
  for (int i = 0; i< explosion.length; i++) {
    explosion[i]= loadImage("explo"+i+".png");
  }
  
  //Initialize/Load Audio
  minim = new Minim(this);
  Shoot = minim.loadFile("shoot.wav");
  Block = minim.loadFile("block.wav");
  Dead = minim.loadFile("dead.wav");
  Time = minim.loadFile("time.wav");
  Win = minim.loadFile("win.wav");

  
  //Initialize Player Turrets
  turret1 = new Turret(new PVector(width/8,height), 0, 255, 32, 32);
  turret2 = new Turret(new PVector((width/8)*7,height), 1, 32, 32, 255);
  
  //Initialize powerup block
  powerup = new UnlAmmo(new PVector(width/2, 50), new PVector(30,30));
}

//Runs repeatedly, used as a gameState manager
void draw() {
  if (gameState == 0){
  startScreen();
  } else if (gameState == 1){
  game();
  } else if (gameState == 2){
  end1();
  } else if (gameState == 3){
  end2();
  }
}


//-----------------Specific Gamestates-----------------//


//Runs when gameState is 0 i.e. the program has just run.
void startScreen(){
  background(0);
  textFont(f,48);
  fill(255);
  text("TANK GAME (btw, the timer's already running",100,100);
  text ("HOW TO PLAY: youll figure it out", width/2-500, height/2);
  text ("Press any key to continue",0, height-100);
  if (keyPressed){
  gameState = 1;
  }
}

//Runs when gameState is 1. i.e. the user has cliecked a button.
void game(){
  background(150);
  textFont(f,35);
  fill(0);
  
  int tim = timer(60000);
  surface.setTitle("Tank Game. Time Left:" + str(tim));
  if (tim == 10){
   Time.play(0); 
  }
  if (tim==0){
  gameOverManager();
  }
  
  text(((ammo-turret1Ammo) + "/" + ammo), 50,150);
  text(((ammo-turret2Ammo) + "/" + ammo), width-250,150);
  //Manager for all things respective to thier names.
  blockRunner();
  explosionRunner();
  bulletRunner();
  turretRunner();
  powerupRunner();
  inGameKeyPressedManager();
}

void end1(){
  background(255);
  text("ONE WINS", width/2, height/2);
  Win.play(0);
  delay(6000);
}

void end2(){
  background(255);
  text("TWO WINS", width/2, height/2);
  Win.play(0);
  delay(6000);

}


//-----------------Object Managers-----------------//


void blockRunner(){
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
    
    //Go through each bullet1 to check if it has hit the block in question.
    for (int j = 0; j<bullets1.size(); j++){
      Bullet bbcheck1 = bullets1.get(j);
      if (hitDetect(bbcheck1.pos, b.pos, 10, 100)){
        explode(b.pos,100,2);
        b.takeDamage();
        bbcheck1.deactivate();
        bullets1.remove(bbcheck1);
        delay(10);
      }
    }
    
    //Go through each bullet2 to check if it has hit the block in question.
    for (int k = 0; k<bullets2.size(); k++){
      Bullet bbcheck2 = bullets2.get(k);
      if (hitDetect(bbcheck2.pos, b.pos, 10, 100)){
        explode(b.pos,100,2);
        b.takeDamage();
        bbcheck2.deactivate();
        bullets2.remove(bbcheck2);
        delay(10);
      }
    }
  }
  if (blocks.size() == 0){
    for (int i = 0; i <= 8; i++){
      blocks.add(new Block(blocks));
    }
  }
}


void explosionRunner(){
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


void bulletRunner(){
 //Use a for loop to go through each player 1 bullet.
  for (int i = 0; i<bullets1.size(); i++){
    Bullet bb1 = bullets1.get(i);
    bb1.update();
    bb1.draw();
    if ((bb1.pos.y > height)||(bb1.pos.x > width)|| (bb1.pos.x < 0)){
      bb1.deactivate();
      bullets1.remove(bb1);
    }
    if(hitDetect(bb1.pos, turret1.pos, 10,80)){
      explode(turret1.pos,160,1);
      turret1.takeDamage();
      bb1.deactivate();
      bullets1.remove(bb1);
    }
    if(hitDetect(bb1.pos, turret2.pos, 10,80)){
      explode(turret2.pos,160,1);
      turret2.takeDamage();
      bb1.deactivate();
      bullets1.remove(bb1);
    }
    if(hitDetect(bb1.pos, powerup.pos, 10, powerup.siz.x)){
      powerup.activated1 = true;
      powerup.deactivate();
    }
  }
  //Use a for loop to go through each player 2 bullet.
  for (int i = 0; i<bullets2.size(); i++){
    Bullet bb2 = bullets2.get(i);
    bb2.update();
    bb2.draw();
    if ((bb2.pos.y > height)||(bb2.pos.x > width)|| (bb2.pos.x < 0)){
      bb2.deactivate();
      bullets1.remove(bb2);
    }
    if(hitDetect(bb2.pos, turret1.pos, 10,80)){
      explode(turret1.pos,160,1);
      turret1.takeDamage();
      bb2.deactivate();
      bullets2.remove(bb2);
    }
    if(hitDetect(bb2.pos, turret2.pos, 10,80)){
      explode(turret2.pos,160,1);
      turret2.takeDamage();
      bb2.deactivate();
      bullets2.remove(bb2);
    }
    if(hitDetect(bb2.pos, powerup.pos, 10,powerup.siz.x)){
      powerup.activated2 = true;
      powerup.deactivate();
    }
  } 
}


void turretRunner(){
  turret1.update();
  turret1.draw();
  turret2.update();
  turret2.draw();  
  
  if (turret1.isAlive == 0){
    Dead.play(0);
    delay(3000);
    gameState = 3;
  }
  if (turret2.isAlive == 0){
    Dead.play(0);
    delay(3000);
    gameState = 2;
  }  
}

void powerupRunner(){
 powerup.update();
 powerup.draw();
}

void inGameKeyPressedManager(){
  if (keyPressed){
    if (key == 'a' && turret1.pos.x > 25){
      turret1.pos.x -= 10;
    }
    else if (key == 'd'&&(turret1.pos.x < (width/2)-25-25)){
      turret1.pos.x += 10;
    }
    else if (key == 'w'){
      //aim up;
      
    }
    else if (key == 's'){
      //aim down
    }
    
    
    if (keyCode == LEFT && turret2.pos.x > (width/2)+25+25){
      turret2.pos.x -= 10;
    }
    else if (keyCode == RIGHT && turret2.pos.x < width-25){
      turret2.pos.x += 10;
    }
    else if (keyCode == UP){
      //aim up;
    }
    else if (keyCode == DOWN){
      //aim down
    }
  }
}

void gameOverManager(){
 if (turret1.health > turret2.health){
   gameState = 2;
 }
  if (turret1.health < turret2.health){
   gameState = 3;
 }
  if (turret1.health == turret2.health){
   gameState = 4;
 }
}

//-----------------Miscellaneous Functions-----------------//


//HitDetect Function Made by Mr. Rowbottom 
boolean hitDetect(PVector pos1, PVector pos2, float size1, float size2){
  return(PVector.dist(pos1,pos2) < (size1 + size2)/2.f);
}

//Runs when specific keys are pressed.
void keyPressed(){
  if (keyCode == ' '){
    if (ammo-turret1Ammo > 0){    
      //Launch bullet
      bullets1.add(new Bullet(turret1.pos, turret1.dir));
      if (powerup.activated1 == false){
      turret1Ammo++;
      }
    }
  }
  
  if (keyCode == ENTER){
    if (ammo-turret2Ammo > 0){
      bullets2.add(new Bullet(turret2.pos, turret2.dir));
      if (powerup.activated2 == false){
      turret2Ammo++;
      }
    }
  }
}
  
  int timer(int len) {
    int timeLeft = len-millis();
    return timeLeft/1000;
  }
  
  void explode(PVector pos,int siz, int sound){
    if (sound == 1){
      Shoot.play(0);
    }
    if (sound == 2){
      Block.play(0);
    }
    explosions.add(new Explosion(pos, siz, explosion));
  }
  