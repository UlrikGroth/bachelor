function out = make_bound(img,framesz,option)
[r,c] = size (img);

switch option
    case 'zero'
% 0 boundary
imgb=zeros(size(img)*3);
imgb(r+1:2*r,c+1:2*c)=img;

case 'periodic'
% Periodic boundary
imgb=[img,img,img;img,img,img;img,img,img];

case 'reflexive'
% Reflexive boundary
imgud=flipud(img);
imglr=fliplr(img);
imgx=flipud(imglr);
imgb=[imgx,imgud,imgx;imglr,img,imglr;imgx,imgud,imgx];

end
out = imgb(r-framesz+1:2*r+framesz,c-framesz+1:2*c+framesz);