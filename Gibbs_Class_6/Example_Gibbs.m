%% Gibbs Sampling for Bivariate Normal
% X = (X1, X2)' ~ N(mu, Sigma)
clear; clc; close all;

% --- Parameters ---
mu1 = 0; mu2 = 0;          % means
sigma1 = 1; sigma2 = 1;    % standard deviations
rho    = 0.9;              % correlation coefficient
nIter  = 10000;            % number of Gibbs iterations

% --- Derived quantities ---
Sigma = [sigma1^2, rho; rho, sigma2^2];
mu = [mu1; mu2];

% --- Preallocate ---
X = zeros(nIter, 2);

% --- Initialize ---
X(1, :) = [0, 0];

% --- Gibbs Sampling ---
for t = 2:nIter
    % ---- Sample X1 | X2 ----
    mean1 = mu1 + (rho / sigma2^2) * (X(t-1,2) - mu2);
    var1  = sigma1^2 - (rho^2 / sigma2^2);
    X(t,1) = mean1 + sqrt(var1) * randn;
    
    % ---- Sample X2 | X1 ----
    mean2 = mu2 + (rho / sigma1^2) * (X(t,1) - mu1);
    var2  = sigma2^2 - (rho^2 / sigma1^2);
    X(t,2) = mean2 + sqrt(var2) * randn;
end

% --- Plot results ---
figure;
subplot(1,2,1)
plot(X(:,1), X(:,2), '.k', 'MarkerSize', 3)
xlabel('X_1'); ylabel('X_2');
title(['Gibbs samples (\rho = ' num2str(rho) ')'])
axis equal; grid on

subplot(1,2,2)
plot(1:nIter, X(:,1), 'r'); hold on
plot(1:nIter, X(:,2), 'b');
xlabel('Iteration'); ylabel('Value');
legend('X_1','X_2')
title('Trace plots')

% --- Compare with true distribution ---
disp('Sample mean vs true mean:')
disp([mean(X)' mu])
disp('Sample covariance vs true covariance:')
disp([cov(X) Sigma])