class Turret{
  PVector pos   = new PVector();
  PVector dir   = new PVector();
  
  int health = 10;
  
  //ArrayList <Bullet> bullets;
  public Turret(PVector turretPos, PVector turretDir){
    pos = turretPos;
    dir = turretDir;
  }
  
  void draw(){
  //base
  fill(255,0,0);
  ellipse(pos.x, pos.y, 40, 40);
  //terminalArm
  strokeWeight(5);
  line(pos.x, pos.y, pos.x + dir.x, dir.y + pos.y);
  //dotSight
  fill(255, 0, 0);
  ellipse(tPos1.x + tDir1.x, tPos1.y + tDir1.y, 10, 10);
  }
  
  void deactivate(){
    pos.set(-1000 ,-1000);
    //vel.set(0,0);
    //grav.set(0,0);
  }
}