function out = my_divergence(fun1,fun2,subx,suby,specify)
  out = my_diff(fun1,subx,suby,'x',specify)+my_diff(fun2,subx,suby,'y',specify);
end