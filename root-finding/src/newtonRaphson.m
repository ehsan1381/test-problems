function [ root, nIterations ] = newtonraphson(func, dfunc, initRoot, tolerance, MAX_N)
  nIterations = 1;
  % There is absolutely no reason for this choice of bound
  % it's only purpose is to prevent infinite loops
  MAX_N = 1e4;

  root = initRoot;
  fRoot = func(initRoot);

  while (nIterations <= MAX_N) & (abs(fRoot) >= tolerance)
    root = root - fRoot / dfunc(root);
    fRoot = func(root);
    nIterations = nIterations + 1;
  end % while
end % function
