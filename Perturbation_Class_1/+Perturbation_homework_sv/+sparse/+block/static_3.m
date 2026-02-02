function [y, T, residual, g1] = static_3(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
residual=NaN(2, 1);
  T(1)=exp(y(3));
  residual(1)=(y(1)+y(2))-(T(1)*y(2)^params(3));
  T(2)=params(3)*T(1)*y(2)^(params(3)-1);
  residual(2)=(1/y(1))-(1/y(1)*params(1)*T(2));
if nargout > 3
    g1_v = NaN(4, 1);
g1_v(1)=1-T(1)*getPowerDeriv(y(2),params(3),1);
g1_v(2)=(-(1/y(1)*params(1)*params(3)*T(1)*getPowerDeriv(y(2),params(3)-1,1)));
g1_v(3)=1;
g1_v(4)=(-1)/(y(1)*y(1))-T(2)*params(1)*(-1)/(y(1)*y(1));
    g1 = sparse(sparse_rowval, sparse_colval, g1_v, 2, 2);
end
end
