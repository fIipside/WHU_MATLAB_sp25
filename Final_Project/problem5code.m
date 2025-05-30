%----------Problem 5-----------
clc; clear; close all;

%% Parameters
C0 = 1;     % g/m^3
C10 = 10;   % g/m^3
C20 = 5;    % g/m^3
W = 1e4;    % g/day
V1 = 200000.00;   % m^3
V2 = 100000.00;    % m^3
Q_max = 1.5e4;    % m^3/day
t_target = 40;    % days

%% Search for Q and Solve ODE
Q_values = linspace(0, Q_max, 100);
found = false;
Q_opt = Q_max;
t_required = NaN;

for Q = Q_values
    beta1 = Q / V1;
    beta2 = Q / V2;
    beta3 = W / V2;
    odefun = @(t, C) [beta1 * (C0 - C(1)); beta2 * (C(1) - C(2)) + beta3];
    [t, C] = ode45(odefun, [0 t_target], [C10; C20]);
    if C(end,1) < 2 && C(end,2) < 2
        fprintf('For Q = %.2f m^3/day, the target is achieved within 40 days\n', Q);
        Q_opt = Q;
        t_required = t(end);
        found = true;
        break
    end
end

if ~found
    fprintf('The target cannot be achieved within 40 days for Q_max = %.2f m^3/day\n', Q_max);
    Q_opt = Q_max;
    beta1 = Q_opt / V1;
    beta2 = Q_opt / V2;
    beta3 = W / V2;
    odefun = @(t, C) [beta1 * (C0 - C(1)); beta2 * (C(1) - C(2)) + beta3];
    [t_long, C_long] = ode45(odefun, [0 200], [C10; C20]);

    idx = find(C_long(:,1) < 2 & C_long(:,2) < 2, 1);
    if isempty(idx)
        fprintf('Even after 200 days, concentrations do not fall below 2 g/m^3.\n');
        t_required = NaN;
    else
        t_required = t_long(idx);
        fprintf('For Q = %.2f m^3/day, the target is achieved after %.2f days.\n', Q_opt, t_required);
    end

    t = t_long;
    C = C_long;
end

%% Plotting and Save
figure;
plot(t, C(:, 1), 'b-', 'LineWidth', 1.5); hold on;
plot(t, C(:, 2), 'r-', 'LineWidth', 1.5);
yline(2, 'k--', 'Threshold', 'LineWidth', 1.5);
xline(t_target, 'g--', 'Target Time (40 days)', 'LineWidth', 1.5);
if ~isnan(t_required)
    xline(t_required, 'm--', sprintf('Actual Achieved Time (%.2f days)', t_required), 'LineWidth', 1.5);
end
title('Concentration and Time to Reach Threshold');
xlabel('Time (days)');
ylabel('Concentration (g/m^3)');
legend('C1(t) (Lake 1)', 'C2(t) (Lake 2)', ...
    'Threshold (2 g/m^3)', 'Target Time', 'Actual Time');
grid on;

set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem5.pdf', 'ContentType', 'vector');