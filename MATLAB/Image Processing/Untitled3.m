for count = 1:numFrames,
    % Convert to grayscale.
    fr = regions(:,:,:,count); 
    gfr = rgb2gray(fr);
    gfr = imcomplement(gfr); 
    % Experimentally determine the threshold.
    bw = im2bw(fr, .2);
    bw = imopen(bw, structDisk);
    segPend(:,:,count) = bw;
    imshow(bw)
end