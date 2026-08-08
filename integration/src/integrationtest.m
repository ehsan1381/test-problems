tolerance = 1e-12;
nParts = 100;
%% BASIC TETS OF CORRECNTESS
f = @(x)(abs(x));
interval = [-1, 1];
[integralApproximation, nPartitions ]  = integration(f, interval, tolerance, nParts)
correctIntegral = integral(f, interval(1), interval(2));
abs(integralApproximation - correctIntegral)

f = @(x)(log(x));
interval = [1, exp(1)];
[integralApproximation, nPartitions ]  = integration(f, interval, tolerance, nParts)
correctIntegral = integral(f, interval(1), interval(2));
abs(integralApproximation - correctIntegral)

f = @(x)(cos(x));
interval = [0, pi/2];
[integralApproximation, nPartitions ]  = integration(f, interval, tolerance, nParts)
correctIntegral = integral(f, interval(1), interval(2));
abs(integralApproximation - correctIntegral)

f = @(x)(sin(x));
interval = [ -pi/2, pi/2];
[integralApproximation, nPartitions ]  = integration(f, interval, tolerance, nParts)
correctIntegral = integral(f, interval(1), interval(2));
abs(integralApproximation - correctIntegral)

%% TEST OF ACCURACY
f = @(x)(1./(sqrt(1-log(x))));
interval = [0, exp(1)];
[integralApproximation, nPartitions ]  = integration(f, interval, tolerance, nParts)
correctIntegral = integral(f, interval(1), interval(2));
abs(integralApproximation - correctIntegral)