a = arduino();
cam =webcam;

figure(1);
f = figure(1);
start = uicontrol(f,'style','pushbutton','String', 'Start','Callback',@stopf, 'position',[0 0 100 25]);
while ishandle(start)
    frame = snapshot(cam);
    imshow(frame);
end
stop = uicontrol(f,'style','pushbutton','String', 'Stop','Callback',@stopf, 'position',[0 0 100 25]);
tic;
while ishandle(stop)
    frame = snapshot(cam);
    imshow(frame);
    time = toc;
    writePWMDutyCycle(a,'D10',0.5);
    if time >5
        break
    end
end
writePWMDutyCycle(a,'D10',0);
close 1
clear cam
clear a

writePWMDutyCycle(a,'D9',0);
writePWMDutyCycle(a,'D10',0);
writePWMDutyCycle(a,'D9',1);
writePWMDutyCycle(a,'D10',1);
writePWMDutyCycle(a,'D9',1);
writePWMDutyCycle(a,'D10',0.5);
writePWMDutyCycle(a,'D9',0.5);
writePWMDutyCycle(a,'D10',0.5);