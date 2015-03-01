function y = maskify(x,mask)
m=mask(:);
x=x(:);
x(m)=0;

y=x;




%x=double(x);
%m=~mask;
%m=m(:);
%m=diag(m);
%y = m*x(:);


