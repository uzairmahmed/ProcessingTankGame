//

class ChargeMeter{

 PVector pos;
 PVector siz;
  
 float chargeRate = 0.5; //how fast it charges
 char chargeKey = 'l';//the key that is used to charge the meter
 color chargeCol = color(255,0,0);
  
 float charge;
 boolean charging; //whether the meter is charging or not

 boolean didFire;
 
 ChargeMeter(){
   pos = new PVector(200,300);
   siz = new PVector (40, 100);
   charge = 0;
   charging = false;
   didFire = false;
 }
 
 ChargeMeter(PVector _pos, PVector _siz, color _chargeCol,char _chargeKey){
   pos = _pos;
   siz = _siz;
   chargeCol = _chargeCol;
   chargeKey = _chargeKey;
   charge = 0;
   charging = false;
   didFire = false;
 }
 
 void keyPressed(){
   if (key == chargeKey){
       charging = true;
   }
 }
 
 void keyReleased(){
   if (key == chargeKey){
       charging = false;
   }   
   didFire = true;
 }
 
 boolean checkFire(){
    if (didFire){
       didFire = false;
       return true;
    }
    return false;
 }
 
 void charging(){
    if (charging){
       charge += chargeRate; 
       if (charge > siz.y){
          charge = siz.y; 
       }
    }
    else {
       charge = 0; 
    }
 }
 
 //a getter method for charge that is returned as a percentage
 float getCharge(){
  return charge/siz.y; 
 }
  
  
  
 void draw(){
  rectMode(CORNER);
  noStroke();
  //draw the bar
  fill(chargeCol);
  rect(pos.x, pos.y +siz.y - charge, siz.x, charge, 4);
  
  //draw the frame
  noFill();//remove the fill color of the rect we are using as a border
  strokeWeight(4); //weight of the border
  stroke(0);//border Color
  rect(pos.x, pos.y, siz.x, siz.y, 4);
  rectMode(CENTER);  
 }
 
}