function [residual, T_order, T] = static_resid(y, x, params, T_order, T)
if nargin < 5
    T_order = -1;
    T = NaN(2, 1);
end
[T_order, T] = Perturbation_homework_sv.sparse.static_resid_tt(y, x, params, T_order, T);
residual = NaN(4, 1);
    residual(1) = (1/y(1)) - (1/y(1)*params(1)*T(1));
    residual(2) = (y(1)+y(2)) - (T(2));
    residual(3) = (y(3)) - (y(3)*params(2)+exp(y(4))*x(1));
    residual(4) = (y(4)) - ((1-params(2))*params(4)+params(2)*y(4)+params(5)*x(2));
end
