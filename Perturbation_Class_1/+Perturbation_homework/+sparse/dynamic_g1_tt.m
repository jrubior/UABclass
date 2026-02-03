function [T_order, T] = dynamic_g1_tt(y, x, params, steady_state, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = Perturbation_homework.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
T_order = 1;
if size(T, 1) < 6
    T = [T; NaN(6 - size(T, 1), 1)];
end
T(5) = exp(y(6))*getPowerDeriv(y(2),params(3),1);
T(6) = params(3)*exp(y(9))*getPowerDeriv(y(5),params(3)-1,1);
end
