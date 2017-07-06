/*
Uzair - Turret Class
 */

class Turret {
  PVector pos   = new PVector();
  PVector dir   = new PVector();
  PVector mPos  = new PVector();

  int health = 10;
  int isAlive = 1;
  int turretColorR; 
  int turretColorG; 
  int turretColorB;
  int fieldSide;
  float elevation;

  int helthbarW = 300;
  int helthbarH = 50;
  int indHBlock = 300/health;

  boolean move = false;


  public Turret(PVector turretPos, int side, int R, int G, int B, float e) {
    pos  = turretPos;
    fieldSide = side;
    turretColorR = R; 
    turretColorG = G; 
    turretColorB = B;
    elevation = e;
  }
  void update() {
    dir.set(cos(elevation), sin(elevation));
    dir.mult(50);
  }

  void draw() {
    print (dir + "\n");
    //base
    fill(turretColorR, turretColorG, turretColorB);
    ellipse(pos.x, pos.y, 40, 40);
    //terminalArm
    strokeWeight(5);
    line(pos.x, pos.y, pos.x + dir.x, pos.y + dir.y);
    //dotSight
    fill(turretColorR, turretColorG, turretColorB);
    ellipse(pos.x + dir.x, pos.y + dir.y, 10, 10);

    //healthBar
    if (fieldSide == 0) {
      //White BG for healthBar
      fill(0, 0, 0, 100);
      rect(300, 50, 400, 50);

      //Red Blocks for HealthBar
      fill(255, 0, 0, 200);
      int k = 0;
      for (int i = 0; i < health; i++) {
        rect(480-k, 50, 400/10, 50);
        k = k+40;
      }
    } else if (fieldSide == 1) {
      //White BG for healthBar
      fill(0, 0, 0, 50);
      rect(900, 50, 400, 50);
      //Red Blocks for HealthBar
      fill(255, 0, 0, 200);
      int j = 0;
      for (int i = 0; i < health; i++) {
        rect(720+j, 50, 400/10, 50);
        j = j+40;
      }
    }
  }

  void switchPositions() {
    if (move == true) {
      pos.add(dir);
      if (pos.y < 150) {
        pos.y = 150;
        move = false;
      } else if (pos.y > height) {
        pos.y = height;
        move = false;
      }
      if (fieldSide == 0) {
        if (pos.x < 0) {
          pos.x = 0;
          dir.x*=-1;
        } else if (pos.x > width/2-50) {
          pos.x = width/2-50;
          dir.x*=-1;
        }
      }
      if (fieldSide == 1) {
        if (pos.x > width) {
          pos.x = width;
          dir.x*=-1;
        } else if (pos.x < width/2+50) {
          pos.x = width/2+50;
          dir.x*=-1;
        }
      }
    }
  }

  void takeDamage() {
    if (health < 1) {
      isAlive = 0;
    } else {
      health--;
    }
  }
}