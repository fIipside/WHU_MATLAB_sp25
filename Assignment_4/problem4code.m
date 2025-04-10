%----------Problem 4-----------
diary('output4.txt');
diary on;
clear; clc; close all;

%% Load Data
data = readmatrix('data.xlsx');
t = data(:, 1);
x_obs = data(:, 2);

%% Nonlinear Least Squares
% params = [w1, w2, a1, a2, b1, b2]
harmonic_model = @(params, t) ...
    params(3) * cos(params(1) * t) + ...
    params(5) * sin(params(1) * t) + ...
    params(4) * cos(params(2) * t) + ...
    params(6) * sin(params(2) * t);
Fs = 1 / mean(diff(t));
L = length(t);

% With Clear Frequency Components, We Use FFT
Y = fft(x_obs);
P2 = abs(Y / L);
P1 = P2(1:floor(L/2));
f = Fs * (0:(L/2 - 1)) / L;
[~, idx] = sort(P1, 'descend');

f1 = f(idx(1));
f2 = f(idx(2));
w1_guess = 2 * pi * f1;
w2_guess = 2 * pi * f2;
params0 = [w1_guess, w2_guess, 1, 1, 1, 1];

opts = optimoptions('lsqcurvefit', 'Display', 'iter');
[estimated_params, resnorm] = lsqcurvefit(harmonic_model, ...
    params0, t, x_obs, [], [], opts);

w1 = estimated_params(1);
w2 = estimated_params(2);
a1 = estimated_params(3);
a2 = estimated_params(4);
b1 = estimated_params(5);
b2 = estimated_params(6);

%% Plot Fitted Curve
x_fit = harmonic_model(estimated_params, t);

figure;
plot(t, x_obs, 'b-', 'DisplayName', 'Noisy Signal'); 
hold on;
plot(t, x_fit, 'r--', 'LineWidth', 2, 'DisplayName', 'Fitted Signal');
legend; 
grid on;
xlabel('t'); ylabel('x(t)');
title('Harmonic Signal Fitting');

%% Print and Save
set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem4.pdf', 'ContentType', 'vector');

fprintf('Estimated parameters:\n');
fprintf('w1 = %.4f, a1 = %.4f, b1 = %.4f\n', w1, a1, b1);
fprintf('w2 = %.4f, a2 = %.4f, b2 = %.4f\n', w2, a2, b2);

diary off;