%----------Problem 3-----------
diary('output3.txt');
diary on;
clear; clc; close all;

%% Gauss–Legendre Integration
n = 6;
% Using Golub–Welsch Algorithm
i = (0:n-1)';
alpha = 2*i + 1;            
beta = (1:n-1)';           
% Jacobi Matrix
J = diag(alpha) + diag(beta, 1) + diag(beta, -1);
% Nodes and Weights
[V,D] = eig(J);
[x_GLag, idx] = sort(diag(D));        
w_GLag = V(1, idx).^2;

%% Evaluate the Integral and Compare
f = @(x) 1./(1 + x.^4);
I_Lag6 = sum(w_GLag' .* f(x_GLag));
fprintf('6-point Gauss–Laguerre ∫(e^{-x}/(1+x^4)) dx = %.12f\n', I_Lag6);

I_exact = integral(@(x) exp(-x) ./ (1 + x.^4), 0, Inf, 'AbsTol', 1e-12);
fprintf('MATLAB integral (exact): %.12f\n', I_exact);

%% Testing the Accuracy
max_k = 12;

for k = 0:max_k
    f = @(x) x.^k;
    I_Lag = sum(w_GLag' .* f(x_GLag));
    
    if k == 0
        I_exact = 1;  
    else
        I_exact = factorial(k);
    end
   
    error = abs(I_Lag - I_exact);
    fprintf('k=%2d: I_Lag = %.12e, I_exact = %.12e, error = %.12e\n', ...
            k, I_Lag, I_exact, error);
end

diary off;