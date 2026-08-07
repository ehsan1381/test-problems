%% BASICS TESTS OF CORRECTNESS
f = @(x)(x)
g = @(x)(x.^2 - 2)
h = @(x)(x-3)
[Rootf, Iterationsf] = rootFinding(f, [-1, 1])
[Rootg, Iterationsg] = rootFinding(g, [0, 2])
[Rooth, Iterationsh] = rootFinding(h, [-1, 1])

assert(Rootf = 0)
assert(Rootg = sqrt(2))
assert(Rooth = 3)


- [ ] Expand tests to include accuracy and stability
	- If outputs are accurate to the expected extent, if algorithm is stable (the precise definition of it)
	- If there are any constants in the program, test for change of base and issues associated with it
%% ACCURACY AND STABILITY
f = @(x)(cos(x) - x)
[Rootf, Iterationsf] = newtonFinding(f, [0, 1])
CorrctRootf = 
assert(Rootf - CorrectRootf < 1e-16)




- [ ] Add tests for underflow and overflow
	- Very large or very small inputs
- [ ] Add tests for 
	- [ ] Input argument types, classes, dimensions, etc.
	- [ ] Output argument types, classes, dimensions, etc.
	- [ ] Number of input and output arguments
		- Passing less than expected
- [ ] Add tests for Halting of the program
%% HALTING
f = @(x)(x.^5)
- [ ] Add tests for Large inputs in terms of input array dimensions
- [ ] Add tests for Ill Conditioned inputs
- [ ] Stress testing
	1. Numerical Limits
		- [ ] Maximum Value ($\pm \text{DBL\_MAX}$)
		- [ ] Minimum Value ($\pm \text{DBL\_MIN}$)
		- [ ] Zero ($0.0$)
		- [ ] Near-Zero ($\pm \text{DBL\_EPSILON}$)
		- [ ] Mixed Large/Small Signs (Catastrophic Cancellation Check)
	2. . Exceptional Values (IEEE 754)
		- [ ] Infinity ($\pm \infty$)
		- [ ] NaN (Not a Number)
		- [ ] Subnormal Numbers
	3. Pathological and Degenerate Inputs
		- [ ] Singular/Ill-Conditioned (e.g., Matrix Condition Number)
		- [ ] Near-Identity/Trivial (Zero/Identity inputs)
		- [ ] Extreme Ratios/Scales
		- [ ] Non-Convergence (for Iterative Methods)
		- [ ] Repeated/Duplicate Values
		- [ ] Zero/Empty Domain (e.g., Integration interval $\Delta x = 0$)
	4. Structured Data Checks
		- [ ] Zero-Sized Input ($0 \times N$ or $N \times 0$)
		- [ ] Maximum Size (Memory Stress)
		- [ ] Square vs. Non-Square (Matrix Dimensions)
		- [ ] Special Matrices (Symmetric, Diagonal, Sparse)
- [ ] Performance testing
	- [ ] CPU Time
	- [ ] Memory usage
	- [ ] Bottlenecks

