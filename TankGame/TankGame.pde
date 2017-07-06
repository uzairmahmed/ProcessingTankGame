/*
Uzair - Tank Game Version 0.8
19 May, 3017

 - Use Arrow keys/WASD to move.
 - Destroy the other turret by breaking through the wall
   and shooting the turret in under sixty seconds.
 
 KNOWN BUGS:
 - Two people cannot move at the same time, because 
   processing can only process-(haha get it?) one function
   at a time.
 
 - Shooting the the turret arm does not damage the
   turret -- It only makes it ANGRY

 - Only the MousePos can be used to aim -- both tanks
   so... Rock, Paper, Scissors on who gets the mouse?
   
 - Tracer code is somewhat inneficient. For better performance
   comment out line 171.
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

//Tracer Booleans
Boolean check1 = false;
Boolean check2 = false;

//ArrayLists for Blocks, Explosions, and Bullets      
ArrayList<Block> blocks;
ArrayList<Explosion> explosions;
ArrayList<Bullet> bullets1;
ArrayList<Bullet> bullets2;
ArrayList<Tracer> tracer1;
ArrayList<Tracer> tracer2;

//Import Turret Objects
Turret turret1;
Turret turret2;

//Import Powerup Block
UnlAmmo powerup;

//Array to hold Explosion Images
PImage [] explosion;

//Int Values for Ammo
int ammo = 100;
int turret1Ammo = 0;
int turret2Ammo = 0;

//GameState Variable
int gameState = 0;


//-----------------Core-----------------//


//Screen and Game Setup
void setup() {
  size(1200, 600);
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
  f = loadFont("ComicSansMS-48.vlw");
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
  tracer1    = new ArrayList<Tracer>   ();
  tracer2    = new ArrayList<Tracer>   ();

  //Load Explosion Images 
  explosion = new PImage[6];
  for (int i = 0; i< explosion.length; i++) {
    explosion[i]= loadImage("explo"+i+".png");
  }
  
  //Initialize/Load Audio Files
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
  } else if (gameState == 4){
  end3();
  }
}


//-----------------Specific Gamestates-----------------//


//Runs when gameState is 0 i.e. the program has just run.
void startScreen(){
  background(0);
  textFont(f,48);
  fill(255);
  text("UZAIR'S TANK GAME",width/2,100);
  text ("HOW TO PLAY", width/2, 200);
  text ("use arrow keys/wasd to move and aim.", width/2, height/2);
  text ("(Aim both tanks with mouse...for now.)", width/2, height/2+100);
  text("Click to Play",width/2,height-25);
  if(mousePressed){
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
  
  text(((ammo-turret1Ammo) + "/" + ammo), width*0.25,150);
  text(((ammo-turret2Ammo) + "/" + ammo), width*0.75,150);
  //Manager for all things respective to thier names.
  blockRunner();
  explosionRunner();
  tracerRunner(); //<-------------------------------------Comment this line for better performance. 
  bulletRunner();
  turretRunner();
  powerupRunner();
  inGameKeyPressedManager();
}

void end1(){
  background(255);
  text("ONE WINS!", width/2, height/2);
  Win.play(0);
  delay(6000);
}

void end2(){
  background(255);
  text("TWO WINS!", width/2, height/2);
  Win.play(0);
  delay(6000);
}

void end3(){
  background(255);
  text("TIE!", width/2, height/2);
  Win.play(0);
  delay(6000);
}


//-----------------Object Managers-----------------//

//Block Class Manager
void blockRunner(){
  //Go through each block 
  for (int i = 0; i < blocks.size(); i++) {
    //Make a Block reference
    Block b = blocks.get(i);
    //Update block
    b.update();
    //Check block 
    b.check();
    //Draw block
    b.draw();
    
    //Go through each bullet1 to check if it has hit the block in question.
    for (int j = 0; j<bullets1.size(); j++){
      //Make a Bullet Reference
      Bullet bbcheck1 = bullets1.get(j);
      //Check for Hitdetection between the Block and Bullet
      if (hitDetect(bbcheck1.pos, b.pos, 10, 100)){
        //Run animation, take block damage, deactivate bullet.
        explode(b.pos,100,2);
        b.takeDamage();
        bbcheck1.deactivate();
        bullets1.remove(bbcheck1);
        delay(10);
      }
    }
    
    //Go through each bullet2 to check if it has hit the block in question.
    for (int k = 0; k<bullets2.size(); k++){
      //Make a Bullet Reference
      Bullet bbcheck2 = bullets2.get(k);
      //Check for Hitdetection between the Block and Bullet
      if (hitDetect(bbcheck2.pos, b.pos, 10, 100)){
        //Run animation, take block damage, deactivate bullet.
        explode(b.pos,100,2);
        b.takeDamage();
        bbcheck2.deactivate();
        bullets2.remove(bbcheck2);
        delay(10);
      }
    }
  }
  //Spawn new blocks if blockList is empty.
  if (blocks.size() == 0){
    for (int i = 0; i <= 8; i++){
      blocks.add(new Block(blocks));
    }
  }
}

//Bullet Class Manager
void bulletRunner(){
 //Go through each player 1 bullet.
  for (int i = 0; i<bullets1.size(); i++){
    Bullet bb1 = bullets1.get(i);
    bb1.update();
    bb1.draw();
    //If the bullet leaves the screen, deactivate it.
    if ((bb1.pos.y > height)||(bb1.pos.x > width)|| (bb1.pos.x < 0)){
      bb1.deactivate();
      bullets1.remove(bb1);
    }
    //Look for Hitdetection between a turret and bullet1
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
    //Look for hitdetection between a powerup and bullet1
    if(hitDetect(bb1.pos, powerup.pos, 10, powerup.siz.x)){
      powerup.activated1 = true;
      powerup.deactivate();
    }
  }
  //Go through each player 2 bullet.
  for (int i = 0; i<bullets2.size(); i++){
    Bullet bb2 = bullets2.get(i);
    bb2.update();
    bb2.draw();
    if ((bb2.pos.y > height)||(bb2.pos.x > width)|| (bb2.pos.x < 0)){
      bb2.deactivate();
      bullets1.remove(bb2);
    }
    //Look for hitdetection between a turret and bullet2
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
    //Look for hitdetection between a powerup and bullet2
    if(hitDetect(bb2.pos, powerup.pos, 10,powerup.siz.x)){
      powerup.activated2 = true;
      powerup.deactivate();
    }
  } 
}

//Explosion Class Manager
void explosionRunner(){
 //Go through each explosion
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

//Tracer Class Manager
void tracerRunner(){
  //Go through each tracer
  for (int i = 0; i<tracer1.size(); i++){
    Tracer t1 = tracer1.get(i);
    t1.update();
    t1.draw();
    if (t1.pos.y == height){
      check1 = false;
    }
  }
  
  for (int x = 0; x<tracer2.size(); x++){
    Tracer t2 = tracer2.get(x);
    t2.update();
    t2.draw();
    if (t2.pos.y == height){
      check2 = false;
    }
  }
  //If the check variable is true, run it.
  if (check1 == true){
    tracer1.add(new Tracer(turret1.pos, turret1.dir));
  }
  if (check2 == true){
    tracer2.add(new Tracer(turret2.pos, turret2.dir));
  }
}

//Turret Class Manager
void turretRunner(){
  //Update, draw and check if the turret is alive
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

//Update and draw the powerup
void powerupRunner(){
 powerup.update();
 powerup.draw();
}


//Keypressed manager
void inGameKeyPressedManager(){
  if (keyPressed){
    if (key == 'a' && turret1.pos.x > 25){
      turret1.pos.x -= 10;
    }
    else if (key == 'd'&&(turret1.pos.x < (width/2)-25-25)){
      turret1.pos.x += 10;
    }
    else if (key == 'w'){
      //aim up       //------------this needs work------------------
    }
    else if (key == 's'){
      //aim down    //-------------this needs work------------------
    }
    //---------------------------------------------------------------
    if (keyCode == LEFT && turret2.pos.x > (width/2)+25+25){
      turret2.pos.x -= 10;
    }
    else if (keyCode == RIGHT && turret2.pos.x < width-25){
      turret2.pos.x += 10;
    }
    else if (keyCode == UP){
      //aim up      //------------this needs work------------------
    }
    else if (keyCode == DOWN){
      //aim down    //------------this needs work------------------
    }
  }
}


//Manages the different cases for outcomes. 
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
    //Turn tracer1 on.
    check1 = true;
  }
  
  if (keyCode == ENTER){
    if (ammo-turret2Ammo > 0){
      bullets2.add(new Bullet(turret2.pos, turret2.dir));
      if (powerup.activated2 == false){
      turret2Ammo++;
      }
    }
    //Turn tracer2 on.
    check2 = true;
  }
}
  
  //Timer function using millis()
  int timer(int len) {
    int timeLeft = len-millis();
    return timeLeft/1000;
  }
  
  //Explode function to run the animation and sound.
  void explode(PVector pos,int siz, int sound){
    if (sound == 1){
      Shoot.play(0);
    }
    if (sound == 2){
      Block.play(0);
    }
    explosions.add(new Explosion(pos, siz, explosion));
  }
  