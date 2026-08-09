%% BASIC TESTS OF CORRECTNESS
A = [1, 1, -1, 1;1 1 1 -1;0 1 1 -1; 1 -1 -1 -1]
b = [1;1;-1;-1]
correctSolution = [2; -1; 2; 2]
[solution, relativeRemainder, U] = solvesystem(A, b)
assert(solution == correctSolution)

