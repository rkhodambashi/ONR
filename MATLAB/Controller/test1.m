a = arduino();
for i=1:100
writePWMVoltage(a,'D2',5);
%writeDigitalPin(a,'D13',1);
pause(1);
writePWMVoltage(a,'D2',0);
%writeDigitalPin(a,'D13',0);
pause(1);
end