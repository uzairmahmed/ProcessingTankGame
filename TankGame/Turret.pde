class Turret{
  PVector pos   = new PVector();
  PVector dir   = new PVector();
  PVector mPos  = new PVector();
  
  int health = 10;
  int isAlive = 1;
  int turretColorR; 
  int turretColorG; 
  int turretColorB;
  int fieldSide;
  
  int helthbarW = 300;
  int helthbarH = 50;
  int indHBlock = 300/health;
  
  
  public Turret(PVector turretPos, int side, int R, int G, int B){
    pos  = turretPos;
    fieldSide = side;
    turretColorR = R; 
    turretColorG = G; 
    turretColorB = B;
  }
  void update(){
    mPos.set(mouseX, mouseY);
    dir = PVector.sub(mPos, pos);
    dir.normalize();
    dir.mult(50);
  }
  
  void draw(){
    //base
    //fill(turretColorR*health,turretColorG*health,turretColorB*health);
    fill(turretColorR,turretColorG,turretColorB);
    ellipse(pos.x, pos.y, 40, 40);
    //terminalArm
    strokeWeight(5);
    line(pos.x, pos.y, pos.x + dir.x, pos.y + dir.y);
    //dotSight
    //fill(turretColorR*health,turretColorG*health,turretColorB*health);
    fill(turretColorR,turretColorG,turretColorB);
    ellipse(pos.x + dir.x, pos.y + dir.y, 10, 10);
    
    //healthBar
    if (fieldSide == 0){
      //White BG for healthBar
      fill(0,0,0,100);
      rect(300,50,400,50);
      
      //Red Blocks for HealthBar
      fill(255,0,0,200);
      int k = 0;
      for (int i = 0; i < health; i++){
        rect(480-k, 50, 400/10, 50);
        k = k+40;
      } 
    }  else if (fieldSide == 1){
      //White BG for healthBar
      fill(0,0,0,50);
      rect(900,50,400,50);
      //Red Blocks for HealthBar
      fill(255,0,0,200);
      int j = 0;
      for (int i = 0; i < health; i++){
        rect(720+j, 50, 400/10, 50);
        j = j+40;
      }
    }
  }
  
  void takeDamage(){
    if (health < 1){
      isAlive = 0;
    }
    else {
        health--; 
    }
  }
}