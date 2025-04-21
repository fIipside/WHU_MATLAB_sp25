%----------Problem 3-----------
diary('output3.txt');
diary on;
clear; clc; close all;

%% Define ODE and Solve
odefun = @(x, y) [...
    y(2);                          
    y(3);                          
    -2*y(3) - x^2 * y(2) - 10*x * y(1)^2 + x * y(1) + x
];

bcfun = @(ya, yb) [...
    ya(1);
    ya(2) - 1;
    yb(1) - 2
]; 

guess = @(x) [...
    x/2;
    1;
    0;
];

xmesh = linspace(0, 4, 10^4);          
solinit = bvpinit(xmesh, guess);
options = bvpset('RelTol', 1e-2, 'AbsTol', 1e-2);
sol = bvp4c(odefun, bcfun, solinit, options);

%% Plot and Save
x = linspace(0, 4, 100);
y = deval(sol, x);

plot(x, y(1,:), 'b-', 'LineWidth', 2);
xlabel('x');
ylabel('y');
title('Numerical Solution of Problem 3');
grid on;

set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem3.pdf', 'ContentType', 'vector');

diary off;