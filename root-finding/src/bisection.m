function [ root, nIterations] = bisection(func, range, tolerance)
  START  = range(1);
  END = range(2);


  % This MAX_N is computed using the error bound formula for bisection method
  MAX_N = ceil( ( log( END - START ) - log( tolerance ) ) / log( 2 ) );

  nIterations = 1;
  root = 0;
  middlePoint = (START+END)/2;
  
  % in case START, END or middlePoint are good enough
  if abs(func(START)) < tolerance
    root = START;
    return ;
  elseif abs(func(END)) < tolerance
    root = END;
    return ;
  elseif abs(func(middlePoint)) < tolerance
	root = middlePoint;
	return ;
  else      
    while nIterations <= MAX_N
      middlePoint = (START+END)/2;
      fStart = func(START);
      fMiddlePoint = func(middlePoint);

      if fStart * fMiddlePoint < 0
        END = middlePoint;
      else
        START = middlePoint;
      end % if
      nIterations = nIterations + 1;
  end % while

  root = middlePoint;
end % function
