%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Metropolis-Hastings Approximation to Φ(t)
% ------------------------------------------
% This script uses the MH algorithm to generate draws from N(0,1)
% and then approximates Φ(t) = P(X < t).
%
% Author: Juan F. Rubio-Ramírez
% Institution: Emory University
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc; 

%% Parameters
N     = 10000;          % Number of MH iterations
sigma = sqrt(2.5);      % Proposal standard deviation
x     = zeros(N,1);     % Chain of draws
x(1)  = 0;              % Initial value
t     = 1.5;            % Value at which to approximate Φ(t)

%% Metropolis–Hastings Sampling
for j = 2:N
    % Step 2: Propose candidate from Normal(x_{j-1}, sigma^2)
    x_star = x(j-1) + sigma*randn;
    
    % Step 3: Compute acceptance probability
    phi_ratio = normpdf(x_star)/normpdf(x(j-1)); % φ(x*)/φ(x_{j-1})
    alpha = min(1, phi_ratio);
    
    % Step 4: Draw u ~ U(0,1)
    u = rand;
    
    % Step 5: Accept or reject
    if u <= alpha
        x(j) = x_star;
    else
        x(j) = x(j-1);
    end
end

%% Estimate Φ(t)
Phi_hat = mean(x < t);
fprintf('Approximation of Φ(%.2f): %.4f\n', t, Phi_hat);
fprintf('True value Φ(%.2f): %.4f\n', t, normcdf(t));

%% Optional: Diagnostic plot
figure;
subplot(2,1,1);
plot(x);
title('Metropolis–Hastings Draws from N(0,1)');
xlabel('Iteration'); ylabel('x_j');

subplot(2,1,2);
histogram(x,50,'Normalization','pdf');
hold on;
fplot(@(z) normpdf(z), [-4,4], 'r','LineWidth',1.2);
title('Histogram of MH draws vs N(0,1)');
legend('MH draws','True N(0,1)');