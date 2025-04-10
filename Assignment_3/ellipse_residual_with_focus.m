function r = ellipse_residual_with_focus(p, x, y)
    % Extract ellipse parameters
    a = p(1); b = p(2); 
    x0 = p(3); y0 = p(4);
    theta = p(5);

    % Compute geometric constraint: focus should be at origin
    c = sqrt(a^2 - b^2);                  % Distance from center to focus
    focus_error = sqrt(x0^2 + y0^2) - c;  % Difference from origin
    focus_penalty = 10 * focus_error;     % Enforce this as soft constraint (scaled)

    % Rotate and translate points into ellipse's coordinate system
    cos_t = cos(theta); sin_t = sin(theta);
    x_shifted = x - x0;
    y_shifted = y - y0;
    x_rot = cos_t * x_shifted + sin_t * y_shifted;
    y_rot = -sin_t * x_shifted + cos_t * y_shifted;

    % Algebraic ellipse equation residuals: should be close to 1
    ellipse_eq = (x_rot / a).^2 + (y_rot / b).^2 - 1;

    % Combine residuals
    r = [ellipse_eq; focus_penalty];
end
