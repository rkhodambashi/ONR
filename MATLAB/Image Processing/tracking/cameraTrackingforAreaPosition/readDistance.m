function k =  readDistance
h = imdistline;
fcn = makeConstrainToRectFcn('imline', get(gca,'XLim'),get(gca,'YLim'));
setDragConstraintFcn(h,fcn);  
actualDistance_x = input('please enter the actual distance in x direction and press Enter: ');
K_x = actualDistance_x/h.getDistance;
h = imdistline;
fcn = makeConstrainToRectFcn('imline', get(gca,'XLim'),get(gca,'YLim'));
setDragConstraintFcn(h,fcn);  
actualDistance_y = input('please enter the actual distance in y direction and press Enter: ');
K_y = actualDistance_y/h.getDistance;
%k= mm/pixel
% area_pixel = pixel_x * pixel_y
% area=distance_x * distance_y
%distance = pixel *k
%area = x*y*k_x*k_y
% area = k(1)*k(2)
k = [K_x,K_y];
end