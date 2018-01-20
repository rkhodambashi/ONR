#include <Adafruit_MAX31856.h>

// Use software SPI: CS, DI, DO, CLK
Adafruit_MAX31856 max = Adafruit_MAX31856(10, 11, 12, 13);
// use hardware SPI, just pass in the CS pin
//Adafruit_MAX31856 max = Adafruit_MAX31856(10);
//char force;
float temp;
byte force[8];
void setup() {
  Serial.begin(115200);
  Serial1.begin(115200);

  //Serial.println("MAX31856 thermocouple test");

  max.begin();

  max.setThermocoupleType(MAX31856_TCTYPE_K);

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

void loop() {
  //Serial.print("Cold Junction Temp: "); Serial.println(max.readCJTemperature());

  // Serial.print("Thermocouple Temp: "); 
  //Serial.println(max.readThermocoupleTemperature());
  Serial1.write('?');
  Serial1.write('\r');
  Serial1.write('\n');
  //Serial.println(Serial1.read());
  //Serial1.print('CR/LF');
  Serial1.readBytes(force,4);
  //force = strtok(force," ");
  temp = max.readThermocoupleTemperature();
  Serial.println(force[1]);
  Serial.println(force[2]);
  Serial.println(temp);
  
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
  delay(100);
}
