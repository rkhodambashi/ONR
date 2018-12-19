% % a = arduino();
% writePWMDutyCycle(a,'D9',0.5); %Right CH1
% writePWMDutyCycle(a,'D10',0.2); %Left CH2
% writePWMDutyCycle(a,'D10',0.4);
% 
% writePWMDutyCycle(a,'D10',0);
% writePWMDutyCycle(a,'D9',0);
%  
% writePWMDutyCycle(a,'D10',0.5);
% writePWMDutyCycle(a,'D9',0.5);
%  
figure(1);
f = figure(1);
start = uicontrol(f,'style','pushbutton','String', 'Start','Callback',@stopf, 'position',[0 0 100 25]);
while ishandle(start)
    plot(1,1);
end
tic;
stop = uicontrol(f,'style','pushbutton','String', 'Start','Callback',@stopf, 'position',[0 0 100 25]);
while  ishandle(stop)
writePWMDutyCycle(a,'D10',0.5);
a = toc;
    if a >1
        break
    end
end
writePWMDutyCycle(a,'D10',0.5);
clear cam
clear a