function  pendulum(position,num)
close all
x = position(1,1:num)';
y = position(2,1:num)';

abc = [x y ones(length(x),1)] \ -(x.^2 + y.^2);
a = abc(1);
b = abc(2);
c = abc(3);
xc = -a/2;
yc = -b/2;
circle_radius = sqrt((xc^2 + yc^2) - c);
pendulum_length = round(circle_radius);
circle_theta = pi/3:0.01:pi*2/3;
x_fit = circle_radius*cos(circle_theta)+xc;
y_fit = circle_radius*sin(circle_theta)+yc;

hold on;
plot(x,y);
plot(x_fit,y_fit,'b-');
plot(xc,yc,'bx','LineWidth',2);
plot([xc x(1)],[yc y(1)],'b-');
text(xc-110,yc+100,sprintf('Pendulum length = %d pixels', pendulum_length));
end

% pendulum(position2,4000)