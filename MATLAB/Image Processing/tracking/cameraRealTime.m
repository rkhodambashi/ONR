clear all
close all
obj.videoPlayer = vision.VideoPlayer;
obj.resultPlayer = vision.VideoPlayer;
obj.camera = webcam;
obj.camera.Resolvtion = '1920x1080'

num = 1;
sizeControl = 0.55;
count = 1;

f = figure(1);
takePicture = uicontrol(f,'style','pushbutton','String', 'Take','Callback',@stopf, 'position',[0 0 100 25]);
while ishandle(takePicture)
    previewFrame = snapshot(obj.camera);
    imshow(previewFrame);
end
f = figure(1);
firstFrame = snapshot(obj.camera);

[trackingRegion,RECT] = imcrop(firstFrame);
[~,stats]= pointTracking(firstFrame,RECT,0);
stop = uicontrol(f,'style','pushbutton','String', 'Stop','Callback',@stopf, 'position',[0 0 100 25]);

    sortedArea = sort(stats.Area,'descend');
    filiterSize = ceil(sizeControl*sortedArea(num));
tic
figure(2);
while ishandle(stop)
        frame = snapshot(obj.camera);
        [frame2,stats]= pointTracking(frame,RECT,filiterSize);
        [position,count] = propertyTransformation(stats,RECT,count);
        if position.Status == 1
        frame = markFrame(position.Centroid,position.Bbox,RECT,frame);
        else
            beep;
        end
        step(obj.videoPlayer,frame);
        step(obj.resultPlayer,frame2);		
        areaData(:,count) =position.Area;hold on
        plot(count(1:end),areaData(1,count),'o');
        plot(count(1:end),areaData(1,count),'-');
        plot(count(1:end),areaData(1,count),'+');
        plot(count(1:end),areaData(1,count),'x');
end
clear obj
close all


pointTracking
propertyTransformation
filiterOne