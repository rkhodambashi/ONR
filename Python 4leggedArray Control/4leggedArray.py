# -*- coding: utf-8 -*-
"""
Created on Tue Jun 26 10:44:23 2018

@author: rkhodamb
"""

import serial
import time
ser = serial.Serial('COM9', baudrate=115200, bytesize =8)
print(ser.name) 
time.sleep(5)
while True:
    for i in range (0,4095,100):
        texts = '3,'+str(i)+','#this format is to match the corresponding arduino code 
        ser.write(texts.encode('ASCII'))
        time.sleep(0.01)
    for i in range (4095,0,-100):
        texts = '3,'+str(i)+','#this format is to match the corresponding arduino code 
        ser.write(texts.encode('ASCII'))
        time.sleep(0.01)