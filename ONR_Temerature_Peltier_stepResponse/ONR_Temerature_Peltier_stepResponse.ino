#include <Adafruit_MAX31856.h>

// Use software SPI: CS, DI, DO, CLK
Adafruit_MAX31856 max = Adafruit_MAX31856(10, 11, 12, 13);
// use hardware SPI, just pass in the CS pin
//Adafruit_MAX31856 max = Adafruit_MAX31856(10);
//char force;

const int heatUp  =  6;
const int coolDown  =  7;
const int activatePeltier  =  8;//enable pin
const int fan  =  9;
//==========================================================
void setup() {
  Serial.begin(115200);
  //Serial.println("MAX31856 thermocouple test");

  max.begin();

  max.setThermocoupleType(MAX31856_TCTYPE_K);
pinMode(heatUp,OUTPUT);//direction pin
pinMode(coolDown,OUTPUT);//direction pin
pinMode(activatePeltier,OUTPUT);//enable pin
pinMode(fan,OUTPUT);//fan
int pwmRatio = 0.3*255;
digitalWrite(coolDown,LOW);
digitalWrite(heatUp,HIGH);
analogWrite(activatePeltier,pwmRatio);
}
//===========================================================
float delayTime = 1000;
boolean highLow = 0;
int minutesHigh = 1;
int minutesLow = 1;
int highTemp = 36;
int lowTemp = 28;

float setTemp = 35;
char setTemp1;
float currentTemp;
float previousTemp;
float currentError = 0;
float previousError = 0;
//float sigmaError = 0;

float sigmaError[100]={0};
float integralError =0;
float drivativeError;

float proportional = 20;
float integral = 15;
float drivative = 5;


float controlSignal = 0;
//int pwmRatio =  0.3*255;

float deltaT = 0.0;
int firstRun =1;
byte force[8];
int counter = 1;
//===========================================================
void loop() {
  //digitalWrite(activatePeltier,LOW);
//  if (Serial.available()){
//    setTemp = Serial.parseFloat();
//    //setTemp = atof(setTemp1);
//  }
  //Serial.println(setTemp);
  //setTemp = Serial.read();
  currentTemp = max.readThermocoupleTemperature();
  currentError = setTemp - currentTemp;
  //sigmaError = sigmaError+currentError*(delayTime/1000);
//  sigmaError[counter] = currentError*(delayTime/1000);
//  for (int i=1;i==100;i++){
//    integralError = integralError+sigmaError[i];
//  }
//  
//  drivativeError = (currentError - previousError)/(delayTime/1000);
//  
//  controlSignal = proportional*currentError+integral*integralError+drivative*drivativeError;
  //Serial.println(controlSignal);
//  Serial.println(currentError);
//  Serial.println(previousError);
//  //Serial.println(proportionalError);
//  Serial.println(sigmaError);
//  Serial.println(drivativeError);
  
//  pwmRatio = 10;
//
//    analogWrite(activatePeltier,pwmRatio);
    //digitalWrite(activatePeltier,HIGH);
 // }
//  if (currentError < -deltaT){
//    digitalWrite(coolDown,HIGH);
//    digitalWrite(heatUp,LOW);
//    analogWrite(activatePeltier,pwmRatio);
//  }
//  if (currentError < deltaT && currentError > -deltaT ){
//    //digitalWrite(heatUp,HIGH);
//    //digitalWrite(coolDown,LOW);
//    digitalWrite(activatePeltier,LOW);
//    //digitalWrite(activatePeltier,HIGH);
//  } 
//counter = counter+1;
//previousError = currentError;
Serial.println(currentTemp);
//Serial.println(pwmRatio);

//Serial.println(setTemp);
//Serial.println(pwmRatio);
delay(delayTime);
//if (counter == 100){
//  //sigmaError = 0;
//  counter = 0;
}

  
  
//  if (highLow ==0||firstRun ==1){
//     for (int i=1;i<=minutesHigh*60;i++){
//        delay(delayTime);
//        temp = max.readThermocoupleTemperature();
//        Serial.println(temp);
//        if(temp>highTemp){
//          digitalWrite(heater,LOW);
//          digitalWrite(fan,HIGH);
//        }
//        if(temp<highTemp-deltaT){
//          digitalWrite(heater,HIGH);
//          digitalWrite(fan,LOW);
//        }
//      }
//      highLow = 1;
//      firstRun =0;
//      digitalWrite(fan,HIGH);
//   }
//    
//   if (highLow ==1||firstRun ==1){
//     for (int j=1;j<=minutesLow*60;j++){
//        delay(delayTime);
//        temp = max.readThermocoupleTemperature();
//        Serial.println(temp);
//        if(temp>lowTemp){
//          digitalWrite(heater,LOW);
//          digitalWrite(fan,HIGH);
//        }
//        if(temp<lowTemp-deltaT){
//          digitalWrite(heater,HIGH);
//          digitalWrite(fan,LOW);
//        }
//     }
//   }
//    highLow = 0;
//    firstRun =0;
//    digitalWrite(fan,LOW);
//    previousError = currentError;
//    delay(delayTime);
//    Serial.println(currentTemp);
//}
