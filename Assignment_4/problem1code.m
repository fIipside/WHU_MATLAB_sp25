%----------Problem 1-----------
diary('output1.txt');
diary on;
clear; clc; close all;

%% Data Points
data = [
   -2.0000   -0.0000;
   -1.7913   -0.1797;
   -1.5707   -0.3184;
   -1.3460   -0.4164;
   -1.1248   -0.4755;
   -0.9137   -0.4992;
   -0.7186   -0.4916;
   -0.5442   -0.4584;
   -0.3938   -0.4055;
   -0.2694   -0.3395;
   -0.1713   -0.2668;
   -0.0987   -0.1939;
   -0.0493   -0.1267;
   -0.0195   -0.0702;
   -0.0049   -0.0287;
   -0.0004   -0.0050;
    0.0000   -0.0009;
    0.0021   -0.0165;
    0.0119   -0.0509;
    0.0347   -0.1016;
    0.0755   -0.1650;
    0.1381   -0.2362;
    0.2254   -0.3097;
    0.3389   -0.3793;
    0.4786   -0.4384;
    0.6434   -0.4806;
    0.8303   -0.4995;
    1.0354   -0.4895;
    1.2532   -0.4455;
    1.4773   -0.3640;
    1.7006   -0.2424;
    1.9152   -0.0797;
    2.1131    0.1236;
    2.2865    0.3653;
    2.4277    0.6417;
    2.5299    0.9477;
    2.5872    1.2767;
    2.5949    1.6211;
    2.5499    1.9725;
    2.4504    2.3216;
    2.2966    2.6591;
    2.0904    2.9757;
    1.8351    3.2624;
    1.5360    3.5111;
    1.1996    3.7143;
    0.8337    3.8662;
    0.4472    3.9622;
    0.0496    3.9995;
   -0.3493    3.9770;
   -0.7395    3.8953;
   -1.1113    3.7569;
   -1.4558    3.5659;
   -1.7649    3.3279;
   -2.0315    3.0499;
   -2.2503    2.7399;
   -2.4173    2.4067;
   -2.5303    2.0595;
   -2.5888    1.7079;
   -2.5939    1.3609;
   -2.5485    1.0273;
   -2.4569    0.7150;
   -2.3248    0.4307;
   -2.1587    0.1800
];

x = data(:, 1);
y = data(:, 2);

% Ensure the Curve is Closed
x = [x; x(1)];
y = [y; y(1)];

%% Parametrization
n = length(x);
t = zeros(n, 1);
for i = 2:n
    t(i) = t(i-1) + sqrt((x(i) - x(i-1))^2 + (y(i) - y(i-1))^2);
end

%% Interpolation Using Spline Functions
tt = linspace(t(1), t(end), 1000);
xs = spline(t, x, tt);
ys = spline(t, y, tt);

%% Calculate the Length
ppx = spline(t, x);
ppy = spline(t, y);

% Compute the First Derivative
dppx = fnder(ppx,1);
dppy = fnder(ppy,1);
dx = ppval(dppx, tt);
dy = ppval(dppy, tt);

% Compute Curve Length
ds = sqrt(dx.^2 + dy.^2);
curve_length = trapz(tt, ds);

%% Plot the Figure
figure;
plot(x, y, 'ro', 'MarkerSize', 6, 'DisplayName', 'Data Points');
hold on;
plot(xs, ys, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Interpolation Curve');
grid on;
xlabel('x');
ylabel('y');
title('Interpolation Using Spline Functions');
legend('Location', 'Best');

%% Print and Save
set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 1600, 900]);
exportgraphics(gcf, 'Problem1.pdf', 'ContentType', 'vector');

fprintf('Curve Length = %.4f\n', curve_length);

diary off;