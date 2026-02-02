function [g1, T_order, T] = dynamic_g1(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T_order, T)
if nargin < 9
    T_order = -1;
    T = NaN(2, 1);
end
[T_order, T] = Perturbation_homework_sv.sparse.dynamic_g1_tt(y, x, params, steady_state, T_order, T);
g1_v = NaN(15, 1);
g1_v(1)=(-(exp(y(7))*getPowerDeriv(y(2),params(3),1)));
g1_v(2)=(-params(2));
g1_v(3)=(-params(2));
g1_v(4)=(-1)/(y(5)*y(5));
g1_v(5)=1;
g1_v(6)=(-(params(1)*1/y(9)*params(3)*exp(y(11))*getPowerDeriv(y(6),params(3)-1,1)));
g1_v(7)=1;
g1_v(8)=(-T(2));
g1_v(9)=1;
g1_v(10)=(-(exp(y(8))*x(1)));
g1_v(11)=1;
g1_v(12)=(-(T(1)*params(1)*(-1)/(y(9)*y(9))));
g1_v(13)=(-(params(1)*1/y(9)*T(1)));
g1_v(14)=(-exp(y(8)));
g1_v(15)=(-params(5));
g1 = sparse(sparse_rowval, sparse_colval, g1_v, 4, 14);
end
