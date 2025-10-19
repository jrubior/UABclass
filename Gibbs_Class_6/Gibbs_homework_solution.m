%% Gibbs Sampling from 3D Normal (precision-based, numerically stable)
clear; clc; rng(1);

mu = [0;0;0];
Sigma = [1 0.8 0.4;
         0.8 1 0.5;
         0.4 0.5 1];

% Check PD
[eigvec,eigval] = eig((Sigma+Sigma')/2);
assert(all(diag(eigval) > 1e-10),'Sigma must be positive definite.');

Q = inv(Sigma);                  % precision (use chol if you prefer)
nIter  = 50000;
burnIn = 5000;

X = zeros(nIter,3);
X(1,:) = [0 0 0];               % init at mean

for t = 2:nIter
    % Update i = 1,2,3 in sequence (use most-recent values each time)
    for i = 1:3
        idx = setdiff(1:3,i);
        Qiibar = Q(i,idx);
        var_i  = 1 / Q(i,i);
        mean_i = mu(i) - (Qiibar / Q(i,i)) * (X(t-1 + (i>1),idx)' - mu(idx));
        % Explanation: for i>1 we already updated earlier coords at iter t
        % so use row t for those, t-1 for the rest. Simpler: build a fresh vec:
        xcur = X(t-1,:).';
        if i>1, xcur(1:i-1) = X(t,1:i-1).'; end
        mean_i = mu(i) - (Qiibar / Q(i,i)) * (xcur(idx) - mu(idx));
        X(t,i) = mean_i + sqrt(var_i)*randn;
    end
end

X_post = X(burnIn+1:end,:);
emp_mu = mean(X_post,1);
emp_S  = cov(X_post);

fprintf('Empirical mean:    [% .4f % .4f % .4f]\n', emp_mu);
fprintf('Empirical Sigma:\n'); disp(emp_S);
fprintf('Target Sigma:\n');   disp(Sigma);

% Quick diagnostics
figure; 
subplot(3,1,1); plot(X_post(:,1)); title('Trace X_1');
subplot(3,1,2); plot(X_post(:,2)); title('Trace X_2');
subplot(3,1,3); plot(X_post(:,3)); title('Trace X_3'); xlabel('iter');

figure;
for i=1:3
  subplot(1,3,i); histogram(X_post(:,i),50,'Normalization','pdf'); title(sprintf('X_%d',i));
end

% Quantify closeness (Frobenius norm of covariance error)
cov_err = norm(emp_S - Sigma, 'fro');
fprintf('||EmpCov - Sigma||_F = %.4e\n', cov_err);