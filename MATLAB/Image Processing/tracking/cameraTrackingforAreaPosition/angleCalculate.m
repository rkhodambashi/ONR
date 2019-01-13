function[angle] = angleCalculate(RECT, position, positionData, count)
%     originPoint = [RECT(1),RECT(1)+RECT(4)];
if position.Status == 1
    if count == 1
    l0 = positionData(1,1);
    elseif count == 2
        l0 = positionData(1,2);
    else
        l0 = positionData(1,2);
    end
    l1 = positionData(1,count);
    x = l1 - l0;
    y = positionData(2,count)-RECT(2)-30;
%     r2 = position.Centroid(1) - RECT(3);
    angle = atan2(y,x);
    angle = rad2deg(angle);
else
    angle = 0;
end
end