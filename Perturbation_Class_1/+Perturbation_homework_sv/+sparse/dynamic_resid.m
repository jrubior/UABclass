function [residual, T_order, T] = dynamic_resid(y, x, params, steady_state, T_order, T)
if nargin < 6
    T_order = -1;
    T = NaN(2, 1);
end
[T_order, T] = Perturbation_homework_sv.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
residual = NaN(4, 1);
    residual(1) = (1/y(5)) - (params(1)*1/y(9)*T(1));
    residual(2) = (y(5)+y(6)) - (T(2));
    residual(3) = (y(7)) - (params(2)*y(3)+exp(y(8))*x(1));
    residual(4) = (y(8)) - ((1-params(2))*params(4)+params(2)*y(4)+params(5)*x(2));
end
