function smoth(position2,num)
hold off
x = position2(1,1:num)';
y = position2(2,1:num)';
plot(x,y);
hold on;
x1 = smoothdata(x);
y1 = smoothdata(y);
plot(x1,y1);
end

% pendulum([x1,y1]',800)