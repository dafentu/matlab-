w = fspecial('average',5);
fa = imfilter(img2,w,'replicate');
T = graythresh(fa);
img2 =im2bw(fa,T);
