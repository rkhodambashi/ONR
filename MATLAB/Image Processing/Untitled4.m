for count = 1:numFrames
%     property = regionprops(segPend(:, :, count), 'Centroid');
    stats = regionprops(bw,'Centroid','MajorAxisLength','MinorAxisLength');
%     pendCenters(count,:) = property.Centroid;
    centers = stats.Centroid;
    diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
    radii = diameters/2;
    hold on
    viscircles(centers,radii);
%     pause(0.001);
end
