%----------Problem 2-----------
diary('output2.txt');
diary on;
clear; clc; close all;

%% Define Parameters and ODE
m1 = 1;           
m2 = 2;           
l = 2;           
g = 9.8;          
M = m2 / (m1 + m2);  

odefun = @(t, y) [...
    y(2);
    -(M * cos(y(1)) * sin(y(1)) * y(2)^2 - (g/l) * sin(y(1))) / (1 - M * cos(y(1))^2);
    y(4);
    -(M * g * sin(y(1)) * cos(y(1)) + M * l * sin(y(1)) * y(2)^2) / (1 - M * cos(y(1))^2)
];
y0 = [pi/4, 1, 0, 0];
t = 0:0.05:20;

[t, y] = ode45(odefun, t, y0);

%% Compute Positions and Axis Limits
x_pivot = y(:,3);           
theta = y(:,1);             
x_mass = x_pivot + l * sin(theta);  
y_mass = -l * cos(theta);   

x_min = min(x_pivot) - l - 1;
x_max = max(x_pivot) + l + 1;
y_min = min(y_mass) - 1;
y_max = max(y_mass) + 1;

%% Set Up Video
figure;
plot([x_min, x_max], [0, 0], 'k-', 'LineWidth', 2);                      % Horizontal track
hold on;
pivot = plot(nan, nan, 'ro', 'MarkerSize', 3, 'MarkerFaceColor', 'r');   % Pivot Point
rod = plot([nan, nan], [nan, nan], 'b-', 'LineWidth', 3);                % Pendulum Rod
mass = plot(nan, nan, 'bo', 'MarkerSize', 6, 'MarkerFaceColor', 'b');    % Mass Point
axis([x_min, x_max, y_min, y_max]);
axis equal;
axis manual;                                                             % Axis Fixed
title('Pendulum Animation');

vid = VideoWriter('pendulum_video.avi');
vid.FrameRate = 20;
open(vid);

% Animation Loop
for i = 1:length(t)
    set(pivot, 'XData', x_pivot(i), 'YData', 0);
    set(rod, 'XData', [x_pivot(i), x_mass(i)], 'YData', [0, y_mass(i)]);
    set(mass, 'XData', x_mass(i), 'YData', y_mass(i));
    title(sprintf('Time: %.2f s', t(i)));
    frame = getframe(gcf);
    writeVideo(vid, frame);
end

close(vid);
diary off;