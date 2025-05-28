%----------Problem 2-----------
clc; clear; close all;

% Define Variables
syms C1(t) C2(t) beta1 beta2 beta3 C0 C10 C20

% Define Equations
eq1 = diff(C1, t) == beta1 * (C0 - C1);
eq2 = diff(C2, t) == beta2 * (C1 - C2) + beta3;

% Define initial conditions
cond1 = C1(0) == C10;
cond2 = C2(0) == C20;

% Solve the ODE system
[C1_sol, C2_sol] = dsolve([eq1, eq2], [cond1, cond2]);

% Display the Analytical Solutions
disp('C1(t) = ');
disp(C1_sol);
disp('C2(t) = ');
disp(C2_sol);