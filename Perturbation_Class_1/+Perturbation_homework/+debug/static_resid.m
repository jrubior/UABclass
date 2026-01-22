function [lhs, rhs] = static_resid(y, x, params)
T = NaN(2, 1);
lhs = NaN(3, 1);
rhs = NaN(3, 1);
T(1) = params(3)*exp(y(3))*y(2)^(params(3)-1);
T(2) = exp(y(3))*y(2)^params(3);
lhs(1) = 1/y(1);
rhs(1) = 1/y(1)*params(1)*T(1);
lhs(2) = y(1)+y(2);
rhs(2) = T(2);
lhs(3) = y(3);
rhs(3) = y(3)*params(2)+params(4)*x(1);
end
