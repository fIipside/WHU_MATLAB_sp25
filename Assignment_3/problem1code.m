%----------Problem 1-----------
diary('output1.txt');
diary on;

clc; clear; close all;

% First-Order Optimality Conditions for Trust-Region Algorithm

x0_list = [10, 10; -10, -10; 0, 0; -10, 10; 10, -10];
schaffer = @(x) 0.5 + ((sin(sqrt(x(1)^2 + x(2)^2)))^2 - 0.5)/(1 + 0.001*(x(1)^2 + x(2)^2))^2; 
options = optimset; 
options.TolFun = 1.0e-10; 
options.Tolx = 1.0e-10; 
options = optimset('PlotFcns', @optimplotfirstorderopt); 

best_FVAL = Inf;
best_X = [];
for i = 1:size(x0_list, 1)
    x0 = x0_list(i, :);
    [X, FVAL] = fminunc(schaffer, x0, options);
    if FVAL < best_FVAL
        best_FVAL = FVAL;
        best_X = X;
    end
end
fprintf('Optimal Solution: x = %.4f, y = %.4f, f(x,y) = %.6f\n', best_X(1), best_X(2), best_FVAL);

clc; clear; close all;

% Genetic Algorithm

hybrid_options = optimoptions('fmincon', 'Algorithm', 'sqp');
options = optimoptions('ga', ...
    'MaxGenerations', 5000, ...
    'PopulationSize', 1000, ...
    'CrossoverFraction', 0.8, ...
    'MutationFcn', @mutationadaptfeasible, ...
    'FunctionTolerance', 1e-12, ...
    'HybridFcn', {@fmincon, hybrid_options}, ...  
    'PlotFcn', @gaplotbestf);
lb = [-10, -10];
ub = [10, 10];
schaffer = @(x) 0.5 + ((sin(sqrt(x(1)^2 + x(2)^2)))^2 - 0.5)/(1 + 0.001*(x(1)^2 + x(2)^2))^2; 

[X, FVAL] = ga(schaffer, 2, [], [], [], [], lb, ub, [], options);

fprintf('Optimal Solution: x = %.4f, y = %.4f, f(x,y) = %.6f\n', X(1), X(2), FVAL);
set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem1_ga.pdf', 'ContentType', 'vector');

diary off;