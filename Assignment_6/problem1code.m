%----------Problem 1-----------
diary('output1.txt');
diary on;
clear; clc; close all;

f1 = @(x) sin(x) ./ sqrt(1 - x.^2);
I1 = integral(f1, 0, 1);

f2 = @(x, y) 1 + 2*x + y + x.*y;
lb = @(x) 1 - sqrt(1 - x.^2);
ub = @(x) 1 + sqrt(1 - x.^2);
I2 = integral2(f2, -1, 1, lb, ub);

disp(['result1: ', num2str(I1)]);
disp(['result2: ', num2str(I2)]);

diary off;