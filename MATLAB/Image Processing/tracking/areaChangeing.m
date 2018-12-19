clear all
close all
objects = imaqfind;
delete(objects);

obj.videoPlayer = vision.VideoPlayer;
obj.resultPlayer = vision.VideoPlayer;

reader = VideoReader('shortvideo.avi');
numFrames = ceil(reader.FrameRate*reader.Duration);

vidObj = vision.VideoFileReader('shortvideo.avi');

num = 1;
sizeControl = 0.25;
count = 1;
% numFrame = 1;

f = figure(1);

previewFrame = step(vidObj);
imshow(previewFrame);

f = figure(1);
% firstFrame = snapshot(obj.camera);
firstFrame = previewFrame;
% k  = readDistance;
[trackingRegion,RECT] = imcrop(firstFrame);
[stats,ori]= pointTracking(firstFrame,RECT,0);

start = uicontrol(f,'style','pushbutton','String', 'Start','Callback',@stopf, 'position',[100 0 100 25]);
stop = uicontrol(f,'style','pushbutton','String', 'Stop','Callback',@stopf, 'position',[0 0 100 25]);

sortedArea = sort(stats.Area,'descend');
filiterSize = ceil(sizeControl*sortedArea(1));
tic;

areaData = zeros(num+1,1000000);
positionData= zeros(num+2,1000000);

% while ishandle(stop)
% while ~isDone(obj.videoPlayer) && ishandle(stop)
while (ishandle(stop) && count <= numFrames)
%         frame = read(v,numFrame);
        videoFrame = step(vidObj);
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
        
        count = count+1;
% 		numFrame = numFrame+1;
%         hold on;
%         plot(count(1:end),areaData(1,count),'o');
%         plot(count(1:end),areaData(1,count),'-');
%         plot(count(1:end),areaData(1,count),'+');
%         plot(count(1:end),areaData(1,count),'x');
end


delete(vidObj);
areaData = areaData(:,1:count);
positionData = positionData(:,1:count);
% showTrajectory(figure,positionData,RECT);

% area = [k(1)*k(2)*areaData(1:num,:);areaData(num+1,:)];

clear obj
close all

positionData = positionData(:,2:2:end);
imshow(firstFrame);fig = figure(1);
showTrajectory(fig,positionData,RECT);


