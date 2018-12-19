clear all
close all
objects = imaqfind;
delete(objects);

a =arduino();
obj.videoPlayer = vision.VideoPlayer;
obj.resultPlayer = vision.VideoPlayer;
vidobj = videoinput('winvideo');
triggerconfig(vidobj, 'manual');
start(vidobj);

% writer= VideoWriter('testVideo.avi');
% writer.Quality = 95;
% writer.FrameRate = 30;
% v = VideoReader('video4.mov');

num = 1;
sizeControl = 0.80;
count = 1;
heatingTime = 5;
coollingTime = 30;
% numFrame = 1;

% open(writer);
f = figure(1);
takePicture = uicontrol(f,'style','pushbutton','String', 'Take','Callback',@stopf, 'position',[0 0 100 25]);

while ishandle(takePicture)
%     previewFrame = snapshot(obj.camera);
    previewFrame = getsnapshot(vidobj);
%     previewFrame = read(v,numFrame);
    imshow(previewFrame);
end

f = figure(1);

% firstFrame = snapshot(obj.camera);
firstFrame = previewFrame;
k  = readDistance;
[roi,RECT] = imcrop(firstFrame);
[stats,ori]= pointTracking(firstFrame,RECT,0);

sortedArea = sort(stats.Area,'descend');
filiterSize = ceil(sizeControl*sortedArea(1));

[~,RECT] = imcrop(firstFrame);

start = uicontrol(f,'style','pushbutton','String', 'Start','Callback',@stopf, 'position',[100 0 100 25]);
stop = uicontrol(f,'style','pushbutton','String', 'Stop','Callback',@stopf, 'position',[0 0 100 25]);
while ishandle(stop) && ishandle(start)
%         frame = read(v,numFrame);
        videoFrame = getsnapshot(vidobj);
        [stats,frame2]= pointTracking(videoFrame,RECT,filiterSize);
        [position,count] = propertyTransformation(stats,RECT,count,num);
		
        if position.Status == 1
        frame = markFrame(position.Centroid,position.Bbox,RECT,videoFrame);
        else
            frame = markFrame([],[],RECT,videoFrame);
        end
% 		writeVideo(writer,videoFrame);
        step(obj.videoPlayer,frame);
end
tic;
areaData = zeros(num+1,1000000);
positionData= zeros(num+2,1000000);

writePWMDutyCycle(a,'D10',0.5);
% while ishandle(stop)
% while ~isDone(obj.videoPlayer) && ishandle(stop)

while ishandle(stop)
%         frame = read(v,numFrame);
        videoFrame = getsnapshot(vidobj);
        [stats,frame2]= pointTracking(videoFrame,RECT,filiterSize);
        [position,count] = propertyTransformation(stats,RECT,count,num);
		
        
        if position.Status == 1
        frame = markFrame(position.Centroid,position.Bbox,RECT,videoFrame);
        areaData(1:num+1,count) = [position.Area(1:num);position.Time(1)];
		positionData(1:num+2,count) = [position.Centroid';position.Time(1)];
        else
            frame = markFrame([],[],RECT,videoFrame);
        end
        step(obj.videoPlayer,frame);
        step(obj.resultPlayer,frame2);		
        time = toc;
        if time > heatingTime
        writePWMDutyCycle(a,'D9',0.5);
        writePWMDutyCycle(a,'D10',0);
        end
        if time > coollingTime
            break
        end
% 		numFrame = numFrame+1;
%         hold on;
%         plot(count(1:end),areaData(1,count),'o');
%         plot(count(1:end),areaData(1,count),'-');
%         plot(count(1:end),areaData(1,count),'+');
%         plot(count(1:end),areaData(1,count),'x');
end

writePWMDutyCycle(a,'D9',0);
writePWMDutyCycle(a,'D10',0);

% close(writer);
delete(vidobj);
areaData = areaData(:,1:count);
positionData = positionData(:,1:count);
area = [k(1)*k(2)*areaData(1:num,:);areaData(num+1,:)];

clear obj
close all