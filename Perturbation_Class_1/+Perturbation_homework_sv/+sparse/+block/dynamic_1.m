function [y, T] = dynamic_1(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(8)=(1-params(2))*params(4)+params(2)*y(4)+params(5)*x(2);
  T(1)=exp(y(8))*x(1);
  y(7)=params(2)*y(3)+T(1);
end
