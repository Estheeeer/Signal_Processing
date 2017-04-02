clear all; close all;

load('SGroup4');
Bark13 = [+1 +1 +1 +1 +1 -1 -1 +1 +1 -1 +1 -1 +1];
d = conv(fliplr(Bark13),rcvd); % matched filter convolution

Pfa = 0.74e-7; % adjust false alarm to change threshold 
% when Pfa = 0.74e-7, we have 10 peaks from d (SGroup4)
% when Pfa = 3e-4, we have 20 peaks from d (SGroup0)
v0(:,:) = qfuncinv(Pfa)*(sqrt(Bark13*Bark13'));

pks = [];
loc = [];
count = 0;
for i = 1:length(d)
    if d(i) > v0  % compare each number to threshold
        count = count+1;
        pks(count) = d(i);
        loc(count) = i;
    end
end
TOA = loc-12; % time shift; indexes of rcvd
disp('                 Starting times of 10 signals');
disp(TOA);

% largest 10 method
[sortedD,sortIndex] = sort(d,'descend');

disp(sort(sortIndex(1:10)'-12,'ascend'));