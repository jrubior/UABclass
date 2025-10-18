function [y, T, residual, g1] = static_2(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
residual=NaN(2, 1);
  residual(1)=(y(1)+y(2))-(y(2)^params(1));
  T(1)=exp(y(3));
  T(2)=y(1)^(-params(3));
  T(3)=y(2)^(params(1)-1);
  residual(2)=(T(1)*T(2))-(T(2)*T(1)*params(2)*params(1)*T(3));
  T(4)=getPowerDeriv(y(1),(-params(3)),1);
if nargout > 3
    g1_v = NaN(4, 1);
g1_v(1)=1;
g1_v(2)=T(1)*T(4)-T(3)*params(1)*T(1)*params(2)*T(4);
g1_v(3)=1-getPowerDeriv(y(2),params(1),1);
g1_v(4)=(-(T(2)*T(1)*params(2)*params(1)*getPowerDeriv(y(2),params(1)-1,1)));
    g1 = sparse(sparse_rowval, sparse_colval, g1_v, 2, 2);
end
end
