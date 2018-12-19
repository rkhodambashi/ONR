//int heaterR = 9;
//int heaterL = 10;    
int port =9;
void setup() {
//      pinMode(heaterL,OUTPUT);
//      pinMode(heaterR,OUTPUT);
      pinMode(port,OUTPUT);
}  
void loop(){
//        analogWrite(heaterR,0);
//        analogWrite(heaterL,0);
////          delay(50);
//          analogWrite(heaterR,125);
//          analogWrite(heaterL,255);        
   for (int value = 0 ; value <255; value=value+1){  
      analogWrite(port, value);
      delay(20);
   }
    for (int value = 255; value >0; value=value-1){  
          analogWrite(port, value);
          delay(20); 
     }
        
}
