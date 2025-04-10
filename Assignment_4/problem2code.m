%----------Problem 2-----------
diary('output2.txt');
diary on;
clear; clc; close all;

%% Data Points
data = [470 300 10   8.55;
        285  80 10   3.79;
        470 300 120  4.82;
        470  80 120  0.02;
        100 190 10   2.75;
        100 190 120 14.39;
        100  80 65   2.54;
        100 190 65   5.62;
        470 190 65   4.35;
        100 300 54  13.00;
        100 300 120  8.50;
        100  80 120  0.05;
        285 300  10 11.32;
        285 190 120  3.13;
        ];

x = data(:, 1:3);
rate = data(:, 4);

%% Linear Fit
A = [x(:, 2), x(:, 3), -rate .* x(:, 1), -rate .* x(:, 2), -rate .* x(:, 3)];
B = rate;
beta_lin = A \ B;

disp('Linear Fit：');
disp(beta_lin');

%% Nonlinear Fit (Arbitrary Start)
hougen = @(beta, x) (beta(1) * x(:, 2) + beta(2) * x(:, 3)) ./ ...
                        (1 + beta(3) * x(:, 1) + beta(4) * x(:, 2) + beta(5)*x(:, 3));
beta0 = [0 0 0 0 0];
opts = optimoptions('lsqcurvefit','Display','off');
beta_nlin1 = lsqcurvefit(hougen, beta0, x, rate, [], [], opts);

disp('Nonlinear Fit With Arbitrary Start：');
disp(beta_nlin1);

%% Nonlinear Fit
hougen = @(beta, x) (beta(1)*x(:,2) + beta(2)*x(:,3)) ./ ...
                        (1 + beta(3)*x(:,1) + beta(4)*x(:,2) + beta(5)*x(:,3));
beta0 = [0.0015 -0.0034 -0.0005 -0.0024 -0.0035];
opts = optimoptions('lsqcurvefit','Display','off');
beta_nlin2 = lsqcurvefit(hougen, beta0, x, rate, [], [], opts);

disp('Nonlinear Fit：');
disp(beta_nlin2);

%% Plot the Figure
x1 = x(:,1);
x2 = x(:,2);
x3 = x(:,3);
rate_lin   = (beta_lin(1) * x(:, 1) + beta_lin(2) * x(:, 3)) ./ (1 + beta_lin(3) * x(:, 1) + beta_lin(4) * x(:, 2) + beta_lin(5) * x(: ,3));
rate_nlin1 = hougen(beta_nlin1, x);
rate_nlin2 = hougen(beta_nlin2, x);

figure;
plot(rate, 'ko', 'MarkerFaceColor','k', 'DisplayName','Original Data'); 
hold on;
plot(rate_lin, 'r--o', 'DisplayName','Linear Fit');
plot(rate_nlin1, 'b--s', 'DisplayName','Nonlinear Fit (AS)');
plot(rate_nlin2, 'g--^', 'DisplayName','Nonlinear Fit');

xlabel('Sample Index');
ylabel('Rate');
title('Hougen-Watson Model Fit Comparison');
legend('Location', 'Best');
grid on;

%% Compare RMSE
RMSE = @(y, yhat) sqrt(mean((y - yhat).^2));

RMSE_lin   = RMSE(rate, rate_lin);
RMSE_nlin1 = RMSE(rate, rate_nlin1);
RMSE_nlin2 = RMSE(rate, rate_nlin2);

fprintf('RMSE for Linear Fit: %.4f\n', RMSE_lin);
fprintf('RMSE for Nonlinear Fit With Arbitrary Start: %.4f\n', RMSE_nlin1);
fprintf('RMSE for Nonlinear Fit: %.4f\n', RMSE_nlin2);

%% Print and Save
set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem2.pdf', 'ContentType', 'vector');

diary off;