%----------Problem 3-----------
clc; clear; close all;

% Data and Parameters
data = readmatrix('data.xls', 'NumHeaderLines', 1);
t_data  = data(:, 1);
C1_data = data(:, 2);
C2_data = data(:, 3);
C_data = [C1_data, C2_data]';
Q = 1e4;    % m^3/day
C0 = 1;     % g/m^3
C10 = 10;   % g/m^3
C20 = 5;    % g/m^3
W = 1e4;    % g/day

%% Fit the Data
% Define Model Function
model_fun = @(V, t) model(V, t, Q, C0, C10, C20, W);

% Initial Guess Values
V0 = [2e6; 1e6];

% Use lsqcurvefit for Optimization
V_opt = lsqcurvefit(model_fun, V0, t_data, C_data);

%% Display Estimated Results
fprintf('Estimated lake capacities:\n');
fprintf('V1 = %.2f m^3\n', V_opt(1));
fprintf('V2 = %.2f m^3\n', V_opt(2));

C_theory = model(V_opt, t_data, Q, C0, C10, C20, W);
C1_theory = C_theory(1,:)';
C2_theory = C_theory(2,:)' ;

%% Model Function
function C = model(V, t, Q, C0, C10, C20, W)
    V1 = V(1);
    V2 = V(2);
    beta1 = Q / V1;
    beta2 = Q / V2;
    beta3 = W / V2;
    odefun = @(t, C) [beta1 * (C0 - C(1)); beta2 * (C(1) - C(2)) + beta3];
    [t_sol, C_sol] = ode45(odefun, t, [C10; C20]);
    C = C_sol';
end

%% Plot and Export
figure;
subplot(2, 1, 1);
plot(t_data, C1_data, 'bo', 'LineWidth', 1, 'MarkerSize', 8, 'DisplayName', 'Measured Data');
hold on;
plot(t_data, C1_theory, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Theoretical Curve');
title('Comparison of Pollutant Concentration in Lake L1', 'FontSize', 12);
xlabel('Time (days)', 'FontSize', 10);
ylabel('Concentration (g/m³)', 'FontSize', 10);
legend('Location', 'best');
set(gca, 'FontSize', 18);
grid on;

subplot(2, 1, 2);
plot(t_data, C2_data, 'bo', 'LineWidth', 1, 'MarkerSize', 8, 'DisplayName', 'Measured Data');
hold on;
plot(t_data, C2_theory, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Theoretical Curve');
title('Comparison of Pollutant Concentration in Lake L2', 'FontSize', 12);
xlabel('Time (days)', 'FontSize', 10);
ylabel('Concentration (g/m³)', 'FontSize', 10);
legend('Location', 'best');
set(gca, 'FontSize', 18);
grid on;

sgtitle('Comparison of Measured Data and Theoretical Curves', 'FontSize', 20);
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem3.pdf', 'ContentType', 'vector');