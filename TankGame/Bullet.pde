class Bullet {
  
  PVector pos = new PVector(-1000,-1000);
  PVector vel = new PVector();
  PVector acc = new PVector(0,1);  
  PVector siz = new PVector(10,10);
  
  ArrayList<Bullet> bullets;
  
  public Bullet (){
  }
  
  void update(){
    if (pos.x != -1000){
      vel.add(acc);
      pos.add(vel);
    }
  }
  void draw(){
    fill(0);
    ellipse(pos.x, pos.y, siz.x,siz.y);
  }
  
  void delete(){
   pos.set(-1000,-1000); 
  }
}
}