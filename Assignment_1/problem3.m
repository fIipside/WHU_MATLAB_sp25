clc; clear; close all;

% Define x, y and Generate Grid
x = -3: 0.12: 3;
y = -3: 0.12: 3;
[X, Y] = meshgrid(x, y);

% Calculate the Given ODE dy/dx = cos(X^2 + Y^2)
dYdX = cos(X.^2 + Y.^2);

% Fix dx as 1, Then Calculate dy
dx = ones(size(X));
dy = dYdX; 

% Plot the Direction Field
figure;
quiver(x, y, dx, dy, 'Color', [0, 1, 1]); % Change the Color of Arrows
hold on;
xlabel('$x$', 'Interpreter', 'latex'); 
ylabel('$y$', 'Interpreter', 'latex');
title('Direction Field');
set(gca, 'FontSize', 18);
grid on;
axis equal;

% Save and Export the Figure
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem3.pdf', 'ContentType', 'vector');