//const int firstLegPairLeft = 2;
//const int firstLegPairRight = 3;
//const int secondLegPairLeft = 4;
//const int secondLegPairRight = 5;

const int firstLegLeft = 2;
const int firstLegRight = 3;
const int secondLegLeft = 5;
const int secondLegRight = 4;
const int thirdLegLeft = 6;
const int thirdLegRight = 7;
const int fourthLegLeft = 9;
const int fourthLegRight = 8;
//const int firstLegLeft = 10;
//const int firstLegRight = 11;
//const int secondLegLeft = 12;
//const int secondLegRight = 13;

int numberOfPulses;
//int leg;
void setup() {
  // put your setup code here, to run once:
pinMode(firstLegLeft,OUTPUT);
pinMode(firstLegRight,OUTPUT);
pinMode(secondLegLeft,OUTPUT);
pinMode(secondLegRight,OUTPUT);
pinMode(thirdLegLeft,OUTPUT);
pinMode(thirdLegRight,OUTPUT);
pinMode(fourthLegLeft,OUTPUT);
pinMode(fourthLegRight,OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
pulse(5,firstLegRight,thirdLegRight);
delay(1000);
pulse(5,firstLegLeft,thirdLegLeft);
//delay(200);
pulse(5,secondLegRight,fourthLegRight);
delay(1000);
pulse(5,secondLegLeft,fourthLegLeft);
//delay(200);

//digitalWrite(firstLegPairLeft,HIGH);
//delay(100);
//digitalWrite(firstLegPairLeft,LOW);
//delay(500);
//digitalWrite(secondLegPairRight,HIGH);
//delay(100);
//digitalWrite(secondLegPairRight,LOW);
//delay(500);
//digitalWrite(secondLegPairLeft,HIGH);
//delay(100);
//digitalWrite(secondLegPairLeft,LOW);
//
////digitalWrite(firstLegPairLeft,HIGH);
//delay(2000);

//analogWrite(firstLegPairRight,0.1*255);

}
  void pulse(int numberOfPulses,int leg1, int leg2){
  int n = 0;
  while(n<numberOfPulses){
    digitalWrite(leg1,HIGH);
    digitalWrite(leg2,HIGH);
    delay(100);
    digitalWrite(leg1,LOW);
    digitalWrite(leg2,LOW);
    delay(100);
    n = n+1; 
  }
  
  }
 
