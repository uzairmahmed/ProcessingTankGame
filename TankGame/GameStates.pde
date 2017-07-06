//-----------------Specific Gamestates-----------------//


//Runs when gameState is 0 i.e. the program has just run.
void startScreen() {
  background(0);
  textFont(f, 48);
  fill(255);
  text("UZAIR'S TANK GAME (v.2!)", width/2, 100);
  text ("HOW TO PLAY", width/2, 200);
  text ("use arrow keys/wasd to move and aim.", width/2, height/2);
  text ("Hit the powerup for infinite ammo!", width/2, height/2+100);
  text("Click to Play", width/2, height-25);
  if (mousePressed) {
    gameState = 1;
  }
}

//Runs when gameState is 1. i.e. the user has cliecked a button.
void game() {
  background(150);
  textFont(f, 35);
  fill(200);
  rect(width/2, 80, width, 150);
  fill(0);
  int tim = timer(60000);
  surface.setTitle("Tank Game. Time Left:" + str(tim));
  if (tim == 10) {
    Time.play(0);
  }
  if (tim==0) {
    gameOverManager();
  }

  text(((ammo-turret1Ammo) + "/" + ammo), width*0.25, 150);
  text(((ammo-turret2Ammo) + "/" + ammo), width*0.75, 150);

  //Manager for all things respective to thier names.
  blockRunner();
  explosionRunner();
  //tracerRunner(); //<-------------------------------------Comment this line for MUCH better performance. 
  bulletRunner();
  turretRunner();
  chargeRunner();
  powerupRunner();
  inGameKeyPressedManager();
  line(26,75,34,75);
  line(width - 26,75,width - 34,75);
}

void end1() {
  background(255);
  text("ONE WINS!", width/2, height/2);
  //Win.play(0);
  //delay(6000);
}

void end2() {
  background(255);
  text("TWO WINS!", width/2, height/2);
  //Win.play(0);
  //delay(6000);
}

void end3() {
  background(255);
  text("TIE!", width/2, height/2);
  //Win.play(0);
  delay(6000);
}

//Manages the different cases for outcomes. 
void gameOverManager() {
  if (turret1.health > turret2.health) {
    gameState = 2;
  }
  if (turret1.health < turret2.health) {
    gameState = 3;
  }
  if (turret1.health == turret2.health) {
    gameState = 4;
  }
}