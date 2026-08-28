function [root, nIterations] = rootfinding(func, dfunc, range, tolerance, MAX_N)
	arguments
		func function_handle
 		dfunc function_handle
		range (2,1) double
		tolerance (1, 1) double {mustBeNonzero} = 1e-6
		MAX_N (1, 1) int32 = 20
	end % arguments
    % run bisection for a crude approximation
    [bisectionApproximation, bisectionNIterations] = bisection(func, range, tolerance * 1e3);

	% in case bisectionApproximation is good enough
	if abs(func(bisectionApproximation)) <= tolerance
		root = bisectionApproximation;
		nIterations = bisectionNIterations;
		return ; 
    else
		[root, newtonNIterations] = newtonraphson(func, dfunc, bisectionApproximation, tolerance);
		nIterations = newtonNIterations + bisectionNIterations;
	end % if
end
