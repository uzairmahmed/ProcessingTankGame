/*
  Uzair Ahmed
 Tank Game Version 2 - SUMMATIVE EDITION
 12 June, 2017
 
 - Use Arrow keys/WASD to move.
 - Destroy the other turret by breaking through the wall
 and shooting the turret in under sixty seconds.
 
 KNOWN BUGS:
 - Two people cannot move at the same time, because 
 processing can only process-(haha get it?) one function
 at a time.
 
 - Shooting the the turret arm does not damage the
 turret -- It only makes it ANGRY
 
 - Tracer code is NOW VERY inneficient. For better performance
 comment out the tracer class caller.
 
 - For even better performance comment out the explosion class caller.
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
AudioPlayer Launch;
AudioPlayer Powerup;

//ArrayLists for Blocks, Explosions, and Bullets      
ArrayList<Block> groundBlocks;
ArrayList<Block> skyBlocks;
ArrayList<Explosion> explosions;
ArrayList<Bullet> bullets1;
ArrayList<Bullet> bullets2;
ArrayList<Tracer> tracer1;
ArrayList<Tracer> tracer2;

//Import Turret Objects
Turret turret1;
Turret turret2;

//Import Charge Objects
ChargeMeter shotCharge1;
ChargeMeter shotCharge2;
ChargeMeter jumpCharge1;
ChargeMeter jumpCharge2;

//Import Powerup Block
UnlAmmo powerup;

//Initialize Fonts for display on Screen
PFont f;

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
  size(1200, 700);
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
  groundBlocks     = new ArrayList<Block>    ();
  skyBlocks        = new ArrayList<Block>    ();
  explosions       = new ArrayList<Explosion>();
  bullets1         = new ArrayList<Bullet>   ();
  bullets2         = new ArrayList<Bullet>   ();
  tracer1          = new ArrayList<Tracer>   ();
  tracer2          = new ArrayList<Tracer>   ();

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
  Launch = minim.loadFile("launch.wav");
  Powerup = minim.loadFile("powerup.wav");

  //Initialize Player Turrets
  turret1 = new Turret(new PVector(width/8, height), 0, 255, 32, 32, 6);
  turret2 = new Turret(new PVector((width/8)*7, height), 1, 32, 32, 255, 4);

  //Initialize Chargers
  shotCharge1 = new ChargeMeter(new PVector(25, 25), new PVector(10, 100), color(255, 0, 255), 0.75);
  shotCharge2 = new ChargeMeter(new PVector(width-35, 25), new PVector(10, 100), color(255, 0, 255), 0.75);

  jumpCharge1 = new ChargeMeter(new PVector(45, 25), new PVector(10, 100), color(0, 255, 255), 0.5);
  jumpCharge2 = new ChargeMeter(new PVector(width-55, 25), new PVector(10, 100), color(0, 255, 255), 0.5);

  //Initialize powerup block
  powerup = new UnlAmmo(new PVector(width/2, height/2), new PVector(30, 30));
}

//Runs repeatedly, used as a gameState manager
void draw() {
  if (gameState == 0) {
    startScreen();
  } else if (gameState == 1) {
    game();
  } else if (gameState == 2) {
    end1();
  } else if (gameState == 3) {
    end2();
  } else if (gameState == 4) {
    end3();
  }
}

//Keypressed manager
void inGameKeyPressedManager() {
  if (keyPressed) {
    if (key == 'a' && turret1.pos.x > 25) {
      turret1.pos.x -= 10;
    } else if (key == 'd'&&(turret1.pos.x < (width/2)-25-25)) {
      turret1.pos.x += 10;
    } else if (key == 'w') {
      turret1.elevation -= 0.05;
    } else if (key == 's') {
      turret1.elevation += 0.05;
    } else if (key == 'q') {
      if (jumpCharge1.getCharge() > 0.75) {
        turret1.move=true;
        jumpCharge1.charge = 0;
      }
    }
    //---------------------------------------------------------------
    if (keyCode == LEFT && turret2.pos.x > (width/2)+25+25) {
      turret2.pos.x -= 10;
    } else if (keyCode == RIGHT && turret2.pos.x < width-25) {
      turret2.pos.x += 10;
    } else if (keyCode == UP) {
      turret2.elevation += 0.05;
    } else if (keyCode == DOWN) {
      turret2.elevation -= 0.05;
    } else if (key == '/') {
      if (jumpCharge2.getCharge() > 0.75) {
        turret2.move=true;
        jumpCharge2.charge = 0;
      }
    }
  }
}