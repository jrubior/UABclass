%% Perturbation Methods - Steady State and Matrices A,B
% Juan F. Rubio-Ramírez (Emory University)

clear; clc; close all;

%% Parameters
alpha = 0.4;
beta  = 0.9;
rho   = 0.9;
sigma = 0.01;

%% 1. Steady State (deterministic, z = 0, sigma = 0)
% From: 1 = alpha * beta * k^(alpha - 1)
k_ss = (alpha * beta)^(1 / (1 - alpha));
c_ss = k_ss^alpha - k_ss;

fprintf('Steady state results:\n');
fprintf('  k_ss = %.6f\n', k_ss);
fprintf('  c_ss = %.6f\n', c_ss);

%% 2. Compute steady-state derivatives of the equilibrium system
% Equilibrium equations (δ = 1):
% (1) Euler: 1/c_t = beta * E_t[ 1/c_{t+1} * (alpha * exp(z_{t+1}) * k_{t+1}^{alpha-1}) ]
% (2) Resource: c_t + k_{t+1} = exp(z_t) * k_t^alpha

% At steady state (z = 0), exp(z) = 1, k = k*, c = c*.

% Derivatives of equation (1) wrt variables [c_t, c_{t+1}, k_t, k_{t+1}, z_t, z_{t+1}]
H1 = -1 / c_ss^2;                 % d/dc_t (1/c_t)
H2 = 1 / c_ss^2; % d/dc_{t+1}
H3 = 0;                           % d/dk_t (Euler eq)
H4 = -(alpha-1) * k_ss^(-1) / c_ss; % d/dk_{t+1}
H5 = 0;                           % d/dz_t
H6 = -rho / c_ss;               % d/dz_{t+1}

% Equation (2) derivatives (resource constraint)
G1 = 1;             % d/dc_t
G2 = 0;             % d/dc_{t+1}
G3 = -alpha * k_ss^(alpha-1); % d/dk_t
G4 = 1;             % d/dk_{t+1}
G5 = 0;   % d/dz_t  [since derivative of exp(z_t) = exp(z_t)]
G6 = -k_ss^alpha;             % d/dz_{t+1}

F1=0;
F2=0;
F3=0;
F4=0;
F5=-rho;
F6=1;

%% 3. Construct matrices A and B (slides 21–24)

A = [H4, H6, H2;
     G4, G6, G2;
     F4, F6, F2];

B = -[H3, H5, H1;
      G3, G5, G1;
      F3, F5, F1];

fprintf('\nMatrix A = \n');
disp(A);
fprintf('Matrix B = \n');
disp(B);

% Solving F_k F_zlag

%% Optional: verify eigenvalues of the generalized eigenvalue problem
% (B - λA)v = 0
[VV, DD] = eig(B, A);
eigvals = diag(DD);
fprintf('\nGeneralized eigenvalues (|λ|<1 are stable roots):\n');
disp(eigvals);

[d,ind] = sort(diag(DD));

DDs = (DD(ind,ind));
VVs = VV(:,ind);

P=VVs(1:2,1:2);

hx=(P*DDs(1:2,1:2))/P
cx=VVs(3,1:2)/P

% Solving F_e

C=[H1, H2*cx(1,1)+H4, H2*cx(1,2)+H6;
   G1, G2*cx(1,1)+G4, G2*cx(1,2)+G6;
   F1, F2*cx(1,1)+F4, F2*cx(1,2)+F6];

ce=C\[0;0;sigma]

% Solving F_chi

D=[H1+H2, H2*cx(1,1)+H4, H2*cx(1,2)+H6;
    G1+G2, G2*cx(1,1)+G4, G2*cx(1,2)+G6;
    F1+F2, F2*cx(1,1)+F4, F2*cx(1,2)+F6];

cchi=D\[0;0;0]


