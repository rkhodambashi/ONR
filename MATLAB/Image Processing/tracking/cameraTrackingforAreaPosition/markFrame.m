function insertedFrame = markFrame(centroid,bbox,RECT,videoFrame)
        if isempty(centroid)
            insertedFrame = insertShape(videoFrame,'Rectangle',RECT,'Color','red');
        else
        frame1 = insertMarker(videoFrame,centroid);
        frame2 = insertShape(frame1,'Rectangle',bbox);
        insertedFrame = insertShape(frame2,'Rectangle',RECT);
        end
end
