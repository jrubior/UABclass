function [residual, T_order, T] = static_resid(y, x, params, T_order, T)
if nargin < 5
    T_order = -1;
    T = NaN(2, 1);
end
[T_order, T] = solvingQ2.sparse.static_resid_tt(y, x, params, T_order, T);
residual = NaN(3, 1);
    residual(1) = (exp(y(3))*T(1)) - (T(1)*exp(y(3))*params(2)*params(1)*T(2));
    residual(2) = (y(1)+y(2)) - (y(2)^params(1));
    residual(3) = (y(3)) - (y(3)*params(4)+params(5)*x(1));
end
