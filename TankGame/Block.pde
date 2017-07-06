/**
 * @author rowbottom
 * Block version 1.0- drops from the top and falls until it stacks onto another block
 * Modded by Uzair Ahmed
 **/

class Block {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector blockSize;

  float g = 1;
  int type;
  int health;
  int blockColorR = 255; 
  int blockColorG = 32; 
  int blockColorB = 32;

  ArrayList<Block> blocks;// = new ArrayList<Block>();; 

  public Block (ArrayList<Block> b, int _type) {
    blocks = b;
    type = _type;
    vel = new PVector();
    acc = new PVector (0, g);
    pos = new PVector(width/2, height/2);
    blockSize = new PVector (50, 50);
    health = 4;
    //pos = new PVector(width/2, width  - siz.y/2); //starts at the bottom
  }

  void update() {
    vel.add(acc);
    if (type == 0) {
      pos.add(vel);
    } else if (type == 1) {
      pos.sub(vel);
    }
  }

  void check() {
    if (type == 0) {
      if (pos.y>height  - (blocks.indexOf(this))* blockSize.y - blockSize.y/2) {
        pos.y = height  - (blocks.indexOf(this))* blockSize.y - blockSize.y/2;
        vel.set(0, 0);
      }       
      //return ((abs(mouseX - 2) < 12/2)&&(abs(mouseY - 2) < 12/2));
    } else if (type == 1) {
      if (pos.y<155    +  ((blocks.indexOf(this))* blockSize.y) + blockSize.y/2) {
        pos.y = 155    +  ((blocks.indexOf(this))* blockSize.y) + blockSize.y/2;
        vel.set(0, 0);
      }       
      //return ((abs(mouseX - 2) < 12/2)&&(abs(mouseY - 2) < 12/2));
    }
  }

  void draw() { 
    fill(blockColorR*health, blockColorG*health, blockColorB*health);
    rect(pos.x, pos.y, blockSize.x, blockSize.y, 4);
  }

  void takeDamage() {
    if (health < 1) {
      blocks.remove(this);
    } else {
      health--;
    }
  }
}