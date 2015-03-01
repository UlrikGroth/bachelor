function op = smooth_mult(z, beta)
%SMOOTH_MULT   Multiplicative model function generation.
%   FUNC = SMOOTH_MULT(z) returns a function handle that implements
%
%        FUNC(X) = sum(x) + z'*exp(-x)
%
%   where z is a strictly positive vector.
%
%   FUNC = SMOOTH_MULT(z, beta) returns a function handle that implements 
%
%        FUNC(X) = beta*(sum(x) + z'*exp(-x))
%
%   where z is a strictly positive vector.

if any(z <= 0)
    error('z must be a positive vector');
end
    
if nargin == 1
    beta = 1.0;
end

op = @smooth_mult_z;

function [v, grad] = smooth_mult_z(x, varargin)
    
    if nargin > 1
        error( 'Proximity minimization not supported by this function.' );
    end
    
    % compute function value
    zex = z.*exp(-x);
    v = beta*(sum(x) + sum(zex));
    
    if nargout == 2
        % compute gradient
        grad = beta*(ones(size(x)) - zex); 
    end
end
end