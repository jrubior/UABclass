function [g1, T_order, T] = static_g1(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T_order, T)
if nargin < 8
    T_order = -1;
    T = NaN(3, 1);
end
[T_order, T] = solvingQ2.sparse.static_g1_tt(y, x, params, T_order, T);
g1_v = NaN(6, 1);
g1_v(1)=exp(y(3))*T(3)-T(2)*params(1)*exp(y(3))*params(2)*T(3);
g1_v(2)=1;
g1_v(3)=(-(T(1)*exp(y(3))*params(2)*params(1)*getPowerDeriv(y(2),params(1)-1,1)));
g1_v(4)=1-getPowerDeriv(y(2),params(1),1);
g1_v(5)=exp(y(3))*T(1)-T(1)*exp(y(3))*params(2)*params(1)*T(2);
g1_v(6)=1-params(4);
g1 = sparse(sparse_rowval, sparse_colval, g1_v, 3, 3);
end
