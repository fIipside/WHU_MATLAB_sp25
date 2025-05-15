%----------Problem 1-----------
clear; clc; close all;

%% log10(3)
% Initialize Parameters
alpha = log10(3); 
N = 100000;       
x0 = 0;           
x = zeros(N, 1);

% Iteration
x(1) = mod(x0 + alpha, 1); 
for n = 2:N
    x(n) = mod(x(n-1) + alpha, 1); % Mod 1 operation
end

% Plot normalized histogram
figure;
histogram(x, 'BinEdges', 0:0.1:1, 'Normalization', 'probability');
title('Distribution of Iterates');
xlabel('x');
ylabel('Relative Frequency');
grid on;
hold on;
plot([0, 1], [0.1, 0.1], 'r--', 'LineWidth', 2);
legend('Simulated Data', 'Uniform Distribution');

% Print and Save
set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem1_log.pdf', 'ContentType', 'vector');

disp(x(10000));

%% pi
clear; clc;
% Initialize Parameters
alpha = pi; 
N = 100000;       
x0 = 0;           
x = zeros(N, 1);

% Iteration
x(1) = mod(x0 + alpha, 1); 
for n = 2:N
    x(n) = mod(x(n-1) + alpha, 1); % Mod 1 operation
end

% Plot normalized histogram
figure;
histogram(x, 'BinEdges', 0:0.1:1, 'Normalization', 'probability');
title('Distribution of Iterates');
xlabel('x');
ylabel('Relative Frequency');
grid on;
hold on;
plot([0, 1], [0.1, 0.1], 'r--', 'LineWidth', 2);
legend('Simulated Data', 'Uniform Distribution');

% Print and Save
set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem1_pi.pdf', 'ContentType', 'vector');