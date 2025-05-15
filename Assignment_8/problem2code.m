%----------Problem 2-----------
clear; clc; close all;

%% Parameters Initialization
depth = 10;          
initialLength = 2;
global theta1 theta2 delta;
theta1 = 20;       
theta2 = 40;
delta = 0.7;

%% Initialize figure
figure;
hold on;
axis equal;
title('Fractal Tree');
xlabel('X');
ylabel('Y');

%% Main Recursive Function to Draw Branches
function drawBranch(startPoint, angle, length, depth)
    global theta1 theta2 delta;
    if depth == 0
        return
    end
    
    endPoint = startPoint + length * [cosd(angle), sind(angle)];
    line([startPoint(1), endPoint(1)], [startPoint(2), endPoint(2)], 'Color', 'b', 'LineWidth', 1);

    % Draw Left Branch
    newAngle1 = angle + theta1;
    newLength1 = length * delta;
    drawBranch(endPoint, newAngle1, newLength1, depth - 1);
    
    % Draw Right Branch
    newAngle2 = angle - theta1;
    newLength2 = length * delta;
    drawBranch(endPoint, newAngle2, newLength2, depth - 1);
    
    % Draw Small Branch
    newLength3 = length * delta*0.5;
    newAngle3 = angle - theta2;
    endPointR = endPoint + newLength3 * [cosd(newAngle2), sind(newAngle2)];
    drawBranch(endPointR, newAngle3, newLength3, depth - 1);
end

%% Run and Export
drawBranch([0, 0], 90, initialLength, depth);
hold off;

set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem2.pdf', 'ContentType', 'vector');