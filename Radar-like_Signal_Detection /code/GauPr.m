% Function GauPr is used to calculate the cdf of gaussian distribution

% ouput Pr = probability of (X > x);
% input x = interested value;
% input m = mean of the Gaussian Distribution;
% input sig = square root of variance of the Gaussian Distribution


function [Pr] = GauPr(x, m, sig)

erf1 = 0.5 * (1+erf((x-m)/(sqrt(2)*sig)));
Pr = 1 - erf1;

end
