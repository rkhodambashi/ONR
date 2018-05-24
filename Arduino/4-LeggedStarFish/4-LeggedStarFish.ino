const int firstLegPairLeft = 2;
const int firstLegPairRight = 3;
const int secondLegPairLeft = 4;
const int secondLegPairRight = 5;
int numberOfPulses;
//int leg;
void setup() {
  // put your setup code here, to run once:
pinMode(firstLegPairLeft,OUTPUT);
pinMode(firstLegPairRight,OUTPUT);
pinMode(secondLegPairLeft,OUTPUT);
pinMode(secondLegPairRight,OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
pulse(5,firstLegPairRight);
//delay(500);
pulse(5,firstLegPairLeft);
delay(100);
pulse(5,secondLegPairRight);
//delay(500);
pulse(5,secondLegPairLeft);
delay(5000);

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
  void pulse(int numberOfPulses,int leg){
  int n = 0;
  while(n<numberOfPulses){
    digitalWrite(leg,HIGH);
    delay(100);
    digitalWrite(leg,LOW);
    delay(100);
    n = n+1; 
  }
  
  }
 
