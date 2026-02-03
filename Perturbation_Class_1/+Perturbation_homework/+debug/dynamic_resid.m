function [lhs, rhs] = dynamic_resid(y, x, params, steady_state)
T = NaN(4, 1);
lhs = NaN(3, 1);
rhs = NaN(3, 1);
T(1) = params(1)*1/y(7);
T(2) = params(3)*exp(y(9))*y(5)^(params(3)-1);
T(3) = T(2)+1-params(5);
T(4) = exp(y(6))*y(2)^params(3);
lhs(1) = 1/y(4);
rhs(1) = T(1)*T(3);
lhs(2) = y(4)+y(5);
rhs(2) = T(4)+(1-params(5))*y(2);
lhs(3) = y(6);
rhs(3) = params(2)*y(3)+params(4)*x(1);
end
