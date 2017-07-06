/**
* @author rowbottom
* Block version 1.0- drops from the top and falls until it stacks onto another block
**/

class Block{
  PVector pos;
  PVector vel;
  PVector acc;
  PImage blockImages;//optional
  
  PVector siz = new PVector (50,50);
  float g = 1;
  int startingHealth = 3;
  int health;
  ArrayList<Block> blocks;// = new ArrayList<Block>();; 
  
  public Block (ArrayList<Block> b){
    blocks = b;
    vel = new PVector();
    acc = new PVector (0, g);
    pos = new PVector(width/2, -500);
    health = startingHealth;
    //  pos = new PVector(width/2, width  - siz.y/2); //starts at the bottom
  }
  
   void update(){
       vel.add(acc);
       pos.add(vel);
//       pos = new PVector(width/2, height  - (blocks.size() - blocks.indexOf(this)-1)* siz.y - siz.y/2);       //handles adding blocks from the bottom on top of each other
   }
   
   boolean check(){
       //this checks for stacking
       if (pos.y>height  - (blocks.indexOf(this))* siz.y - siz.y/2){ //check to see if 
         pos.y = height  - (blocks.indexOf(this))* siz.y - siz.y/2;
         vel.set(0,0);
       }
      /*
      add hitdetect here
        return ((abs(mouse.x - b.pos.x) < b.siz.x/2)&&(abs(mouse.y - b.pos.y) < b.siz.y/2));
        */
        return true;
   }
      

   void draw(){ 
      fill(80*health, 0,0);
      rect(pos.x, pos.y, siz.x, siz.y, 4);
      fill(0);
      text(""+blocks.indexOf(this), pos.x, pos.y);
   }
   
   void takeDamage(){
    if (health < 1){
       blocks.remove(this); 
    }
    else {
        health--; 
    }
  }
 }