tolerance = 1e-14;
condition = @(approx, correct)(abs(approx - correct) <= tolerance);
%% BASICS TESTS OF CORRECTNESS
f = @(x)(x);
df = @(x)(1);
g = @(x)(x.^2 - 2);
dg = @(x)(2.*x);
h = @(x)(x-3);
dh = @(x)(1);

[rootF, nIterationsF] = rootfinding(f, df, [-1, 1], tolerance);
[Rootg, nIterationsG] = rootfinding(g, dg, [0, 2], tolerance);
[Rooth, nIterationsH] = rootfinding(h, dh, [0, 5], tolerance);

assert(condition(rootF, 0))
assert(condition(Rootg, sqrt(2)))
assert(condition(Rooth, 3))

%% ACCURACY AND STABILITY
condition = @(approx, correct)(abs(approx - correct) <= tolerance);
f = @(x)(cos(x) - x);
df = @(x)(-sin(x) - 1);

[rootF, nIterationsF] = rootfinding(f, df, [0, 1], tolerance);

CorrectRootf = 0.73908513321516064165531208767387;
assert(condition(rootF, CorrectRootf))


%% MULTIPLE ROOTS
f = @(x)((x-2).^2);
df = @(x)(2.*(x-2));

[rootF, nIterationsF] = rootfinding(f, df, [-3, 3], tolerance);

assert(condition(rootF, 2) || condition(rootF, -2))