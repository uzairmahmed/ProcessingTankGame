/*
Uzair - Tracer Class
*/

class Tracer{
  PVector pos   = new PVector();
  PVector tPos  = new PVector();
  PVector vel   = new PVector();
  PVector dir   = new PVector();
  PVector grav  = new PVector(0,2.23);
  ArrayList <Tracer> tracerPath;
  
  public Tracer(PVector turretPos, PVector turretDir){
    tPos = turretPos;
    dir = turretDir;
    pos.set(tPos);
    vel.set(dir);
  }
  void update(){
    vel.add(grav);
    pos.add(vel);
  }
  void draw(){
     fill(255);
     ellipse(pos.x, pos.y, 2, 2); 
  }
  void deactivate(){
    pos.set(-1000 ,-1000);
    vel.set(0,0);
    grav.set(0,0);
  }
}