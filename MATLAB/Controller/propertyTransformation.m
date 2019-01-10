% function [centroid,bbox,area] = propertyTransformation(stats,RECT)
function [position,count] = propertyTransformation(stats,RECT,count,num)

if (size(stats,1)== num)
        Centroid(:,1) = RECT(1) + stats.Centroid(:,1);
        Centroid(:,2) = RECT(2) + stats.Centroid(:,2);
        
        boundingBoxSize = size(stats.BoundingBox);
        Bbox = [RECT(1)+stats.BoundingBox(:,1),RECT(2)+stats.BoundingBox(:,2),stats.BoundingBox(:,boundingBoxSize(2)/2+1),stats.BoundingBox(:,boundingBoxSize(2)/2+2)];
        
        Area = stats.Area;
        Status = ones(size(Area));
        Time =toc*Status;
        FrameNo = count*Status;
		else
			Centroid = 0;
			Bbox =0;
			Area = 0;
			Status = 0;
			Time = toc;
			FrameNo = count;
end
    position = table(Time,Area,Status,Centroid,Bbox,FrameNo);
    count = count+1;
end