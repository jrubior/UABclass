// ------------------------------------------------------------
// RBC with Preference (Demand) Shock in Utility
// U = sum beta^t * exp(d_t) * C_t^(1-gamma)/(1-gamma)
// Resource: C_t + K_{t+1} = K_t^alpha
// Shock:    d_t = rho*d_{t-1} + sigma*eps_t
// Euler:    exp(d_t) * C_t^(-gamma)
//           = beta * E_t[ exp(d_{t+1}) * C_{t+1}^(-gamma) * alpha * K_{t+1}^{alpha-1} ]
// ------------------------------------------------------------

var c k d;          // endogenous: consumption, capital, preference shock
varexo eps;         // exogenous: i.i.d. innovation to d

parameters alpha beta gamma rho sigma;

// ---- Choose parameter values ----
alpha = 0.40;
beta  = 0.9;
gamma = 2.00;
sigma = 1;       // std. dev. of eps

// ---- Model equations ----
model;
// Euler equation
exp(d) * c^(-gamma)
  = beta * exp(d(+1)) * c(+1)^(-gamma) * alpha * k^(alpha-1);

// Resource constraint
c + k = k(-1)^alpha;

// AR(1) for preference (demand) shock
d = sigma * eps;
end;

// ---- Analytical steady state (d = 0) ----
// k_ss = (alpha*beta)^(1/(1-alpha))
// c_ss = k_ss^alpha - k_ss
steady_state_model;
  d = 0;
  k = (alpha*beta)^(1/(1-alpha));
  c = k^alpha - k;
end;

// ---- Check and compute steady state ----
initval;
  d = 0;
  k = (alpha*beta)^(1/(1-alpha));
  c = k^alpha - k;
end;
steady; check;

// ---- Shock specification ----
shocks;
  var eps; stderr 1;    // eps ~ N(0,1); overall volatility set by 'sigma'
end;

// ---- Simulation / IRFs ----
stoch_simul(order=1, irf=20, nograph);   // set nograph->remove to plot
// You can add: stoch_simul(order=1, irf=20) to see graphs in Dynare

// Optional: report selected moments & impulse responses
// stoch_simul(order=1, irf=0);