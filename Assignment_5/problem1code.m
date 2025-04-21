%----------Problem 1-----------
diary('output1.txt');
diary on;
clear; clc; close all;

%% Parameters
r1  = 1;           
r2  = 1;          
N1  = 1000;        
N2  = 5000;       
rho1 = 1/4;        
rho2 = 3;          

T_end = 50;        
dt    = 0.2;       
t_e   = 0:dt:T_end;

x1_0 = N1/2;
x2_0 = N2/2;

%% Forward Euler Method
n_steps = length(t_e);
x1_e = zeros(1, n_steps);
x2_e = zeros(1, n_steps);

x1_e(1) = x1_0;
x2_e(1) = x2_0;

for k = 1:n_steps-1
    x1 = x1_e(k);
    x2 = x2_e(k);
    t  = t_e(k);
    
    dx1 = r1 * x1 * (1 - x1/N1 + rho1 * x2 / N2);
    dx2 = r2 * x2 * (-1 + rho2 * x1 / N1 - x2 / N2);
    
    x1_e(k+1) = x1 + dt * dx1;
    x2_e(k+1) = x2 + dt * dx2;
end

%% Runge-Kutta Method
f = @(t, x) [ ...
    r1*x(1)*(1 - x(1)/N1 + rho1*x(2)/N2);
    r2*x(2)*(-1 + rho2*x(1)/N1 - x(2)/N2)
];

[te, xe] = ode45(f, [0, T_end], [x1_0; x2_0]);

%% Plot the Curve
figure;
% Population 1
subplot(2,1,1);
plot(t_e, x1_e, 'b-', 'LineWidth', 1.2); 
hold on;
plot(te, xe(:,1), 'r--', 'LineWidth', 1.2);
title('Evolution of Population 1');
xlabel('t'); 
ylabel('x_1(t)');
legend('Euler Forwar Method', 'ODE45', 'Location', 'best');
grid on;
set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 1600, 900]);

% Population 2
subplot(2,1,2);
plot(t_e, x2_e, 'b-', 'LineWidth', 1.2); hold on;
plot(te, xe(:,2), 'r--', 'LineWidth', 1.2);
title('Evolution of Population 2');
xlabel('t'); ylabel('x_2(t)');
legend('Euler Forwar Method', 'ODE45', 'Location', 'best');
grid on;
set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 1600, 900]);

sgtitle('Comparison between Euler Forward Method and ODE45', 'FontSize', 18);

%% Print and Save
exportgraphics(gcf, 'Problem1.pdf', 'ContentType', 'vector');

diary off;