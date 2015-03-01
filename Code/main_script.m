clc
clear
close all 
%%
load('Images')
load('Masks')

%% Week1
width  = 0.1;
height = 0.09;
e      = 100;
img    = make_shape(100,100,@(x,y) 1/(width^2)*x.^2-1);
msk    = make_shape(100,100,@(x,y) -(1/(width+0.1)*x).^e-...
         (1/height*y).^e+1);
     
img    = uint8(img)*255;     
     
dmsk   = masking(img,msk,'random');

     
     colormap(gray)
     figure(1)
     imagesc(img)
     axis off
     axis square
    
     colormap(gray)
     figure(2)
     imagesc(msk)
     axis off
     axis square
     
     colormap(gray)
     figure(3)
     imagesc(dmsk)
     axis off
     axis square
     colormap(gray)

     
%% L2 - Total Variation

close all

y=double(img);
m=msk;
ym=y;
ym(m)=0;
[r,c] = size(y);

lambda=0.1;
lambdas=linspace(0.00001,10,10);
epsilon = 0.01;
Id_op = linop_handles([r*c,r*c], @(x)maskify(x,m), @(x)maskify(x,m), 'R2R');

W = linop_TV([r,c],'regular');
smoothF     = {smooth_quad(1), smooth_huber_modmod(epsilon,lambda)};
affineF     = {Id_op, -ym(:);W, 0};
projectorF  = proj_Rplus;
u0          = {double(dmsk(:))};
opts        = tfocs;
opts.maxIts = 10000;
opts.tol    = 1e-9;
imgs=zeros(length(lambdas),r*c);

[IM22L2TV,out,opts] = tfocs(smoothF, affineF, projectorF, u0, opts);

%for i=1:length(lambdas)
%    smoothF     = {smooth_huber_mod(epsilon), smooth_huber_modmod(epsilon,lambdas(i))};
%    [u,out,opts] = tfocs(smoothF, affineF, projectorF, u0, opts);
%    u0          = {u};
%    imgs(i,:)   =u;
%end


imagesc(reshape(IM22L2TV,r,c))
axis off
axis square
colormap(gray)     
%% 
img = Ulrik;
img = rgb2gray(img);
img = double(img)./254;
img = imresize(img,[1000 1000]);


msk = DTU_logo;
msk = rgb2gray(msk);
msk = im2bw(msk,0.9);

[r, c] = size(img);

mask = make_shape(c,r,@(x,y) x.^2+y.^2-1);


img = masking(img,mask,'');

colormap(gray)
figure(1)
imagesc(img);

colormap(gray)
figure(2)
imagesc(mask);
%%
width  = 0.15;
height = 0.3;
e      = 100;
img    = make_shape(100,100,@(x,y) 1/(width^2)*y.^2-1);
%img    = make_shape(100,100,@(x,y) (x.^2+y.^2-0.8^2).*(x.^2+y.^2-0.6^2));
msk    = make_shape(100,100,@(x,y) -(1/0.3*x).^e-...
         (1/height*y).^e+1);
%msk    = make_shape(100,100,@(x,y) -min(abs(x-y),abs(y+x))+0.05);
         
img    = double(img)*255;     
img    = masking(img,msk,'random');

N       = 100;
delta_t = 0.05;
h       = 1;
epsilon =0.01;
p       = 2;

u = img;
frame = 2;

for i=1:1

u_b = make_bound(u,frame,'reflexive');
[r,c] = size(u);

u_n2n1  = u_b(frame+1-2:frame+r-2,frame+1-1:frame+c-1);
u_n21   = u_b(frame+1-2:frame+r-2,frame+1+1:frame+c+1);
u_n20   = u_b(frame+1-2:frame+r-2,frame+1:frame+c);
u_n1n1  = u_b(frame+1-1:frame+r-1,frame+1-1:frame+c-1);
u_n10   = u_b(frame+1-1:frame+r-1,frame+1:frame+c);
u_n11   = u_b(frame+1-1:frame+r-1,frame+1+1:frame+c+1);
u_n12   = u_b(frame+1-1:frame+r-1,frame+1+2:frame+c+2);
u_0n2   = u_b(frame+1:frame+r,frame+1-2:frame+c-2);
u_0n1   = u_b(frame+1:frame+r,frame+1-1:frame+c-1);
u_00    = u_b(frame+1:frame+r,frame+1:frame+c);
u_01    = u_b(frame+1:frame+r,frame+1+1:frame+c+1);
u_02    = u_b(frame+1:frame+r,frame+1+2:frame+c+2);
u_1n2   = u_b(frame+1+1:frame+r+1,frame+1-2:frame+c-2);
u_1n1   = u_b(frame+1+1:frame+r+1,frame+1-1:frame+c-1);
u_10    = u_b(frame+1+1:frame+r+1,frame+1:frame+c);
u_11    = u_b(frame+1+1:frame+r+1,frame+1+1:frame+c+1);
u_12    = u_b(frame+1+1:frame+r+1,frame+1+2:frame+c+2);
u_2n1   = u_b(frame+1+2:frame+r+2,frame+1-1:frame+c-1);
u_20    = u_b(frame+1+2:frame+r+2,frame+1:frame+c);
u_21    = u_b(frame+1+2:frame+r+2,frame+1+1:frame+c+1);

u_n2ni2 = (u_n2n1+ u_n20) /2;
u_n2i2  = (u_n20 + u_n21) /2;
u_n1i2  = (u_n10 + u_n11) /2;
u_ni2n2 = (u_n12 + u_02)  /2;
u_ni2n1 = (u_n1n1 + u_0n1)/2;
u_ni20  = (u_n10 + u_00)  /2;
u_ni21  = (u_n11 + u_01)  /2;
u_ni22  = (u_n12 + u_02)  /2;
u_0ni2  = (u_01  + u_00)  /2;
u_0i2   = (u_00  + u_10)  /2;
u_i2n2  = (u_0n2 + u_1n2) /2;
u_i2n1  = (u_0n1 + u_1n1) /2;
u_i20   = (u_00  + u_10)  /2;
u_i21   = (u_01  + u_11)  /2;
u_i22   = (u_02  + u_12)  /2;
u_1i2   = (u_10  + u_11)  /2;
u_2ni2  = (u_20  + u_2n1) /2;
u_2i2   = (u_20  + u_21)  /2;

u_x_00  = (u_10 - u_n10)/(2*h);
u_x_n10 = (u_00 - u_n20)/(2*h);
u_x_0n1 = (u_1n1- u_n1n1)/(2*h);
u_x_01  = (u_11 - u_n11)/(2*h);
u_x_10  = (u_20 - u_00) /(2*h);


u_y_n10 = (u_n11- u_n1n1)/(2*h);
u_y_0n1 = (u_00 - u_0n2) /(2*h);
u_y_00  = (u_01 - u_0n1) /(2*h);
u_y_01  = (u_02 - u_00)  /(2*h);
u_y_10  = (u_11 - u_1n1) /(2*h);

u_x_n1ni2 = (u_0ni2- u_n2ni2)/(2*h);
u_x_n1i2  = (u_0i2 - u_n2i2)/(2*h);
u_x_ni2n1 = (u_0n1 - u_n1n1)/(h);
u_x_ni20  = (u_00  - u_n10) /(h);
u_x_ni21  = (u_01  - u_n11) /(h);
u_x_0ni2  = (u_1i2 - u_n1i2)/(2*h);
u_x_0i2   = (u_1i2 - u_n1i2)/(2*h);
u_x_i2n1  = (u_1n1 - u_0n1) /(h);
u_x_i20   = (u_10  - u_00)  /(h);
u_x_i21   = (u_11  - u_01)  /(h);
u_x_1ni2  = (u_2ni2-u_0ni2) /(2*h);
u_x_1i2   = (u_2i2 - u_0i2) /(2*h);

u_y_n1ni2 = (u_n10  - u_n1n1)  /(h);
u_y_n1i2  = (u_n11  - u_n10)  /(h);
u_y_ni2n1 = (u_ni20 - u_ni2n2)/(2*h);
u_y_ni20  = (u_ni21 - u_ni2n1)/(2*h);
u_y_ni21  = (u_ni22 - u_ni20) /(2*h);
u_y_0ni2  = (u_00   - u_0n1)  /(h);
u_y_0i2   = (u_01   - u_00)   /(h);
u_y_i2n1  = (u_i20  - u_i2n2) /(2*h);
u_y_i20   = (u_i21  - u_i2n1) /(2*h);
u_y_i21   = (u_i22  - u_i20)  /(2*h);
u_y_1ni2  = (u_10   - u_1n1)  /(h);
u_y_1i2   = (u_11   - u_10)   /(h);


kappa_i20 = (u_x_10./(real((u_x_10.^2+u_y_10.^2).^(1/2))+epsilon)...
            -u_x_00./(real((u_x_00.^2+u_y_00.^2).^(1/2))+epsilon)/h)...
           +(u_y_i21./(real((u_x_i21.^2+u_y_i21.^2).^(1/2))+epsilon)...
            -u_y_i2n1./(real((u_x_i2n1.^2+u_y_i2n1.^2).^(1/2))+epsilon)/(2*h));
        
kappa_ni20 = (u_x_00./(real((u_x_00.^2+u_y_00.^2).^(1/2))+epsilon)...
            -u_x_n10./(real((u_x_n10.^2+u_y_n10.^2).^(1/2))+epsilon)/h)...
           +(u_y_ni21./(real((u_x_ni21.^2+u_y_ni21.^2).^(1/2))+epsilon)...
            -u_y_ni2n1./(real((u_x_ni2n1.^2+u_y_ni2n1.^2).^(1/2))+epsilon)/(2*h));

kappa_0i2 = (u_y_01./(real((u_x_01.^2+u_y_01.^2).^(1/2))+epsilon)...
            -u_y_00./(real((u_x_00.^2+u_y_00.^2).^(1/2))+epsilon)/h)...
           +(u_x_1i2./(real((u_x_1i2.^2+u_y_1i2.^2).^(1/2))+epsilon)...
            -u_x_n1i2./(real((u_x_n1i2.^2+u_y_n1i2.^2).^(1/2))+epsilon)/(2*h));
        
kappa_0ni2 = (u_y_00./(real((u_x_00.^2+u_y_00.^2).^(1/2))+epsilon)...
            -u_y_0n1./(real((u_x_0n1.^2+u_y_0n1.^2).^(1/2))+epsilon)/h)...
           +(u_x_1ni2./(real((u_x_1ni2.^2+u_y_1ni2.^2).^(1/2))+epsilon)...
            -u_x_n1ni2./(real((u_x_n1ni2.^2+u_y_n1ni2.^2).^(1/2))+epsilon)/(2*h));        
         
j_i20_1  = -g(abs(kappa_i20),p).*u_x_i20./(real((u_x_i20.^2+u_y_i20.^2).^(1/2))+epsilon);       
j_ni20_1 = -g(abs(kappa_ni20),p).*u_x_ni20./(real((u_x_ni20.^2+u_y_ni20.^2).^(1/2))+epsilon);
j_0i2_2  = -g(abs(kappa_0i2),p).*u_y_0i2./(real((u_x_0i2.^2+u_y_0i2.^2).^(1/2))+epsilon);   
j_0ni2_2 = -g(abs(kappa_0ni2),p).*u_y_0ni2./(real((u_x_0ni2.^2+u_y_0ni2.^2).^(1/2))+epsilon);

nabla_j = (j_i20_1-j_ni20_1)/h+(j_0i2_2-j_0ni2_2)/h;

u = u-delta_t*nabla_j;
u(~msk)=img(~msk);
end
 
imagesc(u)

%%
img    = make_shape(100,100,@(x,y) -abs(y)+0.1);
msk    = make_shape(100,100,@(x,y) -max(abs(x),abs(y))+0.3);
img    = double(img)*255;     
img    = masking(img,msk,'random');


N       = 1000;
delta_t = 0.05;
h       = 1;
epsilon =0.0001;
p       = 1;
bc      = 'reflexive';
g     = @(x) abs(x).^p;
u = img;

for i=1:N
    [j1,j2] = my_j(u,0,0,bc,g(curvature(u,0,0,bc,epsilon)),epsilon);      
    u = u-delta_t*my_divergence(j1,j2,0,0,bc,'halfpoint');
    u(~msk)=img(~msk); 
end




