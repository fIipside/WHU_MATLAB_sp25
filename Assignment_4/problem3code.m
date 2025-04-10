%----------Problem 3-----------
diary('output3.txt');
diary on;
clear; clc; close all;

%% DME Station Data
DME_data = [
     0.0000,   10.0000,   0.2000,   94.2340,   0.4;
   200.0000,  300.0000,   0.5000,  339.4322,   0.2;
  -300.0000,  500.0000,   0.2000,  482.0996,   1.0;
  -400.0000, -200.0000,   1.0000,  441.8201,   0.6;
   200.0000, -200.0000,  -1.0000,  383.7252,   0.5
];

stations = DME_data(:, 1:3);
measured_distances = DME_data(:, 4);
errors = DME_data(:, 5);

%% Nonlinear Least Squares Estimate
residual = @(beta) ((sqrt(sum((stations - beta).^2, 2)) - measured_distances) ./ errors);
opts = optimoptions('lsqnonlin', 'Display', 'off');

num_trials = 2000;
initial_guesses = rand(num_trials, 3) * 1200 - 600;
best_beta = [];
best_resnorm = inf;

for i = 1:num_trials
    beta0 = initial_guesses(i, :);
    [beta_est, resnorm] = lsqnonlin(residual, beta0, [], [], opts);
    
    if resnorm < best_resnorm
        best_beta = beta_est;
        best_resnorm = resnorm;
    end
end

%% Display result
fprintf('Estimated Aircraft Position:\n');
fprintf('x = %.4f km\n', best_beta(1));
fprintf('y = %.4f km\n', best_beta(2));
fprintf('z = %.4f km\n', best_beta(3));
disp(['Minimum residual norm: ', num2str(best_resnorm)]);

diary off;