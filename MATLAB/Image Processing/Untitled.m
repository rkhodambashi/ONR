% x = pendCenters(:, 1);
% y = pendCenters(:, 2);
imshow(segPend(:,:,2));
hold on
for i = 1:size(segPend,3)
% imshow(segPend(:,:,i));
hold on
plot(pendCenters(i,1),pendCenters(i,2),'or')
 pause(0.001);
end
% set(gca,'Xdir','reverse')
% axis ij;
axis equal;
hold on;
xlabel('x');
ylabel('y');
title('Pendulum Centers');

% A = imread('pout.tif');
% xWorldLimits = [2 5];
% yWorldLimits = [3 6];
% RA = imref2d(size(A),xWorldLimits,yWorldLimits)