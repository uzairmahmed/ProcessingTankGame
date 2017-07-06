/**
* @author rowbottom
* Block version 1.0- drops from the top and falls until it stacks onto another block
**/

class Block{
  PVector pos;
  PVector vel;
  PVector acc;
  PVector blockSize;
  
  float g = 1;
  int health;
  int blockColorR = 50; int blockColorG = 50; int blockColorB = 50;

  ArrayList<Block> blocks;// = new ArrayList<Block>();; 
  
  public Block (ArrayList<Block> b){
    blocks = b;
    vel = new PVector();
    acc = new PVector (0, g);
    pos = new PVector(width/2, -500);
    blockSize = new PVector (50,50);
    health = 4;
    //pos = new PVector(width/2, width  - siz.y/2); //starts at the bottom
  }
  
   void update(){
       vel.add(acc);
       pos.add(vel);
       //pos = new PVector(width/2, height  - (blocks.size() - blocks.indexOf(this)-1)* siz.y - siz.y/2);       //handles adding blocks from the bottom on top of each other
   }
   
   boolean check(){
       if (pos.y>height  - (blocks.indexOf(this))* blockSize.y - blockSize.y/2){//check to see if 
         pos.y = height  - (blocks.indexOf(this))* blockSize.y - blockSize.y/2;
         vel.set(0,0);
       }       
        return ((abs(mouseX - 2) < 12/2)&&(abs(mouseY - 2) < 12/2));
   }

   void draw(){ 
      fill(blockColorR*health,blockColorG*health,blockColorB*health);
      rect(pos.x, pos.y, blockSize.x, blockSize.y, 4);
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