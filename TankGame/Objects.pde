//-----------------Object Managers-----------------//

//Block Class Manager
void blockRunner() {
  //Go through each block 
  for (int i = 0; i < groundBlocks.size(); i++) {
    //Make a Block reference
    Block gb = groundBlocks.get(i);
    //Update block
    gb.update();
    //Check block 
    gb.check();
    //Draw block
    gb.draw();

    //Go through each bullet1 to check if it has hit the block in question.
    for (int j = 0; j<bullets1.size(); j++) {
      //Make a Bullet Reference
      Bullet bbcheck1 = bullets1.get(j);
      //Check for Hitdetection between the Block and Bullet
      if (hitDetect(bbcheck1.pos, gb.pos, 10, 100)) {
        //Run animation, take block damage, deactivate bullet.
        explode(gb.pos, 100, 2);
        gb.takeDamage();
        bbcheck1.deactivate();
        bullets1.remove(bbcheck1);
        delay(10);
      }
    }

    //Go through each bullet2 to check if it has hit the block in question.
    for (int k = 0; k<bullets2.size(); k++) {
      //Make a Bullet Reference
      Bullet bbcheck2 = bullets2.get(k);
      //Check for Hitdetection between the Block and Bullet
      if (hitDetect(bbcheck2.pos, gb.pos, 10, 100)) {
        //Run animation, take block damage, deactivate bullet.
        explode(gb.pos, 100, 2);
        gb.takeDamage();
        bbcheck2.deactivate();
        bullets2.remove(bbcheck2);
        delay(10);
      }
    }
  }
  //Go through each block 
  for (int i = 0; i < groundBlocks.size(); i++) {
    //Make a Block reference
    Block gb = groundBlocks.get(i);
    //Update block
    gb.update();
    //Check block 
    gb.check();
    //Draw block
    gb.draw();

    //Go through each bullet1 to check if it has hit the block in question.
    for (int j = 0; j<bullets1.size(); j++) {
      //Make a Bullet Reference
      Bullet bbcheck1 = bullets1.get(j);
      //Check for Hitdetection between the Block and Bullet
      if (hitDetect(bbcheck1.pos, gb.pos, 10, 100)) {
        //Run animation, take block damage, deactivate bullet.
        explode(gb.pos, 100, 2);
        gb.takeDamage();
        bbcheck1.deactivate();
        bullets1.remove(bbcheck1);
        delay(10);
      }
    }

    //Go through each bullet2 to check if it has hit the block in question.
    for (int k = 0; k<bullets2.size(); k++) {
      //Make a Bullet Reference
      Bullet bbcheck2 = bullets2.get(k);
      //Check for Hitdetection between the Block and Bullet
      if (hitDetect(bbcheck2.pos, gb.pos, 10, 100)) {
        //Run animation, take block damage, deactivate bullet.
        explode(gb.pos, 100, 2);
        gb.takeDamage();
        bbcheck2.deactivate();
        bullets2.remove(bbcheck2);
        delay(10);
      }
    }
  }
  //Go through each block 
  for (int i = 0; i < skyBlocks.size(); i++) {
    //Make a Block reference
    Block sb = skyBlocks.get(i);
    //Update block
    sb.update();
    //Check block 
    sb.check();
    //Draw block
    sb.draw();

    //Go through each bullet1 to check if it has hit the block in question.
    for (int j = 0; j<bullets1.size(); j++) {
      //Make a Bullet Reference
      Bullet bbcheck1 = bullets1.get(j);
      //Check for Hitdetection between the Block and Bullet
      if (hitDetect(bbcheck1.pos, sb.pos, 10, 100)) {
        //Run animation, take block damage, deactivate bullet.
        explode(sb.pos, 100, 2);
        sb.takeDamage();
        bbcheck1.deactivate();
        bullets1.remove(bbcheck1);
        delay(10);
      }
    }

    //Go through each bullet2 to check if it has hit the block in question.
    for (int k = 0; k<bullets2.size(); k++) {
      //Make a Bullet Reference
      Bullet bbcheck2 = bullets2.get(k);
      //Check for Hitdetection between the Block and Bullet
      if (hitDetect(bbcheck2.pos, sb.pos, 10, 100)) {
        //Run animation, take block damage, deactivate bullet.
        explode(sb.pos, 100, 2);
        sb.takeDamage();
        bbcheck2.deactivate();
        bullets2.remove(bbcheck2);
        delay(10);
      }
    }
  }

  //Spawn new blocks if blockList is empty.
  if (groundBlocks.size() == 0) {
    for (int i = 0; i <= 3; i++) {
      groundBlocks.add(new Block(groundBlocks,0));
    }
  }
  if (skyBlocks.size() == 0) {
    for (int i = 0; i <= 3; i++) {
      skyBlocks.add(new Block(skyBlocks,1));
    }
  }
}

//Bullet Class Manager
void bulletRunner() {
  //Go through each player 1 bullet.
  for (int i = 0; i<bullets1.size(); i++) {
    Bullet bb1 = bullets1.get(i);
    bb1.grav.y-= 0.5*(shotCharge2.getCharge());
    bb1.update();
    bb1.draw();
    //If the bullet leaves the screen, deactivate it.
    if ((bb1.pos.y > height)||(bb1.pos.x > width)|| (bb1.pos.x < 0)) {
      bb1.deactivate();
      bullets1.remove(bb1);
    }
    //Look for Hitdetection between a turret and bullet1
    if (hitDetect(bb1.pos, turret1.pos, 10, 80)) {
      explode(turret1.pos, 160, 1);
      turret1.takeDamage();
      bb1.deactivate();
      bullets1.remove(bb1);
    }
    if (hitDetect(bb1.pos, turret2.pos, 10, 80)) {
      explode(turret2.pos, 160, 1);
      turret2.takeDamage();
      bb1.deactivate();
      bullets1.remove(bb1);
    }
    //Look for hitdetection between a powerup and bullet1
    if (hitDetect(bb1.pos, powerup.pos, 10, powerup.siz.x)) {
      powerup.activated1 = true;
      Powerup.play(0);
      powerup.deactivate();
    }
  }
  //Go through each player 2 bullet.
  for (int i = 0; i<bullets2.size(); i++) {
    Bullet bb2 = bullets2.get(i);
    bb2.grav.y-= 0.5*(shotCharge2.getCharge());
    bb2.update();
    bb2.draw();
    if ((bb2.pos.y > height)||(bb2.pos.x > width)|| (bb2.pos.x < 0)) {
      bb2.deactivate();
      bullets1.remove(bb2);
    }
    //Look for hitdetection between a turret and bullet2
    if (hitDetect(bb2.pos, turret1.pos, 10, 80)) {
      explode(turret1.pos, 160, 1);
      turret1.takeDamage();
      bb2.deactivate();
      bullets2.remove(bb2);
    }
    if (hitDetect(bb2.pos, turret2.pos, 10, 80)) {
      explode(turret2.pos, 160, 1);
      turret2.takeDamage();
      bb2.deactivate();
      bullets2.remove(bb2);
    }
    //Look for hitdetection between a powerup and bullet2
    if (hitDetect(bb2.pos, powerup.pos, 10, powerup.siz.x)) {
      powerup.activated2 = true;
      Powerup.play(0);
      powerup.deactivate();
    }
  }
}

//Explosion Class Manager
void explosionRunner() {
  //Go through each explosion
  for (int i = 0; i<explosions.size(); i++) {
    //make a temp explosion variable 
    Explosion e = explosions.get(i);
    //update each explosion
    if (e.checkActive()) {
      e.draw();
    } else {
      explosions.remove(e);
    }
  }
}

//Tracer Class Manager
void tracerRunner() {
  //Go through each tracer
  for (int i = 0; i<tracer1.size(); i++) {
    Tracer t1 = tracer1.get(i);
    t1.update();
    t1.draw();
  }

  for (int x = 0; x<tracer2.size(); x++) {
    Tracer t2 = tracer2.get(x);
    t2.update();
    t2.draw();
  }
  //If the check variable is true, run it.
  tracer1.add(new Tracer(turret1.pos, turret1.dir));
  tracer2.add(new Tracer(turret2.pos, turret2.dir));
}

//Turret Class Manager
void turretRunner() {
  //Update, draw and check if the turret is alive
  turret1.update();
  turret1.switchPositions();
  turret1.draw();
  turret2.update();
  turret2.draw();  

  if (turret1.isAlive == 0) {
    Dead.play(0);
    delay(3000);
    gameState = 3;
  }
  if (turret2.isAlive == 0) {
    Dead.play(0);
    delay(3000);
    gameState = 2;
  }
}

void chargeRunner() {
  shotCharge1.fluctuating();
  shotCharge2.fluctuating();
  jumpCharge1.charging();
  jumpCharge2.charging();
  shotCharge1.draw();
  shotCharge2.draw();
  jumpCharge1.draw();
  jumpCharge2.draw();
}

//Update and draw the powerup
void powerupRunner() {
  powerup.update();
  powerup.draw();
}