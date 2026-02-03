function [g2_v, T_order, T] = dynamic_g2(y, x, params, steady_state, T_order, T)
if nargin < 6
    T_order = -1;
    T = NaN(6, 1);
end
[T_order, T] = Perturbation_homework.sparse.dynamic_g2_tt(y, x, params, steady_state, T_order, T);
g2_v = NaN(10, 1);
g2_v(1)=(y(4)+y(4))/(y(4)*y(4)*y(4)*y(4));
g2_v(2)=(-(T(3)*params(1)*(y(7)+y(7))/(y(7)*y(7)*y(7)*y(7))));
g2_v(3)=(-(params(1)*(-1)/(y(7)*y(7))*T(6)));
g2_v(4)=(-(T(2)*params(1)*(-1)/(y(7)*y(7))));
g2_v(5)=(-(T(1)*params(3)*exp(y(9))*getPowerDeriv(y(5),params(3)-1,2)));
g2_v(6)=(-(T(1)*T(6)));
g2_v(7)=(-(T(1)*T(2)));
g2_v(8)=(-(exp(y(6))*getPowerDeriv(y(2),params(3),2)));
g2_v(9)=(-T(5));
g2_v(10)=(-T(4));
end
