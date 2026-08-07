function [ root ] = newtonRaphson(func, dfunc, init, tolerance, MAX_N)
  LoopCounter = 1;
  % There is absolutely no reason for this choice of bound
  % It is there to prevent infinite loops
  MAX_N = 5e1;

  root = init;
  funcValue = func(init);

  while (LoopCounter <= MAX_N) & (abs(funcValue) >= tolerance)
    % handle dfunc too close to 0
    root = root - funcValue / dfunc(root);
    funcValue = func(root);
    LoopCounter = LoopCounter + 1;
  end

end % function
