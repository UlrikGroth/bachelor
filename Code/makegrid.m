function grid = makegrid(width,height,row,col)
grid= zeros(height*row,width*col);
for k=1:2:col
    grid(:,(k-1)*width+1:(k-1)*width+width)=~grid(:,(k-1)*width+1:(k-1)*width+width);
end

for k=2:2:row
    grid((k-1)*height+1:(k-1)*height+height,:)=~grid((k-1)*height+1:(k-1)*height+height,:);
end
end

