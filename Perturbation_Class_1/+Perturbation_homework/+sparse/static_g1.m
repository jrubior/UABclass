function [g1, T_order, T] = static_g1(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T_order, T)
if nargin < 8
    T_order = -1;
    T = NaN(3, 1);
end
[T_order, T] = Perturbation_homework.sparse.static_g1_tt(y, x, params, T_order, T);
g1_v = NaN(7, 1);
g1_v(1)=(-1)/(y(1)*y(1))-T(2)*params(1)*(-1)/(y(1)*y(1));
g1_v(2)=1;
g1_v(3)=(-(1/y(1)*params(1)*params(3)*exp(y(3))*getPowerDeriv(y(2),params(3)-1,1)));
g1_v(4)=1-(1-params(5)+exp(y(3))*getPowerDeriv(y(2),params(3),1));
g1_v(5)=(-(1/y(1)*params(1)*T(1)));
g1_v(6)=(-T(3));
g1_v(7)=1-params(2);
g1 = sparse(sparse_rowval, sparse_colval, g1_v, 3, 3);
end
