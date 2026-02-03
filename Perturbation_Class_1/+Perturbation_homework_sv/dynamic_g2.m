function g2 = dynamic_g2(T, y, x, params, steady_state, it_, T_flag)
% function g2 = dynamic_g2(T, y, x, params, steady_state, it_, T_flag)
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
%   g2
%

if T_flag
    T = Perturbation_homework_sv.dynamic_g2_tt(T, y, x, params, steady_state, it_);
end
g2_i = zeros(17,1);
g2_j = zeros(17,1);
g2_v = zeros(17,1);

g2_i(1)=1;
g2_i(2)=1;
g2_i(3)=1;
g2_i(4)=1;
g2_i(5)=1;
g2_i(6)=1;
g2_i(7)=1;
g2_i(8)=1;
g2_i(9)=1;
g2_i(10)=1;
g2_i(11)=2;
g2_i(12)=2;
g2_i(13)=2;
g2_i(14)=2;
g2_i(15)=3;
g2_i(16)=3;
g2_i(17)=3;
g2_j(1)=37;
g2_j(2)=85;
g2_j(3)=82;
g2_j(4)=52;
g2_j(5)=86;
g2_j(6)=96;
g2_j(7)=49;
g2_j(8)=53;
g2_j(9)=93;
g2_j(10)=97;
g2_j(11)=1;
g2_j(12)=6;
g2_j(13)=56;
g2_j(14)=61;
g2_j(15)=73;
g2_j(16)=76;
g2_j(17)=106;
g2_v(1)=(y(4)+y(4))/(y(4)*y(4)*y(4)*y(4));
g2_v(2)=(-(T(1)*params(1)*(y(8)+y(8))/(y(8)*y(8)*y(8)*y(8))));
g2_v(3)=(-(params(1)*(-1)/(y(8)*y(8))*T(4)));
g2_v(4)=g2_v(3);
g2_v(5)=(-(T(1)*params(1)*(-1)/(y(8)*y(8))));
g2_v(6)=g2_v(5);
g2_v(7)=(-(params(1)*1/y(8)*params(3)*exp(y(9))*getPowerDeriv(y(5),params(3)-1,2)));
g2_v(8)=(-(params(1)*1/y(8)*T(4)));
g2_v(9)=g2_v(8);
g2_v(10)=(-(params(1)*1/y(8)*T(1)));
g2_v(11)=(-(exp(y(6))*getPowerDeriv(y(1),params(3),2)));
g2_v(12)=T(3);
g2_v(13)=g2_v(12);
g2_v(14)=(-T(2));
g2_v(15)=(-(exp(y(7))*x(it_, 1)));
g2_v(16)=(-exp(y(7)));
g2_v(17)=g2_v(16);
g2 = sparse(g2_i,g2_j,g2_v,4,121);
end
