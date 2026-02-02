function [y, T, residual, g1] = dynamic_2(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
residual=NaN(2, 1);
  T(2)=exp(y(7));
  residual(1)=(y(5)+y(6))-(T(2)*y(2)^params(3));
  T(3)=params(3)*exp(y(11));
  T(4)=T(3)*y(6)^(params(3)-1);
  residual(2)=(1/y(5))-(params(1)*1/y(9)*T(4));
if nargout > 3
    g1_v = NaN(6, 1);
g1_v(1)=(-(T(2)*getPowerDeriv(y(2),params(3),1)));
g1_v(2)=1;
g1_v(3)=(-(params(1)*1/y(9)*T(3)*getPowerDeriv(y(6),params(3)-1,1)));
g1_v(4)=1;
g1_v(5)=(-1)/(y(5)*y(5));
g1_v(6)=(-(T(4)*params(1)*(-1)/(y(9)*y(9))));
    g1 = sparse(sparse_rowval, sparse_colval, g1_v, 2, 6);
end
end
