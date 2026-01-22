function [T_order, T] = static_resid_tt(y, x, params, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 2
    T = [T; NaN(2 - size(T, 1), 1)];
end
T(1) = params(3)*exp(y(3))*y(2)^(params(3)-1);
T(2) = exp(y(3))*y(2)^params(3);
end
