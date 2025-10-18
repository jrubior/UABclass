function [residual, T_order, T] = dynamic_resid(y, x, params, steady_state, T_order, T)
if nargin < 6
    T_order = -1;
    T = NaN(3, 1);
end
[T_order, T] = solvingQ2.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
residual = NaN(3, 1);
    residual(1) = (T(1)) - (T(2)*T(3));
    residual(2) = (y(4)+y(5)) - (y(2)^params(1));
    residual(3) = (y(6)) - (params(4)*y(3)+params(5)*x(1));
end
