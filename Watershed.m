 g=im2bw(img2,graythresh(img2));
    D=bwdist(g);
    L=watershed(-D);
    w = L == 0;
    img2=(~g) & ~w;