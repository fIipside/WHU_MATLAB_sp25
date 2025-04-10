% ----------Problem 3-----------
diary('output3.txt');
diary on;

clc; clear; close all;

% Observed data points (x, y) in AU
x = [5.764, 6.286, 6.759, 7.168, 7.480]';
y = [0.648, 1.202, 1.823, 2.526, 3.360]';

% Initial guess: [a, b, x0, y0, theta] - semi-major axis, semi-minor axis, ellipse center, and rotation angle (radians)
params0 = [4, 2, 6.5, 2, 0];
options = optimoptions('lsqnonlin', 'Display', 'iter', ...
    'TolFun', 1e-12, 'TolX', 1e-12);

% Define residual function with constraint: one focus at (0,0)
residual_fun = @(p) ellipse_residual_with_focus(p, x, y);

% Solve using nonlinear least squares
[params_fit, resnorm] = lsqnonlin(residual_fun, params0, [], [], options);

% Extract fitted parameters
a = params_fit(1);     % Semi-major axis
b = params_fit(2);     % Semi-minor axis
x0 = params_fit(3);    % Ellipse center x
y0 = params_fit(4);    % Ellipse center y
theta = params_fit(5); % Rotation angle in radians
c = sqrt(a^2 - b^2);   % Distance from center to focus

% Plot the Orbit
theta_grid = linspace(0, 2*pi, 200); % Angle parameterization
X_ellipse = a * cos(theta_grid);     % Parametric x (unrotated)
Y_ellipse = b * sin(theta_grid);     % Parametric y (unrotated)

% Apply rotation matrix
R = [cos(theta), -sin(theta); sin(theta), cos(theta)];
ellipse_rotated = R * [X_ellipse; Y_ellipse];

% Translate ellipse to its center
X_ellipse = ellipse_rotated(1, :) + x0;
Y_ellipse = ellipse_rotated(2, :) + y0;

% Plot original data points, fitted ellipse, center, and focus
figure; hold on; axis equal;
plot(x, y, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8);       % Data points
plot(X_ellipse, Y_ellipse, 'b-', 'LineWidth', 2);                % Fitted ellipse
plot(x0, y0, 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 8);     % Ellipse center
plot(0, 0, 'ks', 'MarkerFaceColor', 'y', 'MarkerSize', 10);      % Sun (fixed focus at origin)

legend('Observed Data Points', 'Fitted Ellipse', ...
       'Ellipse Center', 'Sun (Focus)', 'Location', 'Best');
xlabel('x (AU)'); 
ylabel('y (AU)');
title('Asteroid Elliptical Orbit');
grid on;

% Save and Print
set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'asteroid_orbit.pdf', 'ContentType', 'vector');

fprintf('Fitted Ellipse Parameters:\n');
fprintf('  Semi-Major Axis a = %.6f\n', a);
fprintf('  Semi-Minor Axis b = %.6f\n', b);
fprintf('  Ellipse Center: (%.6f, %.6f)\n', x0, y0);
fprintf('  Rotation Angle (rad): %.6f\n', theta);
fprintf('  Distance from Center to Focus: %.6f\n', c);
fprintf('  Actual Distance to Origin: %.6f\n', sqrt(x0^2 + y0^2));

diary off;
