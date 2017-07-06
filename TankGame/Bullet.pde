/* 
 Uzair - Bullet Class
 */

class Bullet {
  PVector pos   = new PVector();
  PVector tPos  = new PVector();
  PVector vel   = new PVector();
  PVector dir   = new PVector();
  PVector grav  = new PVector(0, 3);

  //ArrayList <Bullet> bullets;
  public Bullet(PVector turretPos, PVector turretDir) {
    tPos = turretPos;
    dir = turretDir;

    pos.set(tPos);
    vel.set(dir);
  }

  void update() {
    vel.add(grav);
    pos.add(vel);
  }

  void draw() {
    fill(0, 255, 0);
    ellipse(pos.x, pos.y, 10, 10);
  }

  void deactivate() {
    pos.set(-1000, -1000);
    vel.set(0, 0);
    grav.set(0, 0);
  }
}