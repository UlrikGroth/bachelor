function []

u_n21   = u_b(frame+1-2:frame+r-2,frame+1:frame+c);
u_n20   = u_b(frame+1-2:frame+r-2,frame+1+1:frame+c+1);
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
u_20    = u_b(frame+1+2:frame+r+2,frame+1:frame+c);
u_21    = u_b(frame+1+2:frame+r+2,frame+1+1:frame+c+1);

u_n2i2  = (u_n20 + u_n21)/2;
u_n1i2  = (u_n10 + u_n11)/2;
u_ni2n2 = (u_n12 + u_02) /2;
u_ni2n1 = (u_n11 + u_01) /2;
u_ni20  = (u_n10 + u_00) /2;
u_ni21  = (u_n11 + u_01) /2;
u_ni22  = (u_n12 + u_02) /2;
u_0i2   = (u_00  + u_10) /2;
u_i2n2  = (u_0n2 + u_1n2)/2;
u_i2n1  = (u_0n1 + u_1n1)/2;
u_i20   = (u_00  + u_10) /2;
u_i21   = (u_01  + u_11) /2;
u_i22   = (u_02  + u_12) /2;
u_1i2   = (u_10  + u_11) /2;
u_2i2   = (u_20  + u_21) /2;

u_x_00  = (u_10 - u_n10)/(2*h);
u_x_n10 = (u_00 - u_n20)/(2*h);
u_x_01  = (u_11 - u_n11)/(2*h);
u_x_10  = (u_20 - u_00) /(2*h);

u_y_n10 = (u_n11- u_n1n1)/(2*h);
u_y_00  = (u_01 - u_0n1) /(2*h);
u_y_01  = (u_02 - u_00)  /(2*h);
u_y_10  = (u_11 - u_1n1) /(2*h);

u_x_n1i2  = (u_0i2 - u_n2i2)/(2*h);
u_x_ni2n1 = (u_0n1 - u_n1n1)/(h);
u_x_ni20  = (u_00  - u_n10) /(h);
u_x_ni21  = (u_01  - u_n11) /(h);
u_x_0ni2  = (u_1i2 - u_n1i2)/(2*h);
u_x_0i2   = (u_1i2 - u_n1i2)/(2*h);
u_x_i2n1  = (u_1n1 - u_0n1) /(h);
u_x_i20   = (u_10  - u_00)  /(h);
u_x_i21   = (u_11  - u_01)  /(h);
u_x_1i2   = (u_2i2 - u_0i2) /(2*h);

u_y_n1i2  = (u_n11  - u_n10)  /(h);
u_y_ni2n1 = (u_ni20 - u_ni2n2)/(2*h);
u_y_ni20  = (u_ni21 - u_ni2n1)/(2*h);
u_y_ni21  = (u_ni22 - u_ni20) /(2*h);
u_y_0ni2  = (u_00   - u_0n1)  /(h);
u_y_0i2   = (u_01   - u_00)   /(h);
u_y_i2n1  = (u_i20  - u_i2n2) /(2*h);
u_y_i20   = (u_i21  - u_i2n1) /(2*h);
u_y_i21   = (u_i22  - u_i20)  /(2*h);
u_y_1i2   = (u_10   - u_11)   /(h);

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
            -u_y_n10./(real((u_x_n10.^2+u_y_n10.^2).^(1/2))+epsilon)/h)...
           +(u_x_ni21./(real((u_x_ni21.^2+u_y_ni21.^2).^(1/2))+epsilon)...
            -u_x_ni2n1./(real((u_x_ni2n1.^2+u_y_ni2n1.^2).^(1/2))+epsilon)/(2*h));        
             
j_i20_1  = -g(abs(kappa_i20),p).*u_x_i20./(real((u_x_i20.^2+u_y_i20.^2).^(1/2))+epsilon);       
j_ni20_1 = -g(abs(kappa_ni20),p).*u_x_ni20./(real((u_x_ni20.^2+u_y_ni20.^2).^(1/2))+epsilon);
j_0i2_2  = -g(abs(kappa_0i2),p).*u_y_0i2./(real((u_x_0i2.^2+u_y_0i2.^2).^(1/2))+epsilon);   
j_0ni2_2 = -g(abs(kappa_0ni2),p).*u_y_0ni2./(real((u_x_0ni2.^2+u_y_0ni2.^2).^(1/2))+epsilon);

nabla_j = (j_i20_1-j_ni20_1)/h+(j_0i2_2-j_0ni2_2)/h;