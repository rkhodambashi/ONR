// Distributed with a free-will license.
// Use it any way you want, profit or free, provided it fits in the licenses of its associated works.
// PCA9685
// This code is designed to work with the PCA9685_I2CPWM8W16I12V I2C Mini Module available from ControlEverything.com.
// https://www.controleverything.com/content/FET-Drivers?sku=PCA9685_I2CPWM8W16I12V#tabs-0-product_tabset-2

#include<Wire.h>

// PCA9685 I2C address is 0x40(64)
#define Addr 0x40

int mode = 0;
int PWM_ratio = 0;//=  {' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',};
char PWM_ic;
int PWM_channel = 2;
int counter = 0;
char seperator = ',';
char input_char;
int input_int;
int input_data = 0;
int k = -1;

int left = 2;      
int right = 3;   

void setup()
{
  
  // Initialise Serial Communication, Baud rate = 9600
  //Serial.begin(115200);
  // Start I2C Transmission
  pinMode(left, OUTPUT);   // sets the pin as output
  pinMode(right, OUTPUT);   // sets the pin as output
 
}
  
  

void loop()
{
  //if (Serial.available()){
  while (Serial.available()) {
    input_char = Serial.read();
    Serial.write(input_char);
    if (input_char == seperator)
    {
      k = k * -1;
      if (k == -1)
      {
      PWM_ratio = input_data;
      }
      if (k==1)
      {
      PWM_channel = input_data;
      }
      input_data = 0;
    }
    else
    {
      input_int = input_char - '0';
      //    Serial.println(input_int);
      input_data = input_data * 10;
      input_data = input_data + input_int;
    }
  }
 // }  
//Serial.write('PWM_channel');
analogWrite(PWM_channel, PWM_ratio);
//analogWrite(2, 255);  // analogRead values go from 0 to 1023, analogWrite values from 0 to 255
//analogWrite(3, 255);
//analogWrite(4, 255);
//analogWrite(5, 255);
}

