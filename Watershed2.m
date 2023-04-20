h=fspecial('sobel'); %h = fspecial(type) creates a two-dimensional filter h of the specified type. fspecial returns h as
%a correlation kernel, which is the appropriate form to use with imfilter. type is a string having one of these values. 
g=im2bw(img2,graythresh(img2));
fd=double(g);%double使数据变成双精度
g=sqrt(imfilter(fd,h,'replicate').^2+imfilter(fd,h','replicate').^2);
g2=imclose(imopen(g,ones(3,3)),ones(3,3));
im=imextendedmin(g2,2);
Lim=watershed(bwdist(im));
em=Lim==0;
g3=imimposemin(g2,im|em);
g4=watershed(g3);
g5=g;  
g5(g4==0)=255;
img2=g5;