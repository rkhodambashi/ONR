%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Program Name : MATLAB Video Cutter
% Author : Arindam Bose
% Version : 1.0
% Copyright : ? Arindam Bose, All rights reserved.
% License : Open Source, Freeware
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vid = VideoReader('G:\My Drive\ASU\Research\ONR\Pics\Camera\DSC_0832.MOV');
writerObj = VideoWriter('samplevideo1.avi');
writerObj.FrameRate = 30;% Change the desired frame rate here.
open(writerObj);
nFrames = vid.NumberOfFrames;
vidHeight = vid.Height;
vidWidth = vid.Width;
mov(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),'colormap', []);
for k = 31 : nFramesLeft
mov(k).cdata = read(vid, k);
writeVideo(writerObj, mov(k).cdata);
end
hf = figure;
set(hf, 'position', [20 150 vidWidth vidHeight]);
movie(hf, mov, 1, vid.FrameRate);
close(writerObj);