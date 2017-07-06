/*
Uzair - Unlimited Ammo Powerup Class
*/

class UnlAmmo{
  PVector pos = new PVector();
  PVector siz = new PVector();
  PVector sym = new PVector();
  boolean activated1 = false;
  boolean activated2 = false;
  
  public UnlAmmo(PVector position, PVector size){
    pos.set(position);
    siz.set(size);
    sym.set(pos.x-(siz.x/2),pos.y);
  }
  
  void update(){
    sym.x+=1;
    if (sym.x == pos.x + siz.x/2){
     sym.x = pos.x-(siz.x/2); 
    }
  }
  
  void draw(){
     fill(random(255), random(255), random(255));
     rect(pos.x, pos.y, siz.x,siz.y);
     fill(random(255), random(255), random(255));
     ellipse(sym.x,sym.y, 10, 10); 
  }
  
  void deactivate(){
    pos.set(-2000 ,-2000);
    sym.set(-2000, -2000);
  }
}