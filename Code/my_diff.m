function out = my_diff(fun,subx,suby,direction,specify)
% Differentiates the function u of x or y using central difference methods.
% subx and suby determines the stencils.
% direction determines the differentiation variable.
% bc determines boundary conditions - see make_bound.m
% specify changes the


switch direction
    case 'x'
        switch specify
            case 'halfpoint'
                out = (fun(subx+1/2,suby)...
                      -fun(subx-1/2,suby));
            case 'regular'   
                if round(subx) == subx
                    out = (fun(subx+1,suby)...
                          -fun(subx-1,suby))/2;
                else
                    out = (fun(ceil(subx),suby)...
                          -fun(floor(subx),suby));
                end
        end
        
    case 'y'
        switch specify
            case 'halfpoint'
                out = (fun(subx,suby+1/2)...
                      -fun(subx,suby-1/2));
            case 'regular'
                if round(suby) == suby
                    out = (fun(subx,suby+1)...
                          -fun(subx,suby-1))/2;
                else
                    out = (fun(subx,ceil(suby))...
                          -fun(subx,floor(suby)));
                end
        end
        
end        
end

