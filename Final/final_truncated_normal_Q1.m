% ============================================================
% Homework: Truncated 3D Normal under sum(x)>0 constraint
% Two methods:
%   (A) Direct MH sampling from truncated N(mu,Sigma)
%   (B) Untruncated MH sampling + Accept/Reject on sum>0
% ============================================================

clear; clc;

% ---------- PARAMETERS ----------
mu     = [0;0;0];
Sigma  = [1 0.6 0.2; 0.6 1 0.4; 0.2 0.4 1];
invS   = inv(Sigma);
Ndraws = 50000;
burnin = 5000;
s      = 1;              % proposal scale (independent)
x0     = mu;

% ============================================================
% (A) DIRECT MH ON TRUNCATED NORMAL
% ============================================================
fprintf('\n==== (A) Direct MH on Truncated Normal ====\n');

T = Ndraws + burnin;
X_A = zeros(Ndraws,3);

x = x0;
logp_x = -0.5 * (x-mu)'*invS*(x-mu);
acc = 0; keep = 0;

for t = 1:T
    % Uncorrelated random-walk proposal
    prop = x + s * randn(3,1);

    % Reject if outside truncation region
    if sum(prop) <= 0
        accept = false;
    else
        logp_prop = -0.5 * (prop-mu)'*invS*(prop-mu);
        logalpha  = logp_prop - logp_x;
        accept    = (log(rand) < logalpha);
    end

    if accept
        x = prop;
        logp_x = -0.5 * (x-mu)'*invS*(x-mu);
        acc = acc + 1;
    end

    if t > burnin
        keep = keep + 1;
        X_A(keep,:) = x';
    end
end

accA = acc / T;
meanA = mean(X_A);
fprintf('Acceptance rate (A): %.3f\n', accA);
fprintf('Mean(X|sum>0): [%.4f, %.4f, %.4f]\n', meanA(1), meanA(2), meanA(3));

figure;
subplot(2,1,1);
plot(sum(X_A,2)); ylabel('sum(X)'); title('(A) Trace: sum(X_t) > 0');
subplot(2,1,2);
histogram(sum(X_A,2),60,'Normalization','pdf');
xlabel('sum(X)'); title('(A) Histogram of sum(X)');

% ============================================================
% (B) UNTRUNCATED MH + ACCEPT/REJECT
% ============================================================
fprintf('\n==== (B) Untruncated MH + Accept/Reject ====\n');

X_B = zeros(Ndraws,3);
x = x0;
logp_x = -0.5 * (x-mu)'*invS*(x-mu);
acc = 0; kept = 0; total = 0; poscount = 0; postburn = 0;
total=0;

while kept < Ndraws
    total=total+1;

    % Proposal (uncorrelated)
    prop = x + s * randn(3,1);
    logp_prop = -0.5 * (prop-mu)'*invS*(prop-mu);
    logalpha  = logp_prop - logp_x;
    if log(rand) < logalpha
        x = prop;
        logp_x = logp_prop;
        acc = acc + 1;
    end

    if total > burnin
        postburn = postburn + 1;
        if sum(x) > 0
            poscount = poscount + 1;
            kept = kept + 1;
            X_B(kept,:) = x';
        end
    end
end

accB = acc / total;
keep_rate = poscount / postburn;
fprintf('Acceptance rate (B): %.3f\n', accB);
fprintf('Keep rate (sum>0): %.3f\n', keep_rate);
fprintf('Total iterations for %d kept draws: %d\n', Ndraws, total);

meanB = mean(X_B);
fprintf('Mean(X|sum>0): [%.4f, %.4f, %.4f]\n', meanB(1), meanB(2), meanB(3));

figure;
subplot(2,1,1);
plot(sum(X_B,2)); ylabel('sum(X)'); title('(B) Trace after A/R');
subplot(2,1,2);
histogram(sum(X_B,2),60,'Normalization','pdf');
xlabel('sum(X)'); title('(B) Histogram of sum(X)');

% ============================================================
% COMPARISON SUMMARY
% ============================================================
fprintf('\n==== SUMMARY COMPARISON ====\n');
fprintf('Method (A): acceptance = %.3f\n', accA);
fprintf('Method (B): acceptance = %.3f, keep rate = %.3f\n', accB, keep_rate);
fprintf('Mean difference (A - B): [%.4f, %.4f, %.4f]\n', meanA - meanB);