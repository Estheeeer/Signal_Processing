function [Mdb,sidedb,side2main,variancedb] = BarkerCombine(Barker1,Barker2)
% function [side2main] = BarkerCombine(Barker1,Barker2)
Barker12 = longBarker(Barker1,Barker2);
B12 = xcorr(Barker12);
plot(B12);

% PKS = findpeaks(B213); % peaks 
[M,I] = max(B12); % mainlobe
Mdb = 20*log10(M); % mainlobe in db

B12(I) = 0; % set mainlobe to 0
mu = mean(abs(B12)); % find the mean value
sidedb = 20*log10(mu);
side2main = sidedb-Mdb; % division is subtraction in log10
variance = var(abs(B12));
variancedb = 20*log10(variance);
end

