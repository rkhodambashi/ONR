% testData = [positionX;positionY];
angle = zeros(1,171);
count = 1;
while count  < 171
    angle(count) = angleCalculate(RECT, position, testData, counts);
    count = count+1;
end

if count< 171
    testData(1,count)
end