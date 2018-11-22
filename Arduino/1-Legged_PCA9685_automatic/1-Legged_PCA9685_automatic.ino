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
int PWM_channel = 0;
int counter = 0;
char seperator = ',';
char input_char;
int input_int;
int input_data = 0;
int k = -1;
int pause = 200;
void setup()
{
  // Initialise I2C communication as MASTER
  Wire.begin();
  Wire.setClock(400000);
  // Initialise Serial Communication, Baud rate = 9600
  Serial.begin(115200);

  // Start I2C Transmission
  Wire.beginTransmission(Addr);
  // Select MODE2 register
  Wire.write(0x01);
  // All pin's outputs are configured with a totem pole structure.
  Wire.write(0x04);
  // Stop I2C Transmission
  Wire.endTransmission();

  // Start I2C Transmission
  Wire.beginTransmission(Addr);
  // Select MODE1 register
  Wire.write(0x00);
  // Response to LED all-call I2C address
  Wire.write(0x01);
  // Stop I2C Transmission
  Wire.endTransmission();
  delay(5);

  // Start I2C Transmission
  Wire.beginTransmission(Addr);
  // Select data register
  Wire.write(0x00);
  // Stop I2C Transmission
  Wire.endTransmission();

  // Request 1 byte of data
  Wire.requestFrom(Addr, 1);

  // Read 1 byte of data
  if (Wire.available() == 1)
  {
    mode = Wire.read();
  }

  // Start I2C Transmission
  Wire.beginTransmission(Addr);
  // Select MODE1 register
  Wire.write(0x00);
  // Response to LED all-call I2C address
  Wire.write(0x10);
  // Stop I2C Transmission
  Wire.endTransmission();

  //  // Start I2C Transmission
  //  Wire.beginTransmission(Addr);
  //  // Select PRE_SCALE register
  //  Wire.write(0xFE);
  //  // Set prescale frequency to 60 Hz
  //  Wire.write(0x65);
  //  // Stop I2C Transmission
  //  Wire.endTransmission();

  // Start I2C Transmission
  Wire.beginTransmission(Addr);
  // Select MODE1 register
  Wire.write(0x00);
  // Response to LED all-call I2C address
  Wire.write((byte)mode);
  // Stop I2C Transmission
  Wire.endTransmission();
  delay(5);

  // Start I2C Transmission
  Wire.beginTransmission(Addr);
  // Select MODE1 register
  Wire.write(0x00);
  // Response to LED all-call I2C address
  Wire.write((mode | 0x80));
  // Stop I2C Transmission
  Wire.endTransmission();

pinMode(22, INPUT); 
pinMode(24, INPUT);
pinMode(26, INPUT);
pinMode(28, INPUT);
pinMode(30, INPUT);
pinMode(32, INPUT);
pinMode(34, INPUT);
pinMode(36, INPUT);
}

void loop()
{
////pattern 1======================================
//PWM_ratio = 4095;
//PWM_channel = 1;
//wireTransmission();
//PWM_channel = 3;
//wireTransmission();
//PWM_channel = 5;
//wireTransmission();
//PWM_channel = 7;
//wireTransmission();
//
//delay(200);
//PWM_ratio = 0;
//PWM_channel = 1;
//wireTransmission();
//PWM_channel = 3;
//wireTransmission();
//PWM_channel = 5;
//wireTransmission();
//PWM_channel = 7;
//wireTransmission();
////================================================
//pattern 2======================================
PWM_ratio = 4095;
PWM_channel = 1;
wireTransmission();
PWM_channel = 5;
wireTransmission();

delay(200);
PWM_ratio = 0;
PWM_channel = 1;
wireTransmission();
PWM_channel = 5;
wireTransmission();

delay(1000);

PWM_ratio = 4095;
PWM_channel = 3;
wireTransmission();
PWM_channel = 7;
wireTransmission();

delay(200);
PWM_ratio = 0;
PWM_channel = 3;
wireTransmission();
PWM_channel = 7;
wireTransmission();

delay(1000);
PWM_ratio = 4095;
PWM_channel = 2;
wireTransmission();
PWM_channel = 4;
wireTransmission();
PWM_channel = 6;
wireTransmission();
PWM_channel = 8;
wireTransmission();

delay(200);
PWM_ratio = 0;
PWM_channel = 2;
wireTransmission();
PWM_channel = 4;
wireTransmission();
PWM_channel = 6;
wireTransmission();
PWM_channel = 8;
wireTransmission();

//================================================
// PWM_channel = 1; 
// PWM_ratio = 4095;
// wireTransmission();
//// delay(pause);
//// PWM_channel = 1; 
//// PWM_ratio = 0;
//// wireTransmission(); 
//// delay(pause);
//
//// PWM_channel = 2; 
//// PWM_ratio = 4095; 
//// wireTransmission();
//// delay(100);
//// PWM_channel = 2; 
//// PWM_ratio = 0;
//// wireTransmission(); 
//// delay(100);
//
// PWM_channel = 3; 
// PWM_ratio = 4095; 
// wireTransmission();
//// delay(pause);
//// PWM_channel = 3; 
//// PWM_ratio = 0;
//// wireTransmission(); 
//// delay(pause);
//
//// PWM_channel = 4; 
//// PWM_ratio = 4095; 
//// wireTransmission();
//// delay(100);
//// PWM_channel = 4; 
//// PWM_ratio = 0;
//// wireTransmission(); 
//// delay(100);
//
// PWM_channel = 5;
// PWM_ratio = 4095; 
// wireTransmission(); 
//// delay(pause);
//// PWM_channel = 5; 
//// PWM_ratio = 0;
//// wireTransmission(); 
//// delay(pause);
// 
//// PWM_channel = 6; 
//// PWM_ratio = 4095; 
//// wireTransmission();
//// delay(100);
//// PWM_channel = 6; 
//// PWM_ratio = 0;
//// wireTransmission(); 
//// delay(100);
//
// PWM_channel = 7;
// PWM_ratio = 4095; 
// wireTransmission(); 
//// delay(pause);
//// PWM_channel = 7; 
//// PWM_ratio = 0;
//// wireTransmission(); 
//// delay(pause);
// 
//// PWM_channel = 8; 
//// PWM_ratio = 4095; 
//// wireTransmission();
//// delay(100);
//// PWM_channel = 8; 
//// PWM_ratio = 0;
//// wireTransmission(); 
//// delay(100);

 delay(7000);

}

void wireTransmission()
{
  Wire.beginTransmission(Addr);
  // Select LEDn_ON_L register
  //Wire.write(i);

  Wire.write(4 * PWM_channel + 2);
  //LEDn_ON lower byte
  Wire.write(0);//on starts at time 0 (no delay)
  // Stop I2C Transmission
  Wire.endTransmission();

  // Start I2C Transmission
  Wire.beginTransmission(Addr);
  // Select ALL_LED_ON_H register
  Wire.write(4 * PWM_channel + 3);
  // ALL_LED_ON higher byte
  Wire.write(0);//on starts at time 0 (no delay)
  // Stop I2C Transmission
  Wire.endTransmission();

  // Start I2C Transmission
  Wire.beginTransmission(Addr);
  // Select ALL_LED_OFF_L register
  Wire.write(4 * PWM_channel + 4);
  // ALL_LED_OFF lower byte
  Wire.write((PWM_ratio & 0xFF));//this goes from 0 to 255

  // Stop I2C Transmission
  Wire.endTransmission();

  // Start I2C Transmission
  Wire.beginTransmission(Addr);
  // Select ALL_LED_OFF_H register
  Wire.write(4 * PWM_channel + 5);
  // ALL_LED_OFF higher byte
  Wire.write(PWM_ratio >> 8); //this goes from 0 to 16
  // Stop I2C Transmission
  Wire.endTransmission();
}
