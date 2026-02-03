function [y, T, residual, g1] = dynamic_2(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
residual=NaN(2, 1);
  T(1)=exp(y(6));
  residual(1)=(y(4)+y(5))-(T(1)*y(2)^params(3)+(1-params(5))*y(2));
  T(2)=params(3)*exp(y(9));
  T(3)=T(2)*y(5)^(params(3)-1)+1-params(5);
  residual(2)=(1/y(4))-(params(1)*1/y(7)*T(3));
if nargout > 3
    g1_v = NaN(6, 1);
g1_v(1)=(-(1-params(5)+T(1)*getPowerDeriv(y(2),params(3),1)));
g1_v(2)=1;
g1_v(3)=(-(params(1)*1/y(7)*T(2)*getPowerDeriv(y(5),params(3)-1,1)));
g1_v(4)=1;
g1_v(5)=(-1)/(y(4)*y(4));
g1_v(6)=(-(T(3)*params(1)*(-1)/(y(7)*y(7))));
    g1 = sparse(sparse_rowval, sparse_colval, g1_v, 2, 6);
end
end
