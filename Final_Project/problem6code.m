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
window_size = 10;
C1_smooth = movmean(C1_data, window_size);
C2_smooth = movmean(C2_data, window_size);

%% Solve ODE System
% Model Function
model_fun = @(params, t) model(params, t, C0, C10, C20, W);

% Initial Guess
params0 = [1e4; 1e5; 1e5];

% Optimize Parameters
options = optimoptions('lsqcurvefit', 'Display', 'iter');
params_opt = lsqcurvefit(model_fun, params0, t_data, [C1_smooth, C2_smooth]', [], [], options);

% Display Results
fprintf('Estimated Q = %.2f m^3/day\n', params_opt(1));
fprintf('Estimated V1 = %.2f m^3\n', params_opt(2));
fprintf('Estimated V2 = %.2f m^3\n', params_opt(3));

% Model Function Definition
function C = model(params, t, C0, C10, C20, W)
    Q = params(1);
    V1 = params(2);
    V2 = params(3);
    beta1 = Q / V1;
    beta2 = Q / V2;
    beta3 = W / V2;
    odefun = @(t, C) [beta1 * (C0 - C(1)); beta2 * (C(1) - C(2)) + beta3];
    [t_sol, C_sol] = ode45(odefun, t, [C10; C20]);
    C = C_sol';
end

% Calculate Model Predictions
C_pred = model(params_opt, t_data, C0, C10, C20, W);
C1_pred = C_pred(1,:);
C2_pred = C_pred(2,:);

%% Plotting and Saving
figure;
subplot(2,1,1);
plot(t_data, C1_data, 'b.', 'MarkerSize', 8);
hold on;
plot(t_data, C1_smooth, 'g-', 'LineWidth', 1.5);
plot(t_data, C1_pred, 'r--', 'LineWidth', 1.5);
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
plot(t_data, C2_pred, 'r--', 'LineWidth', 1.5);
title('Pollutant Concentration in Lake 2');
xlabel('Time (days)');
ylabel('Concentration (g/m^3)');
legend('Measured Data', 'Smoothed Data', 'Model Fit');
set(gca, 'FontSize', 18);
grid on;

set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem6.pdf', 'ContentType', 'vector');