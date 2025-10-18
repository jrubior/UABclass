function [lhs, rhs] = dynamic_resid(y, x, params, steady_state)
T = NaN(3, 1);
lhs = NaN(3, 1);
rhs = NaN(3, 1);
T(1) = exp(y(6))*y(4)^(-params(3));
T(2) = params(2)*exp(y(9))*y(7)^(-params(3))*params(1);
T(3) = y(5)^(params(1)-1);
lhs(1) = T(1);
rhs(1) = T(2)*T(3);
lhs(2) = y(4)+y(5);
rhs(2) = y(2)^params(1);
lhs(3) = y(6);
rhs(3) = params(4)*y(3)+params(5)*x(1);
end
