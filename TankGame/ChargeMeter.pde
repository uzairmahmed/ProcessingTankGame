/*
  Mr. Rowbottom's - ChargeMeter class modded by Uzair
 */
class ChargeMeter {

  PVector pos;
  PVector siz;

  float chargeRate; //how fast it charges
  color chargeCol;
  color chargeStr;

  float charge;
  boolean charging; //whether the meter is charging or not

  int type;

  ChargeMeter(PVector _pos, PVector _siz, color _chargeStr, float _chargeRate) {
    pos = _pos;
    siz = _siz;
    chargeStr = _chargeStr;
    chargeRate = _chargeRate;
    //chargeKey = _chargeKey;
    charge = 0;
    charging = false;
  }

  void fluctuating() {
    type = 1;
    if (charging) {
      charge += chargeRate; 
      if (charge > siz.y) {
        charging = false;
      }
    } else if (!charging) {
      charge -= chargeRate; 
      if (charge < 0) {
        charging = true;
      }
    }
  }

  void charging() {
    type = 0;
    charge += chargeRate; 
    if (charge > siz.y) {
      charge = siz.y;
    }
  }

  //a getter method for charge that is returned as a percentage
  float getCharge() {
    return charge/siz.y;
  }

  void draw() {
    rectMode(CORNER);
    noStroke();
    //draw the bar
    fill(chargeCol);
    rect(pos.x, pos.y +siz.y - charge, siz.x, charge, 4);

    //draw the frame
    noFill();//remove the fill color of the rect we are using as a border
    strokeWeight(4); //weight of the border
    stroke(chargeStr);//border Color
    rect(pos.x, pos.y, siz.x, siz.y, 4);
    stroke(0);
    rectMode(CENTER);  

    if (type == 0) {
      if (getCharge() > 0.0) {
        chargeCol = color(255, 0, 0);
      }
      if (getCharge() > 0.5) {
        chargeCol = color(255, 255, 0);
      }
      if (getCharge() > 0.75) {
        chargeCol = color(0, 255, 0);
      }
    }
    if (type == 1) {
      if (getCharge() > 0.0) {
        chargeCol = color(255, 0, 0);
      }
      if (getCharge() > 0.5) {
        chargeCol = color(0, 255, 0);
      }
      if (getCharge() > 0.75) {
        chargeCol = color(255, 0, 0);
      }
    }
  }
}