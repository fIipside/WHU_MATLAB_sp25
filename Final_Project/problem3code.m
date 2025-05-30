%----------Problem 3-----------
clc; clear; close all;

% Data and Parameters
data = readmatrix('data.xls', 'NumHeaderLines', 1);
t_data  = data(:, 1);
C1_data = data(:, 2);
C2_data = data(:, 3);
Q = 1e4;    % m^3/day
C0 = 1;     % g/m^3
C10 = 10;   % g/m^3
C20 = 5;    % g/m^3
W = 1e4;    % g/day
K = C0 + W/Q; % = 2 g/m^3

%% Estimate V Sequentially
% Define V1 Model Function
model_C1 = @(beta1, t) C0 + (C10 - C0) * exp(-beta1 * t);
beta1_init = 0.1;  % Initial Guess Values
opts = optimoptions('lsqcurvefit', 'Display', 'off');
beta1_fit = lsqcurvefit(@(b,t) model_C1(b,t), beta1_init, t_data, C1_data, [], [], opts);
V1 = Q / beta1_fit;

% Define V2 Model Function
model_C2 = @(beta2, t) ...
    (C20 - K - (beta2 * (C10 - C0)) / (beta2 - beta1_fit)) .* exp(-beta2 * t) + ...
    K + (beta2 * (C10 - C0) / (beta2 - beta1_fit)) .* exp(-beta1_fit * t);
beta2_init = 0.05;  % Initial Guess Values
beta2_fit = lsqcurvefit(model_C2, beta2_init, t_data, C2_data, [], [], opts);
V2 = Q / beta2_fit;

%% Display Estimated Results
fprintf('Estimated lake capacities:\n');
fprintf('V1 = %.2f m^3\n', V1);
fprintf('V2 = %.2f m^3\n', V2);

t_fit = linspace(0, max(t_data), 100);
C1_fit = model_C1(beta1_fit, t_fit);
C2_fit = model_C2(beta2_fit, t_fit);

%% Plot and Export
figure;
subplot(2, 1, 1);
plot(t_data, C1_data, 'bo', 'LineWidth', 1, 'MarkerSize', 8, 'DisplayName', 'Measured Data');
hold on;
plot(t_fit, C1_fit, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Theoretical Curve');
title('Comparison of Pollutant Concentration in Lake L1', 'FontSize', 12);
xlabel('Time (days)', 'FontSize', 10);
ylabel('Concentration (g/m³)', 'FontSize', 10);
legend('Location', 'best');
set(gca, 'FontSize', 18);
grid on;

subplot(2, 1, 2);
plot(t_data, C2_data, 'bo', 'LineWidth', 1, 'MarkerSize', 8, 'DisplayName', 'Measured Data');
hold on;
plot(t_fit, C2_fit, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Theoretical Curve');
title('Comparison of Pollutant Concentration in Lake L2', 'FontSize', 12);
xlabel('Time (days)', 'FontSize', 10);
ylabel('Concentration (g/m³)', 'FontSize', 10);
legend('Location', 'best');
set(gca, 'FontSize', 18);
grid on;

sgtitle('Comparison of Measured Data and Theoretical Curves', 'FontSize', 20);
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem3.pdf', 'ContentType', 'vector');