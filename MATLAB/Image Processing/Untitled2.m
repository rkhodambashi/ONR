a = imread('circlesBrightDark.png');
          bw = a < 100;
          imshow(bw)
          title('Image with Circles')
  
          stats = regionprops('table',bw,'Centroid', ...
                             'MajorAxisLength','MinorAxisLength');
  
          % Get centers and radii of the circles
          centers = stats.Centroid;
          diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
          radii = diameters/2;
  
          % Plot the circles
          hold on
          viscircles(centers,radii);
          hold off
  
          