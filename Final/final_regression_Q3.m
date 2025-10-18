%% ============================================================
% Likelihood-only Gibbs sampler for Normal(mu, sigma^2)
% ------------------------------------------------------------
% Model:
%   x_i ~ N(mu, sigma^2)
%   tau = 1/sigma^2
%
% Likelihood factorization:
%   L(x; mu, tau) ∝ tau^(n/2) * exp(-tau/2 [ n(mu-xbar)^2 + S ])
%
% Gibbs sampler (collapsed in mu):
%   1) tau ~ Ga( (n+1)/2 ,  rate = S/2 )
%   2) mu  ~ N( xbar , var = 1/(tau*n) )
%
% Tasks:
%   - Simulate data with mu*=1, sigma*=2, n=200
%   - Run Gibbs sampler and compare posterior draws with true values
% ============================================================
clear; clc; rng(1);

%% --- Step 1: Simulate data ---
n = 200;
mu_true = 1.0;
sigma_true = 2.0;
tau_true = 1 / sigma_true^2;

x = mu_true + sigma_true * randn(n,1);
xbar = mean(x);
S = sum((x - xbar).^2);

fprintf('Data summary: n=%d, xbar=%.3f, S=%.3f\n', n, xbar, S);

%% --- Step 2: Gibbs sampler parameters ---
M = 12000;      % total iterations
burn = 2000;    % burn-in
mu  = zeros(M,1);
tau = zeros(M,1);

% Initialize
tau(1) = 1 / var(x);
mu(1)  = xbar;

%% --- Step 3: Gibbs sampling ---
for m = 2:M
    % 1) Draw tau | x  ~ Ga(a=(n+1)/2, rate=b=S/2)
    a = (n + 1)/2;
    b = S/2;
    tau(m) = gamrnd(a, 1/b);   % MATLAB: scale = 1/rate

    % 2) Draw mu | tau, x ~ N(xbar, var = 1/(tau*n))
    mu(m) = xbar + sqrt(1/(tau(m)*n)) * randn;
end

%% --- Step 4: Drop burn-in and compute draws for sigma ---
mu_draws = mu(burn+1:end);
tau_draws = tau(burn+1:end);
sigma_draws = 1 ./ sqrt(tau_draws);

%% --- Step 5: Report posterior means ---
fprintf('\nPosterior means (after burn-in):\n');
fprintf('  E[mu|x]     = %.3f (true = %.3f)\n', mean(mu_draws), mu_true);
fprintf('  E[sigma|x]  = %.3f (true = %.3f)\n', mean(sigma_draws), sigma_true);

%% --- Step 6: Plot histograms ---
figure('Name','Posterior Draws','NumberTitle','off');

subplot(1,2,1);
histogram(mu_draws,40,'Normalization','pdf');
xline(mu_true,'r--','LineWidth',2);
title('\mu draws'); xlabel('\mu'); ylabel('Density');

subplot(1,2,2);
histogram(sigma_draws,40,'Normalization','pdf');
xline(sigma_true,'r--','LineWidth',2);
title('\sigma draws'); xlabel('\sigma'); ylabel('Density');

sgtitle('Likelihood-only Gibbs Sampler (Normal Model)');