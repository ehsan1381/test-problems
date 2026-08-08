tolerance = 1e-12;
nParts = 100;

f = @(x)(abs(x));
interval = [-1, 1];
[integralApproximation, nPartitions ]  = integration(f, interval, tolerance, nParts)
%
f = @(x)(log(x));
interval = [1, exp(1)];
[integralApproximation, nPartitions ]  = integration(f, interval, tolerance, nParts)
%
%
f = @(x)(cos(x));
interval = [0, pi/2];
[integralApproximation, nPartitions ]  = integration(f, interval, tolerance, nParts)
%
%
f = @(x)(sin(x));
interval = [ -pi/2, pi/2];
[integralApproximation, nPartitions ]  = integration(f, interval, tolerance, nParts)
%

f = @(x)(1./(sqrt(1-log(x))));
interval = [0, e];
[integralApproximation, nPartitions ]  = integration(f, interval, tolerance, nParts)


