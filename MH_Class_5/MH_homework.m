%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solution: Metropolis-Hastings Sampling from a Bivariate Normal
% -------------------------------------------------------------------------
% Target distribution:
%     x = (x1, x2)' ~ N(mu, Sigma)
%
% Parameters:
%     mu    = [0; 1]
%     Sigma = [1 0.8; 0.8 1]
%
% Prior:
%     Flat over symmetric positive definite (SPD) matrices.
%
% Objective:
%     Use MH to generate draws from the target and compare sample moments.
%
% Author: Juan F. Rubio-Ramírez
% Institution: Emory University
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc; rng(1);

%% 1. Parameters of the target distribution
mu = [0; 1];
Sigma = [1 0.8; 0.8 1];
invSigma = inv(Sigma);

%% 2. Define log target density (up to constant)
logf = @(x) -0.5 * (x - mu)' * invSigma * (x - mu);

%% 3. MH tuning parameters
N = 10000;           % number of draws
c = 0.5;             % proposal std deviation (controls step size)
x = zeros(2, N);     % store draws
x(:,1) = [2; -2];    % initial value (arbitrary)

accept = 0;          % acceptance counter

%% 4. Metropolis–Hastings algorithm
for t = 2:N
    % Step 1: Propose new point from N(x_{t-1}, c^2 I_2)
    x_star = x(:,t-1) + c * randn(2,1);

    % Step 2: Compute acceptance probability
    log_alpha = logf(x_star) - logf(x(:,t-1));
    alpha = min(1, exp(log_alpha));

    % Step 3: Draw uniform random number
    u = rand;

    % Step 4: Accept or reject
    if u <= alpha
        x(:,t) = x_star;
        accept = accept + 1;
    else
        x(:,t) = x(:,t-1);
    end
end

accept_rate = accept / (N-1);
fprintf('Acceptance rate: %.2f%%\n', 100 * accept_rate);

%% 5. Discard burn-in and compute summaries
burn = 2000;
X_post = x(:, burn+1:end)';

mean_est = mean(X_post)';
cov_est  = cov(X_post);

fprintf('\nEmpirical mean:\n');
disp(mean_est);

fprintf('Empirical covariance:\n');
disp(cov_est);

fprintf('True mean:\n');
disp(mu);

fprintf('True covariance:\n');
disp(Sigma);

%% 6. Diagnostic plots

figure('Name','Trace plots of MH draws','Position',[100 100 800 500]);
subplot(2,1,1);
plot(X_post(:,1)); title('Trace of x_1');
xlabel('Iteration'); ylabel('x_1');
subplot(2,1,2);
plot(X_post(:,2)); title('Trace of x_2');
xlabel('Iteration'); ylabel('x_2');

figure('Name','Marginal histograms','Position',[100 100 800 400]);
subplot(1,2,1);
histogram(X_post(:,1),40,'Normalization','pdf'); hold on;
fplot(@(z) normpdf(z, mu(1), sqrt(Sigma(1,1))), [-4,4], 'r', 'LineWidth', 1.2);
title('Marginal of x_1'); legend('MH draws','True N(0,1)');
subplot(1,2,2);
histogram(X_post(:,2),40,'Normalization','pdf'); hold on;
fplot(@(z) normpdf(z, mu(2), sqrt(Sigma(2,2))), [-2,6], 'r', 'LineWidth', 1.2);
title('Marginal of x_2'); legend('MH draws','True N(1,1)');

figure('Name','Joint Distribution','Position',[100 100 500 500]);
scatter(X_post(:,1), X_post(:,2), 10, '.');
xlabel('x_1'); ylabel('x_2'); title('Joint MH draws from N(mu, Sigma)');
axis equal; grid on;

%% 7. Optional: Experiment with different c values
% Try c = 0.1, 0.5, 1, 2 to see effect on acceptance and mixing.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%