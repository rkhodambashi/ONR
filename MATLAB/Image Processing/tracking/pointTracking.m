function[stats,BW]= pointTracking(frame,RECT,filiterSize)
    region = imcrop(frame, floor(RECT));
%     region = frame;
%     region =  findPurple(region);
    BW  =  filiter(region,filiterSize);
    stats = regionprops('table',BW,'Area','Centroid','BoundingBox');
%     hold off
end

function [BW]  =  filiter(region,filiterSize)
    BW = rgb2gray(region);

%     BW = imsharpen(BW,'Amount',1.5);
    BW = imbinarize(BW);
    if (mean2(BW)>=0.5)
        BW = imcomplement(BW);
    end
    BW = bwareaopen(BW,filiterSize);
%     stats = regionprops('table',BW2,'Centroid','BoundingBox','Area');
end