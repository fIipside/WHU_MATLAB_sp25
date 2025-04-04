%----------Problem 4-----------
warning('off', 'all');
diary('output4.txt');
diary on;

clc; clear; close all;

n = [1, 2, 10];
n_particles = 100;
max_iter = 100;
w = 0.7;            % Inertia Weight
c1 = 1.5;           % Cognitive Parameter
c2 = 1.5;           % Social Parameter
bounds = [-5, 5];   % Search Range

% Ackley function
ackley = @(x) -20 * exp(-0.2 * sqrt(sum(x.^2) / length(x))) ...
              - exp(sum(cos(2*pi * x)) / length(x)) + 20 + exp(1);

for i = n
    fprintf('Running PSO for n = %d\n', i);

    if i == 10
        % More Particles and Iterations
        n_particles = 10000;
        max_iter = 500;
    end
    
    % Initialize particles
    positions = bounds(1) + (bounds(2) - bounds(1)) * rand(n_particles, i);
    velocities = zeros(n_particles, i);
    pbest = positions;
    gbest = positions(1, :);
    pbest_fitness = zeros(n_particles, 1);
    for j = 1:n_particles
        pbest_fitness(j) = ackley(pbest(j, :));
    end
    gbest_fitness = ackley(gbest);    
    history = zeros(max_iter, i);

    % Initialize a Video Object
    if i == 1
        video_filename = 'pso_optimization.avi'; 
        v = VideoWriter(video_filename, 'MPEG-4');
        v.FrameRate = 10;
        open(v);
    end

    for iter = 1:max_iter
        if i == 10
            % Early Stage (large c1): Particles Explore More Possible Solutions.
            c1 = 2.5 - iter * (2.5 - 0.5) / max_iter;
            % Late Stage (large c2): Particles Focus on the Optimal Solution, Improving the Convergence Speed.
            c2 = 0.5 + iter * (2.5 - 0.5) / max_iter;
            w = 0.4;
        end

        for j = 1:n_particles
            p = positions(j, :);
            fitness = ackley(p);
            
            % Update Personal Best
            if fitness < pbest_fitness(j)
                pbest(j, :) = p;
                pbest_fitness(j) = fitness;
            end
            
            % Update Global Best
            if fitness < gbest_fitness
                gbest = p;
                gbest_fitness = fitness;
            end
        end

        for j = 1:n_particles
            r1 = rand();
            r2 = rand();
            
            % Update Velocity
            velocities(j, :) = w * velocities(j, :) + ...
                                c1 * r1 * (pbest(j, :) - positions(j, :)) + ...
                                c2 * r2 * (gbest - positions(j, :));
            
            % Update Position
            new_position = positions(j, :) + velocities(j, :);
            
            % Boundary handling
            new_position = max(min(new_position, bounds(2)), bounds(1));
            
            positions(j, :) = new_position;
        end
    
        history(iter) = gbest_fitness;
        
        % Visualization
        if i == 1
            clf;
            fplot(ackley, bounds, 'k-', 'LineWidth', 2);
            hold on;
            scatter(positions, arrayfun(ackley, positions), 'ro', 'filled');
            scatter(gbest, ackley(gbest), 'b*', 'LineWidth', 2);
            title(sprintf('Iteration %d, Best Value: %.4f', iter, gbest_fitness));
            xlabel('x');
            ylabel('f(x)');
            frame = getframe(gcf);
            writeVideo(v, frame);
            pause(0.05);
        end
    end

    if i == 1
        close(v);
        fprintf('Video saved as %s\n', video_filename);
    end
    
    % Print the Final Result
    fprintf('Best solution found for n=%d: %.6f\n', i, gbest_fitness);
    
    % Plot Convergence Curve
    figure;
    plot(history, 'LineWidth', 2);
    xlabel('Iteration');
    ylabel('Best Fitness');
    title(sprintf('PSO Convergence for n=%d', i));
    grid on;
    
    set(gca, 'FontSize', 18);
    set(gcf, 'Position', [100, 100, 1600, 900]);
    exportgraphics(gcf, sprintf('Problem4_n%d.pdf', i), 'ContentType', 'vector');
end

diary off;