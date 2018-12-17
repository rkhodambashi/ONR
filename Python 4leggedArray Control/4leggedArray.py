# -*- coding: utf-8 -*-
"""
Created on Tue Jun 26 10:44:23 2018

@author: rkhodamb
"""

import serial
import time
ser = serial.Serial('COM3', baudrate=115200, bytesize =8)
print(ser.name) 
time.sleep(5)

#firstLegRight = 1
#firstLegLeft = 2
#secondLegRight = 3
#secondLegLeft = 4
#thirdLegRight = 5
#thirdLegLeft = 6
#fourthLegRight = 7
#fourthLegLeft = 8
Resistor1 = 1
Resistor2 = 2
Resistor3 = 3
Resistor4 = 4
Resistor5 = 5
Resistor6 = 6
Resistor7 = 7
Resistor8 = 8
Resistor9 = 9
Resistor10 = 10
Resistor11 = 11
Resistor12 = 12
Resistor13 = 13
Resistor14 = 14
Resistor15 = 15
Resistor16 = 16
timeSleep = 0.1
timeSleep1 = 1
timeSleep2 = 0.01

timesleep = 0.3;
while True:
    texts = str(Resistor1)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    texts = str(Resistor1)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    
    texts = str(Resistor2)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    texts = str(Resistor2)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    
    texts = str(Resistor3)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    texts = str(Resistor3)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    
    texts = str(Resistor4)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    texts = str(Resistor4)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    
    texts = str(Resistor5)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    texts = str(Resistor5)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    
    texts = str(Resistor6)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    texts = str(Resistor6)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    
    texts = str(Resistor7)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    texts = str(Resistor7)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    
    texts = str(Resistor8)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    texts = str(Resistor8)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    
    texts = str(Resistor9)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    texts = str(Resistor9)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    
    texts = str(Resistor10)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    texts = str(Resistor10)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    
    texts = str(Resistor11)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    texts = str(Resistor11)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    
    texts = str(Resistor12)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    texts = str(Resistor12)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    
    texts = str(Resistor13)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    texts = str(Resistor13)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    
    texts = str(Resistor14)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    texts = str(Resistor14)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    
    texts = str(Resistor15)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    texts = str(Resistor15)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    
    texts = str(Resistor16)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
    texts = str(Resistor16)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(timeSleep)
        
    time.sleep(timeSleep1)
    
#    texts = str(firstLegRight)+',4095,'
#    ser.write(texts.encode('ASCII'))
#    texts = str(firstLegRight)+',4095,'
#    ser.write(texts.encode('ASCII'))
    
#    for i in range (0,4095,100):
#        texts = '3,'+str(i)+','#this format is to match the corresponding arduino code 
#        ser.write(texts.encode('ASCII'))
#        time.sleep(0.01)
#    for i in range (4095,0,-100):
#        texts = '3,'+str(i)+','#this format is to match the corresponding arduino code 
#        ser.write(texts.encode('ASCII'))
#        time.sleep(0.01)