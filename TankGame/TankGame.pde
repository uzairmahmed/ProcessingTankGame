/*
Uzair - Tank Game Version 0.8

 - Use Arrow keys/WASD to move.
 - Destroy the other turret by breaking through the wall
   and shooting the turret in under sixty seconds.
 
 KNOWN BUGS:
 - Two people cannot move at the same time, because 
   processing can only process-(haha get it?) one function
   at a time.
 
 - Shooting the the turret arm does not damage the
   turret -- It only makes it ANGRY
   
 - Tracer code is somewhat inneficient. For better performance
   comment out line 172.
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

//Import ChargeMeter
ChargeMeter charge1;
ChargeMeter charge2;


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
  Launch = minim.loadFile("launch.wav");
  Powerup = minim.loadFile("powerup.wav");
  
  //Initialize Player Turrets
  turret1 = new Turret(new PVector(width/8,height), 0, 255, 32 , 32, 6);
  turret2 = new Turret(new PVector((width/8)*7,height), 1, 32, 32, 255, 4);
  
  //Initialize powerup block
  powerup = new UnlAmmo(new PVector(width/2, 50), new PVector(30,30));
  
  //Initialize ChargeMeter
  charge1 = new ChargeMeter(new PVector(-2000,-2000), new PVector(10,50), (255), ' ');
  charge2 = new ChargeMeter(new PVector(-2000,-2000), new PVector(10,50), (255), '/');
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