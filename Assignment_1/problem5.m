clc; clear; close all;

% Define u, v and Generate Grid
u = linspace(-0.5, 0.5, 50);
v = linspace(0, 2*pi, 50);
[U, V] = meshgrid(u, v);

% Use Parameter Function
r = 2 + U .* cos(V/2);
x = r .* cos(V);
y = r .* sin(V);
z = U .* sin(V/2);

% Plot the Figure
surf(x, y, z);
axis equal; 
view(20, 30);  
xlabel('$x$', 'Interpreter', 'latex'); 
ylabel('$y$', 'Interpreter', 'latex');
zlabel('$z$', 'Interpreter', 'latex');
title('Möbius Strip');
set(gca, 'FontSize', 18);

% Save and Export the Figure
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem5.1.pdf', 'ContentType', 'vector');

% Define Parameters
theta = linspace(0, 4*pi, 100); 
t = linspace(-1, 5/2, 50);        
[Theta, T] = meshgrid(theta, t);

% Möbius Parameter: Count Loops 
mob = 5/2;

% Initialize x, y, z
x0 = 3 + T .* sin(mob * Theta); 
y0 = zeros(size(Theta));        
z0 = T .* cos(mob * Theta);     

% Rotate for theta Angle
X = x0 .* cos(Theta) - y0 .* sin(Theta);
Y = x0 .* sin(Theta) + y0 .* cos(Theta);
Z = z0;

% Plot the Figure
figure;
surf(X, Y, Z);
colormap('pink');
xlabel('$x$', 'Interpreter', 'latex'); 
ylabel('$y$', 'Interpreter', 'latex');
zlabel('$z$', 'Interpreter', 'latex');
title('Möbius Strip (Extended Version)');
set(gca, 'FontSize', 18);
axis equal;
view(20, 40);

% Save and Export the Figure
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem5.2.pdf', 'ContentType', 'vector');