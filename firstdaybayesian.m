clc
close all
clear
clc

%% theta=Normal(173,25)

%% Probabilty theta > 185

1-normcdf(185,173,25);

%% Drawing

nn=1000000;
thetaSamples = normrnd(173, 25, [nn, 1]);
sum((thetaSamples>185)/nn);


%% theta is t-5

1-tcdf(1,5);

%% Important Sampling

nn=10000000;
Samples = normrnd(0, 1, [nn, 1]);

ratio=tpdf(Samples,5)./normpdf(Samples,0,1);

sum((Samples>1).*ratio/nn);

%% theta is gamma(1,1)

a=1;
b=1;
1-gamcdf(1,a,b)

%% Important Sampling

nn=10000000;
Samples = normrnd(0, 1, [nn, 1]);

ratio=gampdf(Samples,a,b)./normpdf(Samples,0,1);

sum((Samples>1).*ratio/nn)


