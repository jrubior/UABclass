function [lhs, rhs] = dynamic_resid(y, x, params, steady_state)
T = NaN(2, 1);
lhs = NaN(4, 1);
rhs = NaN(4, 1);
T(1) = params(3)*exp(y(11))*y(6)^(params(3)-1);
T(2) = exp(y(7))*y(2)^params(3);
lhs(1) = 1/y(5);
rhs(1) = params(1)*1/y(9)*T(1);
lhs(2) = y(5)+y(6);
rhs(2) = T(2);
lhs(3) = y(7);
rhs(3) = params(2)*y(3)+exp(y(8))*x(1);
lhs(4) = y(8);
rhs(4) = (1-params(2))*params(4)+params(2)*y(4)+params(5)*x(2);
end
