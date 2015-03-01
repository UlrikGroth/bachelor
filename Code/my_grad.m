function [dx,dy] = my_grad(fun,subx,suby)
  dx = my_diff(fun,subx,suby,'x','regular');
  dy = my_diff(fun,subx,suby,'y','regular');
end