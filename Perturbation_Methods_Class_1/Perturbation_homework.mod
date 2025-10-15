var c, k, a;
varexo e;

parameters beta, rho, alpha, sigma;

alpha = 0.4;
beta  = 0.9;
rho   = 0.9;
sigma = 0.01;

model;
1/c=beta*(1/c(+1))*(alpha*exp(a(+1))*k^(alpha-1));
c+k=exp(a)*k(-1)^alpha;
a = rho*a(-1)+ sigma*e;
end;

initval;
c = 0.80359242014163;
k = 11.08360443260358;
a = 0;
e = 0;
end;

shocks;
var e; stderr 1;
end;


stoch_simul(order=1);