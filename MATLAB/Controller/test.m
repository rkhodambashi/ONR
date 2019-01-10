INPUTBUFFER = 512;
arduinoInterface = serial('COM7', 'BaudRate', 115200, 'DataBits',8); 
set(arduinoInterface,'InputBufferSize', INPUTBUFFER);
fopen(arduinoInterface);
for i=1:100
fprintf(arduinoInterface,'2,255');
pause(1);
fprintf(arduinoInterface,'2,0');
pause(1);
end
fclose(arduinoInterface);
