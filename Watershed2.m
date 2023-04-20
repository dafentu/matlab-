h=fspecial('sobel'); 

g=im2bw(img2,graythresh(img2));
fd=double(g);%doubleÊ¹Êý¾Ý±ä³ÉË«¾«¶È
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
