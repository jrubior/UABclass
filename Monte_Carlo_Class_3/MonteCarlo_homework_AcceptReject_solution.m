clear; clc; rng(1);

%% Parameters
mu     = [0 0];
rho    = 0.8;
Sigma  = [1 rho; rho 1];
nDraws = 100000;

%% Draw samples from bivariate normal
R = mvnrnd(mu, Sigma, nDraws);
X = R(:,1);
Y = R(:,2);

%% Function to compute basic sample stats
sample_stats = @(A,B) struct( ...
    'mean_X', mean(A), ...
    'mean_Y', mean(B), ...
    'var_X', var(A,1), ...
    'var_Y', var(B,1), ...
    'corr_XY', corr(A,B) );

%% (a) Full sample
full_stats = sample_stats(X, Y);

%% (b) Conditional on X > Y
idx_XgtY = X > Y;
X1 = X(idx_XgtY);
Y1 = Y(idx_XgtY);
condXY_stats = sample_stats(X1, Y1);

%% (c) Conditional on X > 2
idx_Xgt2 = X > 2;
X2 = X(idx_Xgt2);
Y2 = Y(idx_Xgt2);
condXgt2_stats = sample_stats(X2, Y2);

%% Display results
fprintf('============================================================\n');
fprintf('TRUNCATED BIVARIATE NORMAL RESULTS\n');
fprintf('============================================================\n');
fprintf('Case\t\tMean(X)\tVar(X)\tMean(Y)\tVar(Y)\tCorr(X,Y)\n');
fprintf('------------------------------------------------------------\n');
fprintf('Full\t\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\n', ...
    full_stats.mean_X, full_stats.var_X, ...
    full_stats.mean_Y, full_stats.var_Y, full_stats.corr_XY);
fprintf('X>Y\t\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\n', ...
    condXY_stats.mean_X, condXY_stats.var_X, ...
    condXY_stats.mean_Y, condXY_stats.var_Y, condXY_stats.corr_XY);
fprintf('X>2\t\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\n', ...
    condXgt2_stats.mean_X, condXgt2_stats.var_X, ...
    condXgt2_stats.mean_Y, condXgt2_stats.var_Y, condXgt2_stats.corr_XY);
fprintf('------------------------------------------------------------\n');

%% Discussion point
fprintf('\nNote:\n');
fprintf(' - Conditioning on X>2 shifts both X and Y upward due to correlation (ρ=0.8).\n');
fprintf(' - The marginal variance of Y decreases because the conditioning restricts\n');
fprintf('   the joint support: large X implies large Y with less dispersion.\n');
fprintf('============================================================\n');