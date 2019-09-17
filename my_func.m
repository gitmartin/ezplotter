function [ y ] = my_func( x )
% you can plot functions like this one: f(x) = my_func(x)

y = sin(x) .* (x>0);
y(x<0) = x(x<0).^2;


end

