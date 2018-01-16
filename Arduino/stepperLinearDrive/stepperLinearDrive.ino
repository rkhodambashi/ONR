void setup() {
  // put your setup code here, to run once:
  pinMode(9,OUTPUT);//enable
  pinMode(10,OUTPUT);//direction
  pinMode(11,OUTPUT);//step
  //digitalWrite(8,LOW);
  digitalWrite(9,HIGH);
  digitalWrite(10,LOW);
  digitalWrite(11,HIGH);
  //digitalWrite(10,LOW);
}

void loop() {
  // put your main code here, to run repeatedly:
  //digitalWrite(10,HIGH):
  digitalWrite(11,HIGH);
  delayMicroseconds(1000);
  digitalWrite(11,LOW);
  delayMicroseconds(1000);
  
}
