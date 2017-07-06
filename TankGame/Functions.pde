//-----------------Miscellaneous Functions-----------------//


//HitDetect Function Made by Mr. Rowbottom 
boolean hitDetect(PVector pos1, PVector pos2, float size1, float size2) {
  return(PVector.dist(pos1, pos2) < (size1 + size2)/2.f);
}

//Runs when specific keys are pressed.
void keyPressed() {
  if (keyCode == ' ') {
    if (ammo-turret1Ammo > 0) {    
      //Launch bullet
      Launch.play(1);
      bullets1.add(new Bullet(turret1.pos, turret1.dir));
      if (powerup.activated1 == false) {
        turret1Ammo++;
      }
    }
  }

  if (keyCode == ENTER) {
    if (ammo-turret2Ammo > 0) {
      Launch.play(1);
      bullets2.add(new Bullet(turret2.pos, turret2.dir));
      if (powerup.activated2 == false) {
        turret2Ammo++;
      }
    }
  }
}

//Timer function using millis()
int timer(int len) {
  int timeLeft = len-millis();
  return timeLeft/1000;
}

//Explode function to run the animation and sound.
void explode(PVector pos, int siz, int sound) {
  if (sound == 1) {
    Shoot.play(0);
  }
  if (sound == 2) {
    Block.play(0);
  }
  explosions.add(new Explosion(pos, siz, explosion));
}