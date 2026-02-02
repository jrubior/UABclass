var c, k, a, sigma;
varexo e, u;

parameters beta, rho, alpha, msigma, eeta;

alpha = 0.4;
beta  = 0.9;
rho   = 0.9;
msigma = log(0.01);
eeta = 1;

model;
1/c=beta*(1/c(+1))*(alpha*exp(a(+1))*k^(alpha-1));
c+k=exp(a)*k(-1)^alpha;
a = rho*a(-1)+ exp(sigma)*e;
sigma = (1-rho)*msigma+rho*sigma(-1)+eeta*u;
end;

initval;
c = 0.80359242014163;
k = 11.08360443260358;
a = 0;
e = 0;
sigma=msigma;
u=0;
end;

shocks;
var e; stderr 1;
var u; stderr 1;
end;


stoch_simul(order=1);