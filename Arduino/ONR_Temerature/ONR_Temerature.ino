#include <Adafruit_MAX31856.h>

// Use software SPI: CS, DI, DO, CLK
Adafruit_MAX31856 max = Adafruit_MAX31856(10, 11, 12, 13);
// use hardware SPI, just pass in the CS pin
//Adafruit_MAX31856 max = Adafruit_MAX31856(10);
//char force;
float temp;
byte force[8];
const int heater  =  8;
const int fan  =  6;
void setup() {
  Serial.begin(115200);
  //Serial.println("MAX31856 thermocouple test");

  max.begin();

  max.setThermocoupleType(MAX31856_TCTYPE_K);
pinMode(heater,OUTPUT);//heater
pinMode(fan,OUTPUT);//fan
//  Serial.print("Thermocouple type: ");
//  switch ( max.getThermocoupleType() ) {
//    case MAX31856_TCTYPE_B: Serial.println("B Type"); break;
//    case MAX31856_TCTYPE_E: Serial.println("E Type"); break;
//    case MAX31856_TCTYPE_J: Serial.println("J Type"); break;
//    case MAX31856_TCTYPE_K: Serial.println("K Type"); break;
//    case MAX31856_TCTYPE_N: Serial.println("N Type"); break;
//    case MAX31856_TCTYPE_R: Serial.println("R Type"); break;
//    case MAX31856_TCTYPE_S: Serial.println("S Type"); break;
//    case MAX31856_TCTYPE_T: Serial.println("T Type"); break;
//    case MAX31856_VMODE_G8: Serial.println("Voltage x8 Gain mode"); break;
//    case MAX31856_VMODE_G32: Serial.println("Voltage x8 Gain mode"); break;
//    default: Serial.println("Unknown"); break;
  //}


}
int delayTime = 1000;
boolean highLow = 0;
int minutesHigh = 20;
int minutesLow = 60;
int highTemp = 36;
int lowTemp = 28;
int firstRun =1;
float deltaT = 0.5;
void loop() {
  //Serial.print("Cold Junction Temp: "); Serial.println(max.readCJTemperature());
  
  // Serial.print("Thermocouple Temp: "); 
  temp = max.readThermocoupleTemperature();
  Serial.println(temp);
  //Serial.println(highLow);
  
//  if (temp<highTemp){
//    digitalWrite(8,HIGH); 
//  }
 // if (temp > highTemp+1){
    //digitalWrite(8,LOW);
    if (highLow ==0||firstRun ==1){
      for (int i=1;i<=minutesHigh*60;i++){
        delay(delayTime);
        temp = max.readThermocoupleTemperature();
        Serial.println(temp);
//       Serial.print("i: ");
//       Serial.println(i);
        if(temp>highTemp){
          digitalWrite(heater,LOW);
          digitalWrite(fan,HIGH);
        }
        if(temp<highTemp-deltaT){
          digitalWrite(heater,HIGH);
          digitalWrite(fan,LOW);
        }
      }
      highLow = 1;
      firstRun =0;
      digitalWrite(fan,HIGH);
    }
 // }
  //if (temp <lowTemp-1){
   // digitalWrite(8,HIGH);
    
    if (highLow ==1||firstRun ==1){
      for (int j=1;j<=minutesLow*60;j++){
        delay(delayTime);
        temp = max.readThermocoupleTemperature();
        Serial.println(temp);
//        Serial.print("j: ");
//        Serial.println(j);
        if(temp>lowTemp){
          digitalWrite(heater,LOW);
          digitalWrite(fan,HIGH);
        }
        if(temp<lowTemp-deltaT){
          digitalWrite(heater,HIGH);
          digitalWrite(fan,LOW);
        }
      }
    }
    highLow = 0;
    firstRun =0;
    digitalWrite(fan,LOW);
 // }
  // Check and print any faults
//  uint8_t fault = max.readFault();
//  if (fault) {
//    if (fault & MAX31856_FAULT_CJRANGE) Serial.println("Cold Junction Range Fault");
//    if (fault & MAX31856_FAULT_TCRANGE) Serial.println("Thermocouple Range Fault");
//    if (fault & MAX31856_FAULT_CJHIGH)  Serial.println("Cold Junction High Fault");
//    if (fault & MAX31856_FAULT_CJLOW)   Serial.println("Cold Junction Low Fault");
//    if (fault & MAX31856_FAULT_TCHIGH)  Serial.println("Thermocouple High Fault");
//    if (fault & MAX31856_FAULT_TCLOW)   Serial.println("Thermocouple Low Fault");
//    if (fault & MAX31856_FAULT_OVUV)    Serial.println("Over/Under Voltage Fault");
//    if (fault & MAX31856_FAULT_OPEN)    Serial.println("Thermocouple Open Fault");
//  }
  //delay(1000);
}
