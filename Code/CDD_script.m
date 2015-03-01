%% 
clear
clc
close all

%% CDD
img    = make_shape(100,100,@(x,y) abs(y)-0.1); % Image
msk    = make_shape(100,100,@(x,y) -max(3*abs(x),abs(y))+0.2); % Mask
img    = double(img)*255;     
imgmsk    = masking(img,msk,'random'); % Disturbed Image


N       = 1000;       % Iterations
delta_t = 0.5; 
h       = 1;           % Not used yet
p       = 0.5;
bc      = 'reflexive'; % Type of boundary condition
u = imgmsk;

for i=1:N
    [j1,j2] = my_j(@(subx,suby) stencil(u,subx,suby,bc),0,0,p);         
    u = u-delta_t*my_divergence(@(subx,suby) stencil(j1,subx,suby,bc),@(subx,suby) stencil(j2,subx,suby,'reflexive'),0,0,'halfpoint');
    u(~msk)=img(~msk); 
    
    if rem(i,100) == 0
        disp(i);
    end  
end
image(u)
axis equal