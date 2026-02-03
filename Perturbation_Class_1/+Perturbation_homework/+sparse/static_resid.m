function [residual, T_order, T] = static_resid(y, x, params, T_order, T)
if nargin < 5
    T_order = -1;
    T = NaN(3, 1);
end
[T_order, T] = Perturbation_homework.sparse.static_resid_tt(y, x, params, T_order, T);
residual = NaN(3, 1);
    residual(1) = (1/y(1)) - (1/y(1)*params(1)*T(2));
    residual(2) = (y(1)+y(2)) - (T(3)+y(2)*(1-params(5)));
    residual(3) = (y(3)) - (y(3)*params(2)+params(4)*x(1));
end
