% This function 
function out = masking(img,mask,option)
switch option
    case 'invert'
        img(mask) = 255-img(mask);
out = img;
    case 'zero'
        img(mask) = 0;
out = img;
    case 'one'
        img(mask) = 255;
out = img;
    case 'treshold'
        img(mask) =  im2bw(img(mask));
out = img;
 case 'random'
        img(mask) =  rand(numel(img(mask)),1)*255;
out = img;
        
end

