%% Acquire Images
% Acquire a series of images to analyze.

% Access an image acquisition device.
%vid = videoinput('winvideo', 2, 'MJPG_1024x576');%Logitech webcam

%vid = videoinput('winvideo', 1);
% vid.Timeout = 12;

% Configure object to capture every fifth frame.
% vid.FrameGrabInterval = 5;

% Configure the number of frames to be logged.
% vid.FramesPerTrigger = 50;

% Access the device's video source object selected for acquisition.
% src = getselectedsource(vid);

% Configure the device to provide 30 frames per second.
%src.FrameRate = '30';

% Open a live preview window. Focus camera onto a moving pendulum.
% preview(vid);

% Initiate the acquisition.
% start(vid);

% Extract frames from memory.
% frames = getdata(vid);

% Remove video input object from memory.
% delete(vid)
% clear vid
clear all

vidObj = VideoReader('G:\My Drive\ASU\Research\ONR\Pics\Camera\DSC_0832.MOV');
numFrames = ceil(vidObj.FrameRate*vidObj.Duration);

%reader = vision.VideoFileReader('G:\My Drive\ASU\Research\ONR\Microscope\Amscope\2018-04-24\bendingprotractor-twosided-new-button1test5.avi');
reader = vision.VideoFileReader('G:\My Drive\ASU\Research\ONR\Pics\Camera\DSC_0832.MOV');
% info = get(reader);
%     numFrames = 0;
%     while ~isDone(reader)
%         step(reader);
%         numFrames = numFrames + 1;
%     end

% viewer = vision.DeployableVideoPlayer;
firstFrame = step(reader);
imshow(firstFrame);
h = imdistline;
fcn = makeConstrainToRectFcn('imline', get(gca,'XLim'),get(gca,'YLim'));
setDragConstraintFcn(h,fcn);  
actualDistance_x = input('please enter the actual distance in x direction and press Enter: ');
mmPerPixel_x = actualDistance_x/h.getDistance;

h = imdistline;
fcn = makeConstrainToRectFcn('imline', get(gca,'XLim'),get(gca,'YLim'));
setDragConstraintFcn(h,fcn);  
actualDistance_y = input('please enter the actual distance in y direction and press Enter: ');
mmPerPixel_y = actualDistance_y/h.getDistance;

[frameRegion,RECT] = imcrop(firstFrame);
regions = repmat(0, [size(frameRegion) numFrames]);
for count = 1:numFrames,
    videoFrame = step(reader);
    regions(:,:,:,count) = imcrop(videoFrame, floor(RECT));
%     imshow(regions(:,:,:,count));
end
% Initialize array to contain the segmented frames.
segPend = false([size(frameRegion, 1) size(frameRegion, 2) numFrames]);
centroids = zeros(numFrames, 2);
% structDisk = strel('disk', 3);
structDisk = strel('disk', 10);
for count = 1:numFrames,
    % Convert to grayscale.
    fr = regions(:,:,:,count); 
    gfr = rgb2gray(fr);
    gfr = imcomplement(gfr); 
    % Experimentally determine the threshold.
    bw = im2bw(fr, .2);
    bw = imopen(bw, structDisk);
    segPend(:,:,count) = bw;
end
% Calculate the centers.
for count = 1:numFrames
    property = regionprops(segPend(:, :, count), 'Centroid','MajorAxisLength','MinorAxisLength');
    pendCenters(count,:) = property.Centroid; 
    diameters = mean([property.MajorAxisLength property.MinorAxisLength],2);
    radii = diameters/2;
    hold on
%     viscircles(pendCenters(count,:),radii);
    plot(pendCenters(count,1),pendCenters(count,2),'or')
end
figure;
x = pendCenters(:, 1);
x = size(frameRegion,2)-x; %flipping the x axis
y = pendCenters(:, 2);
x_mm = x*mmPerPixel_x;
y_mm = y*mmPerPixel_y;
plot(x, y, 'm.');
%axis ij;
axis equal;
hold on;
xlabel('x');
ylabel('y');
% Solve the equation.
abc = [x y ones(length(x),1)] \ [-(x.^2 + y.^2)];
a = abc(1);
b = abc(2);
c = abc(3);
xc = -a/2;
yc = -b/2;
circleRadius = sqrt((xc^2 + yc^2) - c); 

% Circle radius is the length of the pendulum in pixels.
pendulumLength = round(circleRadius)

%%
% Superimpose results onto the centers
circle_theta = pi/3:0.01:pi*2/3;
x_fit = circleRadius*cos(circle_theta) + xc;
y_fit = circleRadius*sin(circle_theta) + yc;
plot(x_fit, y_fit, 'b-');
plot(xc, yc, 'bx', 'LineWidth', 2);
plot([xc x(1)], [yc y(1)], 'b-');
titleStr = sprintf('Pendulum Length = %d pixels', pendulumLength);
text(xc-110, yc+100, titleStr);
