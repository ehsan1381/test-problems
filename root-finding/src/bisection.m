function [ root ] = bisection(func, range, tolerance)
  Start = range(1);
  End = range(2);


  % This MAX_N is computed using the error bound formula for bisection method
  MAX_N = ceil( ( log( End - Start ) - log( TOL ) ) / log( 2 ) );

  iterations = 1;
  root = 0;
  midpoint = (Start+End)/2;
  
  % in case Start, End or midpoint are good enough
  if func(Start) < tolerance
    root = Start;
    return ;
  elseif func(End) < tolerance
    root = End;
    return ;
  
  else      
    while iterations <= MAX_N
      midpoint = (Start+End)/2;
      fstart = func(Start);
      fmidpoint = func(midpoint);

      if fstart * fmidpoint < 0
        End = midpoint;
      else
        Start = midpoint;
      end % if
      iterations = iterations + 1;
  end % while

  root = midpoint;
end % function
