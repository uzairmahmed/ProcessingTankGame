//-----------------Object Managers-----------------//
//Block Class Manager
void blockRunner(){
  //Go through each block 
  for (int i = 0; i < blocks.size(); i++) {
    //Make a Block reference
    Block b = blocks.get(i);
    //Update block
    b.update();
    //Check block 
    b.check();
    //Draw block
    b.draw();
    
    //Go through each bullet1 to check if it has hit the block in question.
    for (int j = 0; j<bullets1.size(); j++){
      //Make a Bullet Reference
      Bullet bbcheck1 = bullets1.get(j);
      //Check for Hitdetection between the Block and Bullet
      if (hitDetect(bbcheck1.pos, b.pos, 10, 100)){
        //Run animation, take block damage, deactivate bullet.
        explode(b.pos,100,2);
        b.takeDamage();
        bbcheck1.deactivate();
        bullets1.remove(bbcheck1);
        delay(10);
      }
    }
    
    //Go through each bullet2 to check if it has hit the block in question.
    for (int k = 0; k<bullets2.size(); k++){
      //Make a Bullet Reference
      Bullet bbcheck2 = bullets2.get(k);
      //Check for Hitdetection between the Block and Bullet
      if (hitDetect(bbcheck2.pos, b.pos, 10, 100)){
        //Run animation, take block damage, deactivate bullet.
        explode(b.pos,100,2);
        b.takeDamage();
        bbcheck2.deactivate();
        bullets2.remove(bbcheck2);
        delay(10);
      }
    }
  }
  //Spawn new blocks if blockList is empty.
  if (blocks.size() == 0){
    for (int i = 0; i <= 8; i++){
      blocks.add(new Block(blocks));
    }
  }
}

//Bullet Class Manager
void bulletRunner(){
 //Go through each player 1 bullet.
  for (int i = 0; i<bullets1.size(); i++){
    Bullet bb1 = bullets1.get(i);
    bb1.update();
    bb1.draw();
    bb1.gravMult = charge1.charge/10;
    //If the bullet leaves the screen, deactivate it.
    if ((bb1.pos.y > height)||(bb1.pos.x > width)|| (bb1.pos.x < 0)){
      bb1.deactivate();
      bullets1.remove(bb1);
    }
    //Look for Hitdetection between a turret and bullet1
    if(hitDetect(bb1.pos, turret1.pos, 10,80)){
      explode(turret1.pos,160,1);
      turret1.takeDamage();
      bb1.deactivate();
      bullets1.remove(bb1);
    }
    if(hitDetect(bb1.pos, turret2.pos, 10,80)){
      explode(turret2.pos,160,1);
      turret2.takeDamage();
      bb1.deactivate();
      bullets1.remove(bb1);
    }
    //Look for hitdetection between a powerup and bullet1
    if(hitDetect(bb1.pos, powerup.pos, 10, powerup.siz.x)){
      powerup.activated1 = true;
      Powerup.play(0);
      powerup.deactivate();
    }
  }
  //Go through each player 2 bullet.
  for (int i = 0; i<bullets2.size(); i++){
    Bullet bb2 = bullets2.get(i);
    bb2.update();
    bb2.draw();
    if ((bb2.pos.y > height)||(bb2.pos.x > width)|| (bb2.pos.x < 0)){
      bb2.deactivate();
      bullets1.remove(bb2);
    }
    //Look for hitdetection between a turret and bullet2
    if(hitDetect(bb2.pos, turret1.pos, 10,80)){
      explode(turret1.pos,160,1);
      turret1.takeDamage();
      bb2.deactivate();
      bullets2.remove(bb2);
    }
    if(hitDetect(bb2.pos, turret2.pos, 10,80)){
      explode(turret2.pos,160,1);
      turret2.takeDamage();
      bb2.deactivate();
      bullets2.remove(bb2);
    }
    //Look for hitdetection between a powerup and bullet2
    if(hitDetect(bb2.pos, powerup.pos, 10,powerup.siz.x)){
      powerup.activated2 = true;
      Powerup.play(0);
      powerup.deactivate();
    }
  } 
}

//Explosion Class Manager
void explosionRunner(){
 //Go through each explosion
  for (int i = 0; i<explosions.size();i++){
    //make a temp explosion variable 
    Explosion e = explosions.get(i);
    //update each explosion
    if (e.checkActive()){
      e.draw();
    }
    else{
       explosions.remove(e);
    }
  } 
}

//Tracer Class Manager
void tracerRunner(){
  //Go through each tracer
  for (int i = 0; i<tracer1.size(); i++){
    Tracer t1 = tracer1.get(i);
    t1.update();
    t1.draw();
    if (t1.pos.y == height){
      check1 = false;
    }
  }
  
  for (int x = 0; x<tracer2.size(); x++){
    Tracer t2 = tracer2.get(x);
    t2.update();
    t2.draw();
    if (t2.pos.y == height){
      check2 = false;
    }
  }
  //If the check variable is true, run it.
  if (check1 == true){
    tracer1.add(new Tracer(turret1.pos, turret1.dir));
  }
  if (check2 == true){
    tracer2.add(new Tracer(turret2.pos, turret2.dir));
  }
}

//Turret Class Manager
void turretRunner(){
  //Update, draw and check if the turret is alive
  turret1.update();
  turret1.draw();
  turret2.update();
  turret2.draw();  
    
  if (turret1.isAlive == 0){
    Dead.play(0);
    delay(3000);
    gameState = 3;
  }
  if (turret2.isAlive == 0){
    Dead.play(0);
    delay(3000);
    gameState = 2;
  }  
}

//Update and draw the powerup
void powerupRunner(){
 powerup.update();
 powerup.draw();
}
void chargerRunner(){
  charge1.pos = new PVector(turret1.pos.x-50,turret1.pos.y-50);
  charge1.draw();
  
  charge2.pos = new PVector(turret2.pos.x+50,turret2.pos.y-50);
  charge2.draw();
}



//Keypressed manager
void inGameKeyPressedManager(){
  if (keyPressed){
    if (key == 'a' && turret1.pos.x > 25){
      turret1.pos.x -= 10;
    }
    else if (key == 'd'&&(turret1.pos.x < (width/2)-25-25)){
      turret1.pos.x += 10;
    }
    else if ((key == 'w') && (turret1.dir.x > 0)){
      turret1.elevation -= 0.05;
    }
    else if ((key == 's') && (turret1.dir.x < 49.99)){
      turret1.elevation += 0.05;
    }
    else if ((key == charge1.chargeKey)){
      charge1.charging = true;
    }

    //---------------------------------------------------------------
    if (keyCode == LEFT && turret2.pos.x > (width/2)+25+25){
      turret2.pos.x -= 10;
    }
    else if (keyCode == RIGHT && turret2.pos.x < width-25){
      turret2.pos.x += 10;
    }
    else if ((keyCode == UP) && (turret2.dir.x < 0)){
      turret2.elevation += 0.05;
    }
    else if ((keyCode == DOWN) && (turret2.dir.x > -49.99)){
      turret2.elevation -= 0.05;
    }
    else if ((key == charge2.chargeKey)){
      charge2.charging = true;
    }
  }
}


//Manages the different cases for outcomes. 
void gameOverManager(){
 if (turret1.health > turret2.health){
   gameState = 2;
 }
  if (turret1.health < turret2.health){
   gameState = 3;
 }
  if (turret1.health == turret2.health){
   gameState = 4;
 }
}