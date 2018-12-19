clear a;
heaterR = 'D9';
heaterL = 'D10';
a = arduino();

configurePin(a,heaterR,'PWM');
configurePin(a,heaterL,'PWM');

writePWMVoltage(a,heaterR,1);
writePWMVoltage(a,heaterL,1);


