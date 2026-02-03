function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
% function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double   vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double   vector of endogenous variables in the order stored
%                                                     in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double   matrix of exogenous variables (in declaration order)
%                                                     for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double   vector of steady state values
%   params        [M_.param_nbr by 1]        double   vector of parameter values in declaration order
%   it_           scalar                     double   time period for exogenous variables for which
%                                                     to evaluate the model
%   T_flag        boolean                    boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   g1
%

if T_flag
    T = Perturbation_homework_sv.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(4, 11);
g1(1,4)=(-1)/(y(4)*y(4));
g1(1,8)=(-(T(1)*params(1)*(-1)/(y(8)*y(8))));
g1(1,5)=(-(params(1)*1/y(8)*T(4)));
g1(1,9)=(-(params(1)*1/y(8)*T(1)));
g1(2,4)=1;
g1(2,1)=T(3);
g1(2,5)=1;
g1(2,6)=(-T(2));
g1(3,2)=(-params(2));
g1(3,6)=1;
g1(3,7)=(-(exp(y(7))*x(it_, 1)));
g1(3,10)=(-exp(y(7)));
g1(4,3)=(-params(2));
g1(4,7)=1;
g1(4,11)=(-params(5));

end
