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
}
//===========================================================
float delayTime = 200;
float minutesHigh = 10;
float timerOverflow;
int sampleRateTimer = 0;
boolean highLow = 0;
//int minutesHigh = 1;
//int minutesLow = 1;
int highTemp = 36;
int lowTemp = 28;

float setTemp = 36;
char setTemp1;
float currentTemp;
float previousTemp;
float currentError = 0;
float previousError = 0;
//float sigmaError = 0;
const int integratorLength = 30;
float sigmaError[integratorLength]={0};
float integralError =0;
float drivativeError;

float proportional = 50;
float integral = 0;
float drivative = 200;


float controlSignal = 0;
float pwmRatio;

float deltaT = 0.0;
int firstRun =1;
byte force[8];
int counter = 0;
float timer = 0;
boolean heating =  HIGH;
boolean cooling = LOW;
//===========================================================
void loop() {
  timerOverflow = minutesHigh*60*1000/delayTime;
  if (timer>timerOverflow && heating ==HIGH){
    setTemp = 28;
    heating = LOW;
    cooling = HIGH;
    timer = 0;
  }
  if (timer>timerOverflow && cooling ==HIGH){
    setTemp = 36;
    heating = HIGH;
    cooling = LOW;
    timer = 0;
  }
  //digitalWrite(activatePeltier,LOW);
  if (Serial.available()){
    setTemp = Serial.parseFloat();
    //setTemp = atof(setTemp1);
  }
  //Serial.println(setTemp);
  //setTemp = Serial.read();
  currentTemp = max.readThermocoupleTemperature();
  currentError = setTemp - currentTemp;
  //sigmaError = sigmaError+currentError*(delayTime/1000);
  sigmaError[counter] = currentError*(delayTime/1000);
  for (int i=1;i==integratorLength;i++){
    integralError = integralError+sigmaError[i];
  }
  
  drivativeError = (currentError - previousError)/(delayTime/1000);
  
  controlSignal = proportional*currentError+integral*integralError+drivative*drivativeError;
  //Serial.println(controlSignal);
//  Serial.println(currentError);
//  Serial.println(previousError);
//  //Serial.println(proportionalError);
//  Serial.println(sigmaError);
//  Serial.println(drivativeError);
  
  pwmRatio = map(abs(controlSignal),0,100,0,255);
 // Serial.println(pwmRatio);
  if (controlSignal > deltaT){
    digitalWrite(heatUp,HIGH);
    digitalWrite(coolDown,LOW);
    analogWrite(activatePeltier,pwmRatio);
    //digitalWrite(activatePeltier,HIGH);
  }
  if (controlSignal < -deltaT){
    digitalWrite(coolDown,HIGH);
    digitalWrite(heatUp,LOW);
    analogWrite(activatePeltier,pwmRatio);
  }
  if (currentError < deltaT && currentError > -deltaT ){
    //digitalWrite(heatUp,HIGH);
    //digitalWrite(coolDown,LOW);
    digitalWrite(activatePeltier,LOW);
    //digitalWrite(activatePeltier,HIGH);
  } 
counter = counter+1;
previousError = currentError;
sampleRateTimer = sampleRateTimer+1;
if (sampleRateTimer>=5){
  Serial.println(currentTemp);
  sampleRateTimer = 0;
}
//Serial.println(setTemp);
//Serial.println(timerOverflow);

//Serial.println(pwmRatio);
delay(delayTime);
timer = timer+1;

if (counter == integratorLength-1){
  //sigmaError = 0;
  counter = 0;
}
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
