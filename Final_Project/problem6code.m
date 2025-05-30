%----------Problem 6-----------
clc; clear; close all;

%% Parameters 
data = readmatrix('noisydata.xls', 'NumHeaderLines', 1);
t_data  = data(:, 1);
C1_data = data(:, 2);
C2_data = data(:, 3);
C0 = 1;     % g/m^3
C10 = 10;   % g/m^3
C20 = 5;    % g/m^3
W = 1e4;    % g/day

%% Data Processing
window_size = 5;
C1_smooth = movmean(C1_data, window_size);
C2_smooth = movmean(C2_data, window_size);

%% Estimate V Sequentially
% Define V1 Model Function
model_C1 = @(beta1, t) C0 + (C10 - C0) * exp(-beta1 * t);
beta1_init = 0.05;  % Initial Guess Values
opts = optimoptions('lsqcurvefit', 'Display', 'off');
beta1_fit = lsqcurvefit(@(b,t) model_C1(b,t), beta1_init, t_data, C1_smooth, [], [], opts);

% Define V2 Model Function
model_C2 = @(para, t) ...
    (C20 - (C0 + W/para(2)) - (para(1) * (C10 - C0)) / (para(1) - beta1_fit)) .* exp(-para(1) * t) + ...
    C0 + W/para(2) + (para(1) * (C10 - C0) / (para(1) - beta1_fit)) .* exp(-beta1_fit * t);
para_init = [0.1, 1e5];  % Initial Guess Values
para_fit = lsqcurvefit(model_C2, para_init, t_data, C2_smooth, [], [], opts);
V1 = para_fit(2) / beta1_fit;
V2 = para_fit(2) / para_fit(1);

% Display Results
fprintf('Estimated Q = %.2f m^3/day\n', para_fit(2));
fprintf('Estimated V1 = %.2f m^3\n', V1);
fprintf('Estimated V2 = %.2f m^3\n', V2);

% Calculate Model Predictions
t_fit = linspace(0, max(t_data), 100);
C1_fit = model_C1(beta1_fit, t_fit);
C2_fit = model_C2(para_fit, t_fit);

%% Plotting and Saving
figure;
subplot(2,1,1);
plot(t_data, C1_data, 'b.', 'MarkerSize', 8);
hold on;
plot(t_data, C1_smooth, 'g-', 'LineWidth', 1.5);
plot(t_fit, C1_fit, 'r--', 'LineWidth', 1.5);
title('Pollutant Concentration in Lake 1');
xlabel('Time (days)');
ylabel('Concentration (g/m^3)');
legend('Measured Data', 'Smoothed Data', 'Model Fit');
set(gca, 'FontSize', 18);
grid on;

subplot(2,1,2);
plot(t_data, C2_data, 'b.', 'MarkerSize', 8);
hold on;
plot(t_data, C2_smooth, 'g-', 'LineWidth', 1.5);
plot(t_fit, C2_fit, 'r--', 'LineWidth', 1.5);
title('Pollutant Concentration in Lake 2');
xlabel('Time (days)');
ylabel('Concentration (g/m^3)');
legend('Measured Data', 'Smoothed Data', 'Model Fit');
set(gca, 'FontSize', 18);
grid on;

set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem6.pdf', 'ContentType', 'vector');