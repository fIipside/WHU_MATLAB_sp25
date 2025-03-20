clc; clear; close all;

% Define x, y and Generate Grid
x = -2: 0.08: 2;
y = -3: 0.12: 3;
[X, Y] = meshgrid(x, y);

% Define function: f(x,y) = x^3 * y^2 * cos(x + y)
F = X.^3 .* Y.^2 .* cos(X + Y);

% Define Region Mask: (x^2 / 4 + y^2 / 9 <= 1)
region_mask = (X.^2 / 4 + Y.^2 / 9) <= 1;

% Restrict the Figure in the Region Mask
F(~region_mask) = NaN;
figure;

% Surface Plot
subplot(2,2,1);
surfc(X, Y, F);
colorbar;
title('Surface Plot');
xlabel('$x$', 'Interpreter', 'latex'); 
ylabel('$y$', 'Interpreter', 'latex'); 
zlabel('$f(x,y)$', 'Interpreter', 'latex');
set(gca, 'FontSize', 14);

% Contour Plot
subplot(2,2,2);
contour(X, Y, F, 40); % Plot 40 lines.
colorbar;
title('Contour Plot');
xlabel('$x$', 'Interpreter', 'latex'); 
ylabel('$y$', 'Interpreter', 'latex');
set(gca, 'FontSize', 14);

% Pseudocolor Plot
subplot(2,2,3);
pcolor(X, Y, F);
colorbar('horiz');
colorbar('vert');
title('Pseudocolor Plot');
xlabel('$x$', 'Interpreter', 'latex'); 
ylabel('$y$', 'Interpreter', 'latex');
set(gca, 'FontSize', 14);

% Colored Surface Plot with Light
subplot(2,2,4);
surfl(X, Y, F, [45 60]);
material shiny; % More Shiny
colorbar;
title('Colored Surface Plot');
xlabel('$x$', 'Interpreter', 'latex'); 
ylabel('$y$', 'Interpreter', 'latex');
zlabel('$f(x,y)$', 'Interpreter', 'latex');
set(gca, 'FontSize', 14);

% Save and Export the Figure
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem1.pdf', 'ContentType', 'vector');