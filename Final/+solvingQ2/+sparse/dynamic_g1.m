function [g1, T_order, T] = dynamic_g1(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T_order, T)
if nargin < 9
    T_order = -1;
    T = NaN(3, 1);
end
[T_order, T] = solvingQ2.sparse.dynamic_g1_tt(y, x, params, steady_state, T_order, T);
g1_v = NaN(11, 1);
g1_v(1)=(-(getPowerDeriv(y(2),params(1),1)));
g1_v(2)=(-params(4));
g1_v(3)=exp(y(6))*getPowerDeriv(y(4),(-params(3)),1);
g1_v(4)=1;
g1_v(5)=(-(T(2)*getPowerDeriv(y(5),params(1)-1,1)));
g1_v(6)=1;
g1_v(7)=T(1);
g1_v(8)=1;
g1_v(9)=(-(T(3)*params(1)*params(2)*exp(y(9))*getPowerDeriv(y(7),(-params(3)),1)));
g1_v(10)=(-(T(2)*T(3)));
g1_v(11)=(-params(5));
g1 = sparse(sparse_rowval, sparse_colval, g1_v, 3, 10);
end
