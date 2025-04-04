%----------Problem 2-----------
diary('output2.txt');
diary on;

clc; clear; close all;

% First-Order Optimality Conditions for Trust-Region Algorithm

f = @(x) 10*x(1)^3 + x(1)*x(2)^2 + x(3)*(x(1)^2 + x(2)^2);
nonlcon = @(x) deal([ sqrt(x(1)^2 + x(2)^2) - x(3) - 10;  
                      sqrt(x(1)^2 + x(2)^2) + x(3) - 3 ],  []);
x0 = [0, -5, 0];
options = optimset; 
options.TolFun = 1.0e-10; 
options.Tolx = 1.0e-10; 
options = optimset('PlotFcns', @optimplotfirstorderopt); 

[X, FVAL, EXITFLAG, OUTPUT] = fmincon(f, x0, [], [], [], [], [], [], nonlcon, options);

fprintf('Optimal Solution: x1 = %.4f, x2 = %.4f, x3 = %.4f, f = %.6f\n', X(1), X(2), X(3), FVAL);
title('Convergence Plot');
xlabel('Iteration');
ylabel('First-Order Optimality');
set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem2_tr.pdf', 'ContentType', 'vector');

% Pattern Search Algorithm

f = @(x) 10*x(1)^3 + x(1)*x(2)^2 + x(3)*(x(1)^2 + x(2)^2);
nonlcon = @(x) deal([ sqrt(x(1)^2 + x(2)^2) - x(3) - 10; 
                      sqrt(x(1)^2 + x(2)^2) + x(3) - 3 ],  []);
options = optimoptions('patternsearch', ...
    'Display', 'iter', ...
    'MaxIterations', 500);
x0 = [0, -5, 0];

[X, FVAL] = patternsearch(f, x0, [], [], [], [], [], [], nonlcon, options);

fprintf('Optimal Solution: x1 = %.4f, x2 = %.4f, x3 = %.4f, f = %.6f\n', X(1), X(2), X(3), FVAL);

% Simulated Annealing Algorithm with Penalty Function Method

clc; clear; close all;

f_original = @(x) 10*x(1)^3 + x(1)*x(2)^2 + x(3)*(x(1)^2 + x(2)^2);
nonlcon = @(x) [ sqrt(x(1)^2 + x(2)^2) - x(3) - 10;  
                 sqrt(x(1)^2 + x(2)^2) + x(3) - 3 ];
P = 1e6;
f = @(x) f_original(x) + P * sum(max(nonlcon(x), 0).^2);
lb = [-20, -20, -20]; 
ub = [20, 20, 20];
options = optimoptions('simulannealbnd', ...
    'MaxIterations', 5000, ...
    'FunctionTolerance', 1e-12, ...
    'PlotFcn', @saplotbestf);

[X, FVAL] = simulannealbnd(f, [0, -5, 0], lb, ub, options);

fprintf('Optimal Solution: x1 = %.4f, x2 = %.4f, x3 = %.4f, f = %.6f\n', X(1), X(2), X(3), FVAL);
title('Simulated Annealing');
xlabel('Iteration');
ylabel('Fval');
set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem2_sa.pdf', 'ContentType', 'vector');

diary off;