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

firstLegRight = 1
firstLegLeft = 2
secondLegRight = 3
secondLegLeft = 4
thirdLegRight = 5
thirdLegLeft = 6
fourthLegRight = 7
fourthLegLeft = 8
timesleep = 0.3;
while True:
    texts = str(firstLegRight)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(0.01)
    texts = str(thirdLegRight)+',4095,'
    ser.write(texts.encode('ASCII'))
    
    time.sleep(timesleep)
    
    texts = str(firstLegLeft)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(0.01)
    texts = str(thirdLegLeft)+',4095,'
    ser.write(texts.encode('ASCII'))
    
    time.sleep(timesleep)
        
    texts = str(firstLegRight)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(0.01)
    texts = str(thirdLegRight)+',0,'
    ser.write(texts.encode('ASCII'))
    
    time.sleep(timesleep)
    
    texts = str(firstLegLeft)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(0.01)
    texts = str(thirdLegLeft)+',0,'
    ser.write(texts.encode('ASCII'))
    
    time.sleep(timesleep)
    
    #--------------------------------------------------
    texts = str(secondLegRight)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(0.01)
    texts = str(fourthLegRight)+',4095,'
    ser.write(texts.encode('ASCII'))
    
    time.sleep(timesleep)
    
    texts = str(secondLegLeft)+',4095,'
    ser.write(texts.encode('ASCII'))
    time.sleep(0.01)
    texts = str(fourthLegLeft)+',4095,'
    ser.write(texts.encode('ASCII'))
    
    time.sleep(timesleep)
    
    texts = str(secondLegRight)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(0.01)
    texts = str(fourthLegRight)+',0,'
    ser.write(texts.encode('ASCII'))
    
    time.sleep(timesleep)
    
    texts = str(secondLegLeft)+',0,'
    ser.write(texts.encode('ASCII'))
    time.sleep(0.01)
    texts = str(fourthLegLeft)+',0,'
    ser.write(texts.encode('ASCII'))
    
    time.sleep(5)
    
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