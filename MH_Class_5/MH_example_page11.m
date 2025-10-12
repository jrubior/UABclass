clear; clc; rng(1);

%% 1. True parameters and data generation
T = 200;
phi_true = [1; -0.5];
sigma_true = 1;

y = zeros(T,1);
y(1:2) = [0.5; -0.2];
for t = 3:T
    y(t) = phi_true(1)*y(t-1) + phi_true(2)*y(t-2) + sigma_true*randn;
end

%% 2.1 Triangle inequalities for stationarity
is_stationary_triangle = @(phi) ...
    (abs(phi(2)) < 1) && (phi(1) + phi(2) < 1) && (phi(2) - phi(1) < 1);

%% 2.2 Sigma >0
is_positve = @(sigma) ...
    (sigma>0);

%% 3. Log-likelihood (flat prior on sigma)
loglike = @(phi,sigma) ...
    -(T-2)/2 * log(sigma^2) ...
    - (1/(2*sigma^2))*sum((y(3:T) - [y(2:T-1) y(1:T-2)]*phi).^2);

% Posterior kernel (up to constant)
logpost = @(phi,sigma) loglike(phi,sigma);

%% 4. Initialize MH sampler
Ndraws = 100000;
Phi_draws = zeros(Ndraws,2);
Sigma_draws = zeros(Ndraws,1);

% Starting values (inside stationary region)
phi_curr = [0.8; -0.3];
sigma_curr = 1;
logpost_curr = exp(logpost(phi_curr, sigma_curr));

% Proposal standard deviations
sd_phi = [0.1; 0.1];
sd_sigma = 0.1;

accept = 0;

%% 5. MH sampling loop
for i = 1:Ndraws
    % --- Propose new phi using random walk
    phi_prop = phi_curr + sd_phi.*randn(2,1);

    % --- Propose new sigma (positive)
    sigma_prop = sigma_curr + sd_sigma*randn;


    % --- Compute log posterior
    logpost_prop = exp(logpost(phi_prop, sigma_prop))*is_stationary_triangle(phi_prop)*is_positve(sigma_prop);

    % --- Acceptance probability
    alpha = logpost_prop / logpost_curr;

    % --- Accept/reject
    if rand < alpha
        phi_curr = phi_prop;
        sigma_curr = sigma_prop;
        logpost_curr = logpost_prop;
        accept = accept + 1;
    end

    % --- Store draw
    Phi_draws(i,:) = phi_curr';
    Sigma_draws(i) = sigma_curr;
end

accept_rate = accept/Ndraws;
fprintf('Acceptance rate: %.2f%%\n', 100*accept_rate);

%% 6. Posterior summaries
burn = 5000;
Phi_post = Phi_draws(burn+1:end,:);
Sigma_post = Sigma_draws(burn+1:end);

fprintf('\nPosterior means:\n');
fprintf('phi1: %.3f  (true %.2f)\n', mean(Phi_post(:,1)), phi_true(1));
fprintf('phi2: %.3f  (true %.2f)\n', mean(Phi_post(:,2)), phi_true(2));
fprintf('sigma: %.3f  (true %.2f)\n', mean(Sigma_post), sigma_true);

%% 7. Diagnostic plots
figure('Name','Posterior Trace Plots');
subplot(3,1,1); plot(Phi_post(:,1)); title('\phi_1');
subplot(3,1,2); plot(Phi_post(:,2)); title('\phi_2');
subplot(3,1,3); plot(Sigma_post); title('\sigma');

figure('Name','Posterior Distributions');
subplot(3,1,1);
histogram(Phi_post(:,1),40,'Normalization','pdf');
title('Posterior of \phi_1'); xline(phi_true(1),'r','LineWidth',1.2);
subplot(3,1,2);
histogram(Phi_post(:,2),40,'Normalization','pdf');
title('Posterior of \phi_2'); xline(phi_true(2),'r','LineWidth',1.2);
subplot(3,1,3);
histogram(Sigma_post,40,'Normalization','pdf');
title('Posterior of \sigma'); xline(sigma_true,'r','LineWidth',1.2);