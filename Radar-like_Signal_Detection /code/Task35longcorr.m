% combine barker codes to create longer length and higher peaks
% by placing one code into another 
% by using function BarkerCombine
clear all; close all;

% length [2 3 4 5 7 11 13] barker codes
Bark2 = [+1 -1];
Bark3 = [+1 +1 -1];
Bark4 = [+1 +1 -1 1];
Bark5 = [+1 +1 +1 -1 +1];
Bark7 = [+1 +1 +1 -1 -1 +1 -1];
Bark11 = [+1 +1 +1 -1 -1 -1 +1 -1 -1 +1 -1];
Bark13 = [+1 +1 +1 +1 +1 -1 -1 +1 +1 -1 +1 -1 +1];

Mdb = [];
sidedb = [];
side2main = [];
variancedb = [];

% combinations
figure(1); % combine 2-13
[Mdb(1),sidedb(1),side2main(1),variancedb(1)] = BarkerCombine(Bark2,Bark13);
title('Barker 2-13 Code');
figure(2); % combine 3-13
[Mdb(2),sidedb(2),side2main(2),variancedb(2)] = BarkerCombine(Bark3,Bark13);
title('Barker 3-13 Code');
figure(3); % combine 4-13
[Mdb(3),sidedb(3),side2main(3),variancedb(3)] = BarkerCombine(Bark4,Bark13);
title('Barker 4-13 Code');
figure(4); % combine 5-13
[Mdb(4),sidedb(4),side2main(4),variancedb(4)] = BarkerCombine(Bark5,Bark13);
title('Barker 5-13 Code');
figure(5); % combine 7-13
[Mdb(5),sidedb(5),side2main(5),variancedb(5)] = BarkerCombine(Bark7,Bark13);
title('Barker 7-13 Code');
figure(6); % combine 11-13
[Mdb(6),sidedb(6),side2main(6),variancedb(6)] = BarkerCombine(Bark11,Bark13);
title('Barker 11-13 Code');
figure(7); % combine 13-13
[Mdb(7),sidedb(7),side2main(7),variancedb(7)] = BarkerCombine(Bark13,Bark13);
title('Barker 13-13 Code');

