%----------Problem 2-----------
diary('output2.txt');
diary on;
clear; clc; close all;

%% Gauss–Legendre Integration
n = 4;
% Using Golub–Welsch Algorithm
[j, i] = meshgrid(0:n-1, 0:n-1);
alpha = zeros(n, 1);                                % Diagonal Entries
beta = (1:n-1) ./ sqrt(4 * (1:n-1).^2 - 1);         % Subdiagonal Entries
J = diag(alpha) + diag(beta, 1) + diag(beta, -1);   % Jacobi Matrix
[V,D] = eig(J);                                     % Eigen Decomposition
[x_GL, idx] = sort(diag(D));                        % Sorted Nodes
w_GL = V(1, idx).^2 * 2;                            % Normalized Weights

I_GL4 = sum(w_GL' .* exp(x_GL.^2));
fprintf('4-point Gauss–Legendre on [-1,1]:%.10f\n', I_GL4);

%% Composite Gauss–Legendre 
m = 20;       % Number of Subintervals
a = -1;
b = 1;
h = (b - a)/m;
I_comp = 0;
for k = 1:m
    ak = a + (k-1) * h;  bk = a + k * h;
    % Affine Transform
    xk = ((bk - ak)/2) * x_GL + (ak + bk)/2;
    wk = w_GL * ((bk - ak)/2);
    I_comp = I_comp + sum(wk' .* exp(xk.^2));
end
fprintf('Composite GL :%.10f\n', I_comp);

%% Compare with Exact Integral
I_exact = integral(@(x) exp(x.^2), -1, 1, 'AbsTol', 1e-14);
fprintf('MATLAB integral (exact):%.10f\n', I_exact);

diary off;