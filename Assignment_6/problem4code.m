%----------Problem 4-----------
diary('output4.txt');
diary on;
clear; clc; close all;

%% Initialize and Run
X = [1, 4, 5, 2];  
Y = [2, 3, 5, 6];  
n = 10;
% Compute Gauss-Legendre Nodes and Weights on [-1, 1]
[x, w] = lgwt(n, -1, 1);  
[xi_grid, eta_grid] = meshgrid(x, x);    
weights = w' * w;                
integral_val = 0;

%% Loop over Gauss points
for i = 1:n
    for j = 1:n
        xi = xi_grid(i, j);    % Current xi 
        eta = eta_grid(i, j);  % Current eta 
        
        % Shape Functions for Bilinear Quadrilateral
        N = [(1 - xi) * (1 - eta)/4, (1 + xi) * (1 - eta)/4, ...
             (1 + xi) * (1 + eta)/4, (1 - xi) * (1 + eta)/4];
        
        % Physical Coordinates at Current Gauss Point
        x_phys = sum(X .* N);  % Physical x-Coordinate
        y_phys = sum(Y .* N);  % Physical y-Coordinate
        
        % Derivatives of Shape Functions
        dN_dxi = [-(1 - eta)/4, (1 - eta)/4, (1 + eta)/4, -(1 + eta)/4];
        dN_deta = [-(1 - xi)/4, -(1 + xi)/4, (1 + xi)/4, (1 - xi)/4];
        
        % Jacobian Components
        dx_dxi = sum(X .* dN_dxi); 
        dy_dxi = sum(Y .* dN_dxi);
        dx_deta = sum(X .* dN_deta); 
        dy_deta = sum(Y .* dN_deta);
        
        % Jacobian Matrix
        J = [dx_dxi, dx_deta; dy_dxi, dy_deta];
        % Determinant of Jacobian
        detJ = abs(det(J));  
        
        % Integrand Function
        fxy = (x_phys^2 + y_phys^2) * sin(x_phys + y_phys);
        
        % Accumulate Integral Value
        integral_val = integral_val + fxy * weights(i, j) * detJ;
    end
end

%% Display the Result
fprintf('Approximated integral value: %.10f\n', integral_val);

diary off;