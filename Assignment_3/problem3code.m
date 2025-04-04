%----------Problem 3-----------
diary('output3.txt');
diary on;

clc; clear; close all;

x = [5.764, 6.286, 6.759, 7.168, 7.480]';
y = [0.648, 1.202, 1.823, 2.526, 3.360]';
A = [x.^2, x.*y, y.^2, x, y, ones(size(x))];

% Solving the Least Squares Problem Using Singular Value Decomposition
[~, ~, V] = svd(A);
P = V(:, end);

A = P(1); B = P(2); C = P(3);
D = P(4); E = P(5); F = P(6);
x0 = (2 * C * D - B * E) / (B^2 - 4 * A * C);
y0 = (2 * A * E - B * D) / (B^2 - 4 * A * C);

% Calculate the Semi-Major Axis a and the Semi-Minor Axis b
theta = 0.5 * atan2(B, A - C);
numer = 2 * (A * x0^2 + C * y0^2 + B * x0 * y0 - F);
denom1 = A + C + sqrt((A - C)^2 + B^2);
denom2 = A + C - sqrt((A - C)^2 + B^2);
a = sqrt(numer / denom1); 
b = sqrt(numer / denom2);

% Plot the Orbit
theta_grid = linspace(0, 2*pi, 100);
X_ellipse = a * cos(theta_grid);
Y_ellipse = b * sin(theta_grid);
R = [cos(theta), -sin(theta); sin(theta), cos(theta)];
ellipse_rotated = R * [X_ellipse; Y_ellipse];
X_ellipse = ellipse_rotated(1, :) + x0;
Y_ellipse = ellipse_rotated(2, :) + y0;

figure; hold on; axis equal;
plot(x, y, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
plot(X_ellipse, Y_ellipse, 'b-', 'LineWidth', 2);
plot(x0, y0, 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 8);
legend('Observed Data Points', 'Fitted Ellipse', 'Ellipse Center', 'Location', 'Best');
xlabel('x (AU)'); 
ylabel('y (AU)');
title('Asteroid Elliptical Orbit');
grid on;

% Save and Print
set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'asteroid_orbit.pdf', 'ContentType', 'vector');

fprintf('Elliptical Orbit: %.4fx^2 + %.4fxy + %.4fy^2 + %.4fx + %.4fy + %.4f = 0\n', A, B, C, D, E, F);
fprintf('Ellipse Center: (%.4f, %.4f)\n', x0, y0);
fprintf('Semi-Major Axis: %.4f, Semi-Minor Axis: %.4f\n', a, b);

diary off;