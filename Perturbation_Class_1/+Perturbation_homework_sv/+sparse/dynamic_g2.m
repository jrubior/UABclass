function [g2_v, T_order, T] = dynamic_g2(y, x, params, steady_state, T_order, T)
if nargin < 6
    T_order = -1;
    T = NaN(4, 1);
end
[T_order, T] = Perturbation_homework_sv.sparse.dynamic_g2_tt(y, x, params, steady_state, T_order, T);
g2_v = NaN(12, 1);
g2_v(1)=(y(5)+y(5))/(y(5)*y(5)*y(5)*y(5));
g2_v(2)=(-(T(1)*params(1)*(y(9)+y(9))/(y(9)*y(9)*y(9)*y(9))));
g2_v(3)=(-(params(1)*(-1)/(y(9)*y(9))*T(4)));
g2_v(4)=(-(T(1)*params(1)*(-1)/(y(9)*y(9))));
g2_v(5)=(-(params(1)*1/y(9)*params(3)*exp(y(11))*getPowerDeriv(y(6),params(3)-1,2)));
g2_v(6)=(-(params(1)*1/y(9)*T(4)));
g2_v(7)=(-(params(1)*1/y(9)*T(1)));
g2_v(8)=(-(exp(y(7))*getPowerDeriv(y(2),params(3),2)));
g2_v(9)=T(3);
g2_v(10)=(-T(2));
g2_v(11)=(-(exp(y(8))*x(1)));
g2_v(12)=(-exp(y(8)));
end
