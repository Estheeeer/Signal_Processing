clear all; close all;
% autocorrelate codes in the specification as required
% calculate PSL of the output of the autocorrelations
alternate = [1 -1 1 -1 1 -1 1 -1 1 -1 1];
as = xcorr(alternate); % auto correlation
chip11 = [1 -1 1 1 -1 1 1 1 -1 -1 -1];
c11 = xcorr(chip11,chip11);
chip13 = [-1 1 -1 1 -1 -1 1 1 -1 -1 -1 -1 -1];
c13 = xcorr(chip13);
subplot(3,1,1); plot(as);
title('alternating series of length N = 11');
subplot(3,1,2); plot(c11);
title('N = 11 chip Barker code');
subplot(3,1,3);plot(c13);
title('N = 13 chip Barker code');

% PSL: find sidelobes from figures
PSLas = 20*log10(9);
PSL11 = 20*log10(1);
PSL13 = 20*log10(1);



