function out = make_shape(row,col,func_handle)
xbound = [-1 1];
ybound = [-1 1];

[x,y] = meshgrid(linspace(xbound(1),xbound(2),row),linspace(ybound(2),ybound(1),col));
z= func_handle(x,y);
Image = im2bw(z,0);

out = Image;
end
