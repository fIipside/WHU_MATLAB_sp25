clc; clear; close all;

% Define x, y, t and Generate Grid
x = -6: 0.24: 6;
y = -4: 0.2: 4;
t = 0: -0.05: -2;
[X, Y] = meshgrid(x, y);

% Define Region Mask: (x^2 / 36 + y^2 / 16 <= 1)
region_mask = (X.^2 / 36 + Y.^2 / 16) <= 1;

% Generate Video Object and Save as *.avi
v = VideoWriter('Problem2.avi');
v.FrameRate = 10;
open(v);

figure;
for T = t
    % Define function: f(x, y, t) = exp(1 - t) * sqrt(x^2 + y^2)
    f = exp(1 - T) .* sqrt(X.^2 + Y.^2);
    
    % Restrict the Figure in the Region Mask
    f(~region_mask) = NaN;
    
    % Begin Plotting
    surf(x, y, f, 'EdgeColor', 'none');
    colormap parula;
    colorbar;
    xlabel('$x$', 'Interpreter', 'latex'); 
    ylabel('$y$', 'Interpreter', 'latex');
    zlabel('$f(x,y,t)$', 'Interpreter', 'latex');
    axis([-6 6 -4 4 0 10]); % Fix the Axis
    view(135, 30); % Adjust Viewing Angle
    
    % Record the Frames
    frame = getframe(gcf);
    writeVideo(v, frame);  
    pause(0.01); % Adjust the Speed
end

% Close Video Object
close(v);