function [T_order, T] = dynamic_resid_tt(y, x, params, steady_state, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 3
    T = [T; NaN(3 - size(T, 1), 1)];
end
T(1) = exp(y(6))*y(4)^(-params(3));
T(2) = params(2)*exp(y(9))*y(7)^(-params(3))*params(1);
T(3) = y(5)^(params(1)-1);
end
