function [ integralApproximation, nPartitions ]  = integration(f, interval, tolerance, nParts)
%    arguments
%        f function_handle
%        interval (1, 2)
%        tolerance double {mustBeNonzero, mustBeNumeric} = 1e-3
%        nParts int32 {mustBeNonzero, mustBeNumeric} = 100  
%    end % arguments

    % divide interval into partitions
    [partitionsArr, nPartitions]  = divide(f, interval, tolerance);

    integrationsArr = zeros([nPartitions, 1]);

    % integrate and populate the array
    for iPartition = 1:nPartitions
        integrationsArr(iPartition) = trapezoid(f, partitionsArr(iPartition, :), nParts);
    end % for

    % sum and return data
    integralApproximation = sum(integrationsArr);
end % function integration

function [integralApproximation] = trapezoid(f, interval, nParts)
    xArr = linspace(interval(1), interval(2), nParts);
    yArr = f(xArr);

    width = (interval(2) - interval(1)) / (nParts - 1);
    area = @(length1, length2)(0.5 * width * (length1 + length2));

    integrationsArr = zeros([nParts - 1, 1]);
    for iPartition = 1:(nParts - 1)
        integrationsArr(iPartition) = area(yArr(iPartition), yArr(iPartition + 1));
    end % for

    integralApproximation = sum(integrationsArr);
end % function trapezoid 


function [partitions, iPartitions] = divide(f, interval, tolerance)
  N_PARTITIONS = 1e2;
  MAX_ITERATIONS = 1e4;
  partitions = zeros([MAX_ITERATIONS, 2]);
  iPartitions = 0;
  disp("Starting to divide");
  tic; 
  intervalStart = interval(1);
  intervalEnd = interval(2);
  intervalLength = intervalEnd - intervalStart;
  
  while sum(intervalStart ~= intervalEnd) && iPartitions <= MAX_ITERATIONS
      fIntervalStart = f(intervalStart);
      fIntervalEnd = f(intervalEnd);
      intervalLength = intervalEnd - intervalStart;
      slope = (fIntervalEnd - fIntervalStart) / intervalLength;
      line = @(x)(slope * (x - intervalStart) + fIntervalStart);
      fMax = max([fIntervalStart, fIntervalEnd]);

      fDifference = @(x)(f(x) - line(x));
      % difference = abs(trapezoid(fDifference, [intervalStart, intervalEnd], N_PARTITIONS) / fMax);
      difference = abs(trapezoid(fDifference, [intervalStart, intervalEnd], N_PARTITIONS));
      if difference <= tolerance * 1e4
          iPartitions = iPartitions + 1;
          disp([intervalStart, intervalEnd]);
          partitions(iPartitions, :) = [intervalStart, intervalEnd];
          intervalStart = interval(1);
          intervalEnd = interval(2);
          interval = [intervalEnd, intervalEnd];


      else
          midpoint = (intervalStart + intervalEnd) / 2;
          interval(1) = midpoint; 
          intervalEnd = midpoint;

      end % if-else
      
  end % while
  disp("Division over");
  toc;
end % function divide
