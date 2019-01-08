function[stats,BW]= pointTracking(frame,RECT,filiterSize,mode)
    region = imcrop(frame, floor(RECT));
%     region = frame;
%     region =  findPurple(region);
    BW  =  filiter(region,filiterSize,mode);
    stats = regionprops('table',BW,'Area','Centroid','BoundingBox');
%     hold off
end

function [BW]  =  filiter(region,filiterSize,mode)
    BW = rgb2gray(region);
%     BW = imsharpen(BW,'Amount',1.5);
 if mode == 1;
    BW = imbinarize(BW);
   %for area change tracking
elseif mode == 2;
    %for position tracking
       BW = imbinarize(BW);
       if (mean2(BW)>=0.5)
            BW = imcomplement(BW);
       end
 end
    BW = bwareaopen(BW,filiterSize);
end