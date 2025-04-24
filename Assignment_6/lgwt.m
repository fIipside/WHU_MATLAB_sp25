% lgwt.m
% Compute Gauss-Legendre Nodes and Weights
function [x, w] = lgwt(n, a, b)
    % Computes the Legendre-Gauss Nodes x and Weights w on Interval [a, b]
    i = 1:n-1;
    beta = 0.5 ./ sqrt(1 - (2*i).^(-2));    % Recurrence Coefficients
    T = diag(beta, 1) + diag(beta, -1);     % Jacobi Matrix
    [V, D] = eig(T);                        % Eigenvalue Decomposition
    x = diag(D);                            % Nodes in [-1, 1]
    [x, idx] = sort(x);
    w = 2 * V(1, idx).^2;                   % Weights
    % Affine Transformation
    x = 0.5*(b - a) * x + 0.5*(a + b);
    w = 0.5*(b - a) * w;
end