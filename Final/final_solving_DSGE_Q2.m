%% Demand Shock RBC Model - Perturbation Homework
clear; clc;

% Parameters
alpha  = 0.4;
beta   = 0.9;
gamma  = 2.0;
sigma  = 1;

%% Steady state (d=0)
k_ss = (alpha * beta)^(1 / (1 - alpha));
c_ss = k_ss^alpha - k_ss;
fprintf('Steady State: k=%.4f, c=%.4f\n', k_ss, c_ss);

%% Evaluate H derivatives at steady state
c = c_ss; k = k_ss; d = 0;

H1 = [-gamma*c^(-gamma-1);
       1;
       0];
H2 = [gamma*c^(-gamma-1);
       0;
       0];
H3 = [0;
      -alpha*k^(alpha-1);
       0];
H4 = [-(alpha-1)*k^(-1)*c^(-gamma);
       1;
       0];
H5 = [c^(-gamma);
       0;
      0];
H6 = [-c^(-gamma);
       0;
       1];

disp('H1 = ∂H/∂c_t ='); disp(H1)
disp('H2 = ∂H/∂c_{t+1} ='); disp(H2)
disp('H3 = ∂H/∂k_t ='); disp(H3)
disp('H4 = ∂H/∂k_{t+1} ='); disp(H4)
disp('H5 = ∂H/∂d_t ='); disp(H5)
disp('H6 = ∂H/∂d_{t+1} ='); disp(H6)

%% Build A and B matrices for perturbation system
A = [H4(1) H6(1) H2(1);
     H4(2) H6(2) H2(2);
     H4(3) H6(3) H2(3)];
B = -[H3(1) H5(1) H1(1);
     H3(2) H5(2) H1(2);
     H3(3) H5(3) H1(3)];

disp('Matrix A ='); disp(A)
disp('Matrix B ='); disp(B)

%% Optional: verify eigenvalues of the generalized eigenvalue problem
% (B - λA)v = 0
[VV, DD] = eig(B, A);
eigvals = diag(DD);
fprintf('\nGeneralized eigenvalues (|λ|<1 are stable roots):\n');
disp(eigvals);

[d,ind] = sort(diag(DD));

DDs = (DD(ind,ind));
VVs = VV(:,ind);

hx=VVs(1:2,1:2)*DDs(1:2,1:2)/(VVs(1:2,1:2))
cx=VVs(3,1:2)/(VVs(1:2,1:2))