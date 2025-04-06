clc; clear; close all;
diary('output.txt');
diary on;

%----------Problem 1-----------
clc; clear; close all;

syms x; 
result = limit((cos(x))^(x^(-3)), x, 0);

if isnan(result)
    disp('Problem 1: No limit.');
else
    fprintf('The answer of problem 1 is: %s\n', char(result));
end


%----------Problem 2-----------
clear; close all;

syms x y;
F = log(x) + exp(y^2/x) - exp(1);
% Implicit Differentiation Rule
dFdx = diff(F, x);
dFdy = diff(F, y);
dydx = -dFdx / dFdy; 

if isnan(dydx) || isinf(dydx)
    disp('Problem 2: No derivative.');
else
    fprintf('The answer of problem 2 is: ');
    disp(dydx);
end


%----------Problem 3-----------
clear; close all;

syms a t;
x = a * (t^3 - (sin(t))^2);
y = a * (t - cos(t));
% Differentiate Parametric Equations
dxdt = diff(x, t);
dydt = diff(y, t);
dydx = dydt / dxdt;

if isinf(dydx) || isnan(dydx)
    disp('Problem 3: No derivative.');
else
    fprintf('The answer of problem 3 is: ');
    disp(dydx);
end


%----------Problem 4-----------
clear; close all;

syms x y z;
F = sin(x + y) + cos(y^2 + z^2) + tan(x + z^3);
% Implicit Differentiation Rule
dFdx = diff(F, x);
dFdy = diff(F, y);
dFdz = diff(F, z);
dpzdpx = -dFdx / dFdz; 
dpzdpy = -dFdy / dFdz; 

if isnan(dpzdpx) || isinf(dpzdpx)
    disp('Problem 4(a): No partial derivative.');
else
    fprintf('The answer of problem 4(a) is: ');
    disp(dpzdpx);
end

if isnan(dpzdpy) || isinf(dpzdpy)
    disp('Problem 4(b): No partial derivative.');
else
    fprintf('The answer of problem 4(b) is: ');
    disp(dpzdpy);
end


%----------Problem 5-----------
clear; close all;

syms x y z;
u = cos(x + y) * exp(x^2 * y * sin(z));

dudx2 = diff(u, x, 2);
dudy2 = diff(dudx2, y, 2);
dudz = diff(dudy2, z, 1);

if isnan(dudz) || isinf(dudz)
    disp('Problem 5: No partial derivative.');
else
    result = subs(dudz, [x, y, z], [1, 2, 1]);
    fprintf('The answer of problem 5 is: ');
    disp(result);
end


%----------Problem 6-----------
clear; close all;

syms x;
result = int((sin(x))^10, x);

fprintf('The answer of problem 6 is: ');
disp(result);


%----------Problem 7-----------
clear; close all;

% If No Analytical Solution Exists
% f = @(x, y) 2 * x.^2 .* (cos(x .* y)).^2 + 3 * x.^2 .* y.^2;
% xmin = 0; xmax = 3;
% ymin = 0; ymax = @(x) x;
% result = integral2(f, xmin, xmax, ymin, ymax);

syms x y;
f = 2 * x^2 * cos(x * y)^2 + 3 * x^2 * y^2;
result = int(int(f, y, 0, x), x, 0, 3);

fprintf('The answer of problem 7 is: ');
disp(result);


%----------Problem 8-----------
clear; close all;

syms x;
y = exp(x^2) * (cos(x))^2 * sin(x^2);
% Taylor 6th, 8th, 10th Order
T_6  = taylor(y, x, 'Order', 6);
T_8  = taylor(y, x, 'Order', 8);   
T_10 = taylor(y, x, 'Order', 10);  

fprintf('Problem 8, Taylor 6th Order Function: ');
disp(T_6);
fprintf('Problem 8, Taylor 8th Order Function: ');
disp(T_8);
fprintf('Problem 8, Taylor 10th Order Function: ');
disp(T_10);

% Plot the Curves
fplot(y, [-2,2], 'k', 'LineWidth', 1.4);
hold on;
fplot(T_6, [-2,2], '--r', 'LineWidth', 1.2);
fplot(T_8, [-2,2], '--g', 'LineWidth', 1.2);
fplot(T_10, [-2,2], '--b', 'LineWidth', 1.2);
legend('Original Function', 'Taylor 6th Order', 'Taylor 8th Order', 'Taylor 10th Order');
xlabel('$x$', 'Interpreter', 'latex'); 
ylabel('$y$', 'Interpreter', 'latex'); 
title('Taylor Expansion of $y(x)$ at $x=0$', 'Interpreter', 'latex');
grid on;

% Save and Export the Graph
set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem8.pdf', 'ContentType', 'vector');


%----------Problem 9-----------
clear; close all;

syms x y1(x) y2(x);
eq1 = diff(y1, x) == y1 - 2 * y2 + x;
eq2 = diff(y2, x) == 3 * y1 + y2;
cond1 = y1(0) == 1;
cond2 = y2(0) == 4;
sol = dsolve([eq1, eq2], [cond1, cond2]);

disp('Problem 9, the solution of y1 is:');
disp(sol.y1);
disp('Problem 9, the solution of y2 is:');
disp(sol.y2);

% Plot the Graph
fplot(sol.y1, [-2, 5], 'r', 'LineWidth', 1.5); hold on;
fplot(sol.y2, [-2, 5], 'b', 'LineWidth', 1.5);
legend('$y_1(x)$', '$y_2(x)$', 'Interpreter', 'latex');
xlabel('$x$', 'Interpreter', 'latex'); 
ylabel('$y$', 'Interpreter', 'latex'); 
title('Solution of Differential Equations');
grid on;

% Save and Export the Graph
set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem9.pdf', 'ContentType', 'vector');


%----------Problem 10----------
clear; close all;

syms x y t;
% Given Constant
A = [2, 3; 4, 6]; 
B = [5; 8];

% Compute the Rank
rank_A = rank(A);
rank_AB = rank([A, B]);

if rank_A == rank_AB
    if rank_A == size(A, 2)
        % Unique Solution
        solution = A \ B;
        x = rats(solution(1));
        y = rats(solution(2));
        
        fprintf('Unique solution: x = %s, y = %s\n', x, y);
    else
        % Infinitely Many Solutions
        P = pinv(A) * B;  % Particular Solution
        N = null(A, 'r'); % General Solution
        sol_general = P + t * N;    
        
        fprintf(['The equation system has infinitely many solutions: ' ...
            'x = %s, y = %s\n'], char(sol_general(1)), char(sol_general(2)));
    end
else
    % No Solution
    fprintf('No solution exists. \n');
end


%----------Problem 11----------
clear; close all;

A = [1, 2, 3; 4, 1, 2; 3, 5, 1];
[V, D] = eig(A);
a = det(A);

fprintf('Problem 11, Eigenvector: ');
disp(V);
fprintf('Problem 11, Eigenvalue: ');
disp(D);
fprintf('Problem 11, Determinant: ');
disp(a);


%----------Problem 12----------
clear; close all;

syms x;
n_max = 10;

% Initialize Legendre Polynomials
P = sym(zeros(n_max+1, 1));
P(1) = 1;
P(2) = x;

% Generate Legendre Polynomials
for k = 1 : n_max-1
    P(k+2) = expand(((2*k+1) * x * P(k+1) - k * P(k)) / (k+1));
end

% 0-10th Legendre Polynomials
disp('0-10th Legendre Polynomials:');
for k = 0 : n_max
    fprintf('P_%d(x) = %s\n', k, char(P(k+1)));
end

% Calculate Coefficients and Zero Points
for k = 1:n_max
    fprintf('\nP_%d(x) Coefficients: ', k);
    disp(coeffs(P(k+1), x, 'All'));
    fprintf('P_%d(x) Zero Points: ', k);
    disp(solve(P(k+1), x));
    disp(double(solve(P(k+1), x)));
end

% Plot Legendre Polynomials
figure;
hold on;
title('Legendre Polynomials $P_n(x)$', 'Interpreter', 'latex');
xlabel('$x$', 'Interpreter', 'latex'); 
ylabel('$P_n(x)$', 'Interpreter', 'latex'); 
grid on;
legend_list = cell(n_max+1, 1);

for k = 0 : n_max/2
    fplot(P(k+1), [-1, 1], 'LineWidth', 1.5, 'LineStyle', '--');
    legend_list{k+1} = sprintf('$P_{%d}(x)$', k);
end

for k = n_max/2 + 1 : n_max
    fplot(P(k+1), [-1, 1], 'LineWidth', 1.5, 'LineStyle', '-');
    legend_list{k+1} = sprintf('$P_{%d}(x)$', k);
end

legend(legend_list, 'Interpreter', 'latex', 'Location', 'best');
hold off;

% Save and Export the Graph
set(gca, 'FontSize', 16);
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem12.pdf', 'ContentType', 'vector');


%-------------------------------
diary off;