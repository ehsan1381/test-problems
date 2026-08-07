function [root, iterations] = rootFinding(func, dfunc, range, tolerance, MAX_N)
    % input and output verification

    % run bisection for a crude approximation
    [init_root, bisection_iterations] = bisection(func, range, 1e-4);

    % run newtonRaphson to obtain accurate solution
    [root, newton_iterations] = newtonRaphson(func, dfunc, init, tolerance);
    iterations = newton_iterations + bisection_iterations;   
end
