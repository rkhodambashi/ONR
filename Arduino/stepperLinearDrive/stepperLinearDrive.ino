const int analogInPin = A11;  // Analog input pin that the potentiometer is attached to
const int analogOutPin = 9; // Analog output pin that the LED is attached to
int potValue =0;
int counter =0;
long int currentPosition = 0;
long int goalPosition =0;
boolean powerOnHoming =1;
long int range;
long int movedUp = 0;
long int movedDown = 0;
int delayTime = 20;
void setup() {
  
  // put your setup code here, to run once:
  pinMode(9,OUTPUT);//enable
  pinMode(10,OUTPUT);//direction
  pinMode(11,OUTPUT);//step
  pinMode(7,INPUT);//lower range switch
  pinMode(8,INPUT);//upper range switch
  //digitalWrite(8,LOW);
  digitalWrite(9,HIGH);
  digitalWrite(10,HIGH);
  digitalWrite(11,HIGH);
  
  Serial.begin(115200);
  //if (powerOnHoming){
//    range = 0;
//    digitalWrite(10,HIGH);
//    while(digitalRead(12)){
//        digitalWrite(11,HIGH);
//        delayMicroseconds(500);
//        digitalWrite(11,LOW);
//        delayMicroseconds(500);
//    }
//    digitalWrite(10,LOW);
//    while(digitalRead(13)){
//        digitalWrite(11,HIGH);
//        delayMicroseconds(500);
//        digitalWrite(11,LOW);
//        delayMicroseconds(500);
//        range = range+1;
//    }
//  powerOnHoming = 0;
//  currentPosition = range;
//  Serial.println(currentPosition);
 
}

void loop() {
  // put your main code here, to run repeatedly:
  
  if (powerOnHoming){
    
    digitalWrite(10,HIGH);//move down
    while(digitalRead(7)){
        digitalWrite(11,HIGH);
        delayMicroseconds(delayTime);
        digitalWrite(11,LOW);
        delayMicroseconds(delayTime);     
    }
    currentPosition = 0;
    Serial.print("reached bottom, currentPosition is: ");
    Serial.println(currentPosition);   
    
    range = 0;
    digitalWrite(10,LOW);
    while(!digitalRead(8)){
        digitalWrite(11,HIGH);
        delayMicroseconds(delayTime);
        digitalWrite(11,LOW);
        delayMicroseconds(delayTime);
        range = range+1;
    }
    Serial.print("reached top, currentPosition is: ");
    Serial.println(range);
  powerOnHoming = 0;
  currentPosition = range;
  Serial.print("currentPosition is: ");
  Serial.println(currentPosition);
  }
  while(!powerOnHoming){
//    delay(10);
    potValue = analogRead(analogInPin);
    Serial.print("potValue is: ");
    Serial.println(potValue);
    goalPosition = map(potValue, 0, 1023, 1, range);
//    Serial.print("goalPosition is: ");
//    Serial.println(goalPosition);
//    delay(10)
//    Serial.print("currentPosition is: ");
//    Serial.println(currentPosition);
    if (abs(currentPosition-goalPosition)>1000){
      if(currentPosition<goalPosition){
        digitalWrite(10,LOW);//set the direction up
        for (int i=currentPosition; i<= goalPosition; i++){//move motor up
          digitalWrite(11,HIGH);
          delayMicroseconds(delayTime);
          digitalWrite(11,LOW);
          delayMicroseconds(delayTime);
          movedUp = movedUp+1;
          movedDown = movedDown-1;
//          Serial.print("currentPosition is: ");
//          Serial.println(currentPosition);
        }
        currentPosition = goalPosition;
      }
      else if ((currentPosition>goalPosition)){
        digitalWrite(10,HIGH);//set the direction down
        for (int j=currentPosition; j>= goalPosition; j--){//move motor down
          digitalWrite(11,HIGH);
          delayMicroseconds(delayTime);
          digitalWrite(11,LOW);
          delayMicroseconds(delayTime);
          movedDown = movedDown+1;
          movedUp = movedUp-1;
//          Serial.print("currentPosition is: ");
//          Serial.println(currentPosition);
          //Serial.println(currentPosition);
        }
        currentPosition = goalPosition;
      }
  }
//  else{
//    while(1){
//    }
//    }
  
  }
}
