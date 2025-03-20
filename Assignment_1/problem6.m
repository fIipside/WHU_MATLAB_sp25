clc; clear; close all;

% ------------ Initialize Obstacles -----------
% Outer Circle
R_outer = 10;
circle_outer = @(t) [R_outer*cos(t); R_outer*sin(t)];

% Inner Circle
obstacles = [
    6, 0, 3;   % x Coordinate, y Coordinate and Radius
   -4, -2, 1.2; 
   -1, 4, 4.5]; 

% -------------Initialize Parameters-----------
dt = 0.05; 
T = 40; 
t = 0:dt:T;

% Initialize Position and Velocity
pos = [-10, 0]; 
vel = [4, 2]; 

% --------------Start Recording ---------------
v = VideoWriter('Problem6.avi');
v.FrameRate = length(t) / T;
open(v);

% ---------------Plot Obstacles----------------
figure;
hold on; axis equal; grid on;
theta = linspace(0, 2*pi, 100);

% Plot Outer Circle
plot(R_outer*cos(theta), R_outer*sin(theta), 'k', 'LineWidth', 1);

% Plot Inner Circle
for i = 1:size(obstacles, 1)
    cx = obstacles(i,1);
    cy = obstacles(i,2);
    r = obstacles(i,3);
    plot(cx + r*cos(theta), cy + r*sin(theta), 'r', 'LineWidth', 1);
end

% ------------- Simulate Movement -------------
ball = scatter(pos(1), pos(2), 50, 'b', 'filled');
trajectory = animatedline('Color', 'b', 'LineWidth', 0.55);
pause(1);

for i = 1:length(t)
    % Update Position Before Hitting
    new_pos = pos + vel * dt;
    
    % Hit the Outer Circle
    if norm(new_pos) >= R_outer % Center of Out Circle is (0, 0)
        vel = vel - 2 * dot(vel, new_pos/norm(new_pos)) * (new_pos/norm(new_pos));
    end
    
    % Hit the Inner Circle
    for j = 1:size(obstacles, 1)
        cx = obstacles(j,1);
        cy = obstacles(j,2);
        r = obstacles(j,3);
        if norm(new_pos - [cx, cy]) <= r
            % Calculate Unit Normal Vector
            normal = (new_pos - [cx, cy]) / norm(new_pos - [cx, cy]);
            % Substract 2 * Projection on Norm Vector
            vel = vel - 2 * dot(vel, normal) * normal;
        end
    end
    
    % Update Position and Trajectory
    pos = pos + vel * dt;
    addpoints(trajectory, pos(1), pos(2));
    set(ball, 'XData', pos(1), 'YData', pos(2));

    % Save the Frame
    frame = getframe(gcf);
    writeVideo(v, frame);
    pause(0.01);
end

close(v);