%%This code generates a realtime plot of the incoming data from serial
%%port. the corresponding arduino code should be running in an arduino
%%connected to the same serial port.
%%copyright 2017 @Roozbeh Khodambashi
%%rkhodamb@asu.edu

close all;          % close all figures
clear;            % clear all w orkspace variables
clc;                % clear the command line
fclose('all');      % close all open files
delete(instrfindall);   % Reset Com Port
delete(timerfindall);   % Delete Timers
INPUTBUFFER = 512;

%% Create a serial object
forceSensor = serial('COM4', 'BaudRate', 115200, 'DataBits',8);  %com4 for lab pc, %com9 for laptop
thermocouple = serial('COM3', 'BaudRate', 115200, 'DataBits',8); %com3 for lab pc, %com4 for laptop
% Set serial port buffer 
set(forceSensor,'InputBufferSize', INPUTBUFFER);             
forceSensor.Terminator = 'CR';
%fopen(forceSensor);          %opens the serial port
set(thermocouple,'InputBufferSize', INPUTBUFFER);             
fopen(thermocouple);          %opens the serial port
number = 1;
figure
h = animatedline;
ax = gca;
ax.YGrid = 'on';
t=0;
stop = false;
startTime = datetime('now');
header1 = 'Time';
header2 = 'Temperature!';
header3 = 'Force';
fid = fopen('timeTempForce.txt','w');
fprintf(fid, [ header1 '     ' header2 '     ' header3 '\n']);
mData = [];
while(number<150000)
%query the temperature
temperature = (fscanf(thermocouple));
temperature = strsplit(temperature,' '); % same character as the Arduino code
mData(1) = str2double(temperature(1)); 
% query the force sensor
% fprintf(forceSensor,'?');
% data = (fscanf(forceSensor));
% force = strsplit(data,' '); % same character as the Arduino code
% mData(2) = str2double(force(1)); 
% Get current time
% t =  second(datetime('now')) - second(startTime); 
t =  (datetime('now')) - (startTime); 
% t = int32(hours(t))*60*60+int32(minutes(t))*60+seconds(t);
t = seconds(t);
axisTime = datetime('now') - startTime; 
%%=============================================
%%Draw animatedline       
% Add points to animation
addpoints(h,datenum(axisTime),mData(1))
% Update axes
ax.XLim = datenum([axisTime-seconds(15) axisTime]);
datetick('x','keeplimits')
drawnow
%%==============================================   
number = number+1;
fprintf(fid, '%f %f %f \n', t,mData(1),mData(1));
pause(0.1)
end
fclose(fid);
fclose(forceSensor); %close the serial port