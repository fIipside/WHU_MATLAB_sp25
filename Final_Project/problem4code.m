%----------Problem 4-----------
clc; clear; close all;

%% Parameters and Coefficients
Q = 1e4;    % m^3/day
C0 = 1;     % g/m^3
C10 = 10;   % g/m^3
C20 = 5;    % g/m^3
W = 1e4;    % g/day
V1 = 183004.69;   % m^3
V2 = 85214.78;    % m^3

beta1 = Q / V1;
beta2 = Q / V2;
beta3 = W / V2;

%% Solve ODE
odefun = @(t, C) [beta1 * (C0 - C(1)); beta2 * (C(1) - C(2)) + beta3];

t_span = [0 400];
[t, C] = ode45(odefun, t_span, [C10; C20]);

% Find the Time Below 2 g/m^3
idx = find(C(:, 1) < 2 & C(:, 2) < 2, 1, 'first');
if ~isempty(idx)
    time_required = t(idx);
    fprintf('It takes %.2f days for C1 and C2 to both be below 2 g/m^3\n', time_required);
else
    fprintf('The requirement is not met within 400 days\n');
end

%% Plotting and Save
figure;
plot(t, C(:, 1), 'b-', 'LineWidth', 1.5);
hold on;
plot(t, C(:, 2), 'r-', 'LineWidth', 1.5);
yline(2, 'k--', 'Threshold', 'LineWidth', 1.5);
if ~isempty(idx)
    xline(time_required, 'g--', 'Required Time', 'LineWidth', 1.5);
end
xlabel('Time (days)');
ylabel('Concentration (g/m^3)');
title('Pollutant Concentration in Lakes L1 and L2 Over Time');
legend('C1(t) (Lake 1)', 'C2(t) (Lake 2)', 'Threshold (2 g/m^3)', 'Required Time');
grid on;

set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem4.pdf', 'ContentType', 'vector');