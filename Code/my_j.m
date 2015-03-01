function [j1,j2] = my_j(fun,subx,suby,p)
fun_x     = @(subx,suby) my_diff(@(subx,suby) fun(subx,suby),subx,suby,'x','regular');
fun_y     = @(subx,suby) my_diff(@(subx,suby) fun(subx,suby),subx,suby,'y','regular');
abs_grad  = @(subx,suby) sqrt(fun_x(subx,suby).^2+fun_y(subx,suby).^2)+0.0001;
curv      = @(subx,suby) curvature(@(subx,suby) fun(subx,suby),subx,suby);

j1  = ((-abs(curv(subx,suby))).^p)./abs_grad(subx,suby).*fun_x(subx,suby);
j2  = ((-abs(curv(subx,suby))).^p)./abs_grad(subx,suby).*fun_y(subx,suby);
end