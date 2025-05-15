%----------Problem 3-----------
clear; clc; close all;

%% Initialize Parameter Matrix
h = [0.00471427938400, -0.00179210101860, -0.008826800108660, 0.109702658642161, -0.045601131884100, -0.342656715382664, 0.195766961347502, 1.024326944260331, 0.853943542705429, 0.226418982583462];
g = h(end:-1:1) .* (-1).^(0:9);
A = zeros(8, 8);
for i = 1:8
    for j = 1:8
        k = 2*i - j;
        if k >= 0 && k <= 9
            A(i, j) = h(k+1);
        end
    end
end

%% Compute the Eigenvector and Normalize
[V, D] = eig(A);
eigvals = diag(D);
[~, idx] = min(abs(eigvals - 1));
phi_vec = V(:,idx);
phi_vec = phi_vec / sum(phi_vec);

%% Set up a Grid and Initialize phi(x) at Integer Points
J = 10; % refinement level
dx = 1 / 2^J;
x = 0:dx:9;
N = length(x);
phi = zeros(1, N);
for n = 0:9
    idx = round(n / dx) + 1;
    if n >= 1 && n <= 8
        phi(idx) = phi_vec(n);
    else
        phi(idx) = 0;
    end
end

%% Cascade algorithm to Approximate phi(x)
for iter = 1:10
    phi_new = zeros(1, N);
    for i = 1:N
        for l = 0:9
            k = round((2*x(i) - l) / dx) + 1;
            if k >= 1 && k <= N
                phi_new(i) = phi_new(i) + h(l+1) * phi(k);
            end
        end
    end
    phi = phi_new;
end

%% Compute psi(x)
psi = zeros(1, N);
for i = 1:N
    for l = 0:9
        k = round((2*x(i) - l) / dx) + 1;
        if k >= 1 && k <= N
            psi(i) = psi(i) + g(l+1) * phi(k);
        end
    end
end

%% Plot phi and psi
figure;
subplot(2, 1, 1);
plot(x, phi, 'b-');
title('Scaling Function \phi(x)');
xlabel('x');
ylabel('\phi(x)');
grid on;

subplot(2, 1, 2);
plot(x, psi, 'r-');
title('Wavelet Function \psi(x)');
xlabel('x');
ylabel('\psi(x)');
grid on;

%% Print and Export
integral_approx = sum(phi .* psi) * dx;
disp(['Approximate integral of phi*psi over [0,9]: ', num2str(integral_approx)]);
if abs(integral_approx) < 1e-3
    disp('Orthogonality condition is verified.');
else
    disp('Orthogonality condition is not verified.');
end

set(gcf, 'Position', [100, 100, 1600, 900]);
ax = findobj(gcf, 'Type', 'axes');
for i = 1:length(ax)
    set(ax(i), 'FontSize', 18);
end
exportgraphics(gcf, 'Problem3.pdf', 'ContentType', 'vector');