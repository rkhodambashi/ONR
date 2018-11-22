/*
  LiquidCrystal Library - Autoscroll

 Demonstrates the use a 16x2 LCD display.  The LiquidCrystal
 library works with all LCD displays that are compatible with the
 Hitachi HD44780 driver. There are many of them out there, and you
 can usually tell them by the 16-pin interface.

 This sketch demonstrates the use of the autoscroll()
 and noAutoscroll() functions to make new text scroll or not.

 The circuit:
 * LCD RS pin to digital pin 12
 * LCD Enable pin to digital pin 11
 * LCD D4 pin to digital pin 5
 * LCD D5 pin to digital pin 4
 * LCD D6 pin to digital pin 3
 * LCD D7 pin to digital pin 2
 * LCD R/W pin to ground
 * 10K resistor:
 * ends to +5V and ground
 * wiper to LCD VO pin (pin 3)

 Library originally added 18 Apr 2008
 by David A. Mellis
 library modified 5 Jul 2009
 by Limor Fried (http://www.ladyada.net)
 example added 9 Jul 2009
 by Tom Igoe
 modified 22 Nov 2010
 by Tom Igoe
 modified 7 Nov 2016
 by Arturo Guadalupi

 This example code is in the public domain.

 http://www.arduino.cc/en/Tutorial/LiquidCrystalAutoscroll

*/

// include the library code:
#include <LiquidCrystal.h>

// initialize the library by associating any needed LCD interface pin
// with the arduino pin number it is connected to
const int rs = 8, en = 9, d4 = 5, d5 = 4, d6 = 3, d7 = 2;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

#include <Adafruit_MAX31856.h>

// Use software SPI: CS, DI, DO, CLK
Adafruit_MAX31856 max = Adafruit_MAX31856(10, 11, 12, 13);
// use hardware SPI, just pass in the CS pin
//Adafruit_MAX31856 max = Adafruit_MAX31856(10);
//char force;
//const int controlPin  =  A1;
const int heatUp  =  7;
const int activatePeltier  =  6;//enable pin
const int coolDown  =  A0;
//const int fan  =  8;
void setup() {
  // set up the LCD's number of columns and rows:
  lcd.begin(16, 2);
  lcd.print("Initializing...");
  delay(5000);
  lcd.clear();
  Serial.begin(115200);
  //Serial.println("MAX31856 thermocouple test");

  max.begin();
  max.setThermocoupleType(MAX31856_TCTYPE_K);
  //pinMode(controlPin,INPUT);//direction pin  
  pinMode(heatUp,OUTPUT);//direction pin
  pinMode(coolDown,OUTPUT);//direction pin
  pinMode(activatePeltier,OUTPUT);//enable pin
//pinMode(fan,OUTPUT);//fan
}
float delayTime = 50;
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

float proportional = 200;
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
void loop() {
  // set the cursor to (0,0):
  //lcd.setCursor(0, 0);
  // print from 0 to 9:
  //for (int thisChar = 0; thisChar < 10; thisChar++) {
  
  lcd.setCursor(0, 0);
  lcd.print("Set Temp: ");
  lcd.print(setTemp);
  //delay(500);
  //}

//  // set the cursor to (16,1):
//  lcd.setCursor(16, 1);
//  // set the display to automatically scroll:
//  lcd.autoscroll();
//  // print from 0 to 9:
//  for (int thisChar = 0; thisChar < 10; thisChar++) {
//    lcd.print(thisChar);
//    //delay(500);
//  }
//  // turn off automatic scrolling
//  lcd.noAutoscroll();
//
//  // clear screen for the next loop:
  //lcd.clear();
//if (digitalRead(controlPin)==HIGH){
//  setTemp = 45;
//}
//if (digitalRead(controlPin)==LOW){
//  setTemp = 27;
//}
setTemp = analogRead(A3);
setTemp = map(setTemp,0,1023,15,50);
//Serial.println(setTemp);
  //Serial.println(setTemp);
  //setTemp = Serial.read();
  currentTemp = max.readThermocoupleTemperature();
  lcd.setCursor(0, 1);
  lcd.print("Act. Temp: ");
  lcd.print(currentTemp);
  //delay(500);
  currentError = setTemp - currentTemp;
  //sigmaError = sigmaError+currentError*(delayTime/1000);
  sigmaError[counter] = currentError*(delayTime/1000);
  for (int i=1;i==integratorLength;i++){
    integralError = integralError+sigmaError[i];
  }
  
  drivativeError = (currentError - previousError)/(delayTime/1000);
  
  controlSignal = proportional*currentError+integral*integralError+drivative*drivativeError;
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

