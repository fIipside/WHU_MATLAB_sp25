clc; clear; close all;

% Define and Initialize Parameters
N = 10^5;                  
x = zeros(N, 1);            
y = zeros(N, 1);            
x(1) = 1;                   
y(1) = 1;                   
m = [
    0.5, 0, 0, 0.5, 0,    0;       
    0.5, 0, 0, 0.5, 0.5,  0;     
    0.5, 0, 0, 0.5, 0.25, 0.5   
];

% Define Probability and Randomize Procedure
prob = [1/3, 1/3, 1/3];         
r = rand(N, 1);                  % Generate N Random Numbers within [0, 1)                
cum_prob = cumsum(prob);         % [1/3, 2/3, 1]
idx = sum(r >= cum_prob, 2) + 1; % Add the Numbers by Columns

% Iterative Procedure
for n = 2:N
    k = idx(n);                  
    a = m(k, 1); b = m(k, 2); c = m(k, 3); 
    d = m(k, 4); e = m(k, 5); f = m(k, 6);
    x(n) = a * x(n-1) + b * y(n-1) + e;
    y(n) = c * x(n-1) + d * y(n-1) + f;
end

% Plot the Figure
figure;
scatter(x, y, 1, '.', 'MarkerEdgeColor', [0.3 0.3 0.6]);
axis equal;
xlabel('$x$', 'Interpreter', 'latex'); 
ylabel('$y$', 'Interpreter', 'latex');
title('Iterative Procedure');
set(gca, 'FontSize', 18);

% Save and Export the Figure
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem4.pdf', 'ContentType', 'vector');