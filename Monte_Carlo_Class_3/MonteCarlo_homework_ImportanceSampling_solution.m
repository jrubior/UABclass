clear; clc;

%% PARAMETERS
nus = [3, 4, 10, 100];   % Degrees of freedom for the target t_ν
m   = 100000;              % Number of Monte Carlo draws

%% STORAGE
results = zeros(length(nus), 2);  % Columns: [Estimated Mean, Estimated Var(Mean)]

%% STEP 1: Draw from the proposal g(θ) = N(0,1)
theta = randn(m, 1);             % Proposal samples
phi_vals = normpdf(theta, 0, 1); % Proposal density values φ(θ)

%% STEP 2: Loop over ν values and compute IS estimates
for i = 1:length(nus)
    nu = nus(i);
    
    % Target density π(θ) = t_ν(θ)
    t_vals = tpdf(theta, nu);
    
    % Importance weights ω(θ) = π(θ)/g(θ)
    w = t_vals ./ phi_vals;
    
    % IS estimate of E[X]
    mean_est = mean(theta .* w);
    
    % Estimated variance of the mean
    var_est = mean(((theta - mean_est).^2) .* (w.^2));
    
    % Store results
    results(i, :) = [mean_est, var_est];
end

%% STEP 3: Display results
T = array2table(results, ...
    'VariableNames', {'EstMean', 'EstVarMean'}, ...
    'RowNames', {'nu=3','nu=4','nu=10','nu=100'});

disp('------------------------------------------------------------')
disp('Importance Sampling Results (Normal proposal, t_ν target)')
disp('------------------------------------------------------------')
disp(T)

%% STEP 4 (optional): Simple discussion output
fprintf('\nInterpretation:\n');
fprintf('For small ν, the Student-t has heavy tails.\n');
fprintf('The Normal proposal has thinner tails → large weights → high variance.\n');
fprintf('As ν increases, tails become lighter and the IS estimator stabilizes.\n');
fprintf('------------------------------------------------------------\n');