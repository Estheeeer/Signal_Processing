% EE416 Final Project
% Task 1&2

close all; clear all; clc

% -------------------------------- Task 1 --------------------------------

% deterministic parameter
Nt = 1000;
A = 1;
k = 1;
s = [1 1 1 1 1 0 0 1 1 0 1 0 1]';
s = -(-1).^s;
l = length(s);

% correlator V
for n = 1:Nt
    w = randn(l, 1);
    r = A * s + w;
    h_V = k * s;
    V(n) = h_V' * r;
    V_H0(n) = h_V' * w;
    sw = s.*w;
    varsw(n) = var(sw);
end

% plot histogram of V
h_V = histogram(V), hold on;
h_V.Normalization = 'probability'; 

% plot line approximation of histogram of V
Nbins = 30;
N = 4;                                          % N = 3, 4, 5... choose by user
meanV = mean(V);
sigV = sqrt(var(V));
Vend = meanV + [-1*N, N] * sigV;

[xKnt_V, outKnt_V, xCenter_V, xDelta_V] = myHistc(V, Nbins, Vend);

xKntSum_V = sum(xKnt_V);
normHist_V = xKnt_V(:) / xKntSum_V;             % Normalization

figure(1);
plot(xCenter_V, normHist_V, 'b*-'), hold on;    % Plot actual histogram of V

% plot theoretical pdf
vars = var(s);
means = mean(s);

theo_meanV = s'*s;
theo_varV = s'*s;

LBound_V = min(xCenter_V) - xDelta_V/2;
for i = 1:Nbins
    RBound_V = LBound_V + xDelta_V;
    PDF_V(i) = GauPr(LBound_V, theo_meanV, sqrt(theo_varV)) - GauPr(RBound_V, theo_meanV, sqrt(theo_varV));
    LBound_V = LBound_V + xDelta_V;  
end

plot(xCenter_V, PDF_V, 'r+-');  

% chi-square goodness-of-fit test
[~, chi_V] = chi2gof(V);

legend('norHist', 'normHistLine', 'theoPDF'), hold off;
title([{'Distribution of (upper)V'}, {'chi-square goodness-of-fit of (upper)V:', num2str(chi_V)}]);
xlabel('Pr');
ylabel('V');
ylim([0 0.2]);

% Distribution of (lower)v
v = V/sigV;
meanv = mean(v);
varv = var(v);
sigv = sqrt(varv);

% plot histogram of v
figure(2);
h_v = histogram(v), hold on;
h_v.Normalization = 'probability'; 

Nbins = 30;
N = 5;
vend = meanv + [-1*N, N] * (sigv);
[xKnt_v, outKnt_v, xCenter_v, xDelta_v] = myHistc(v, Nbins, vend);
xKntSum_v = sum(xKnt_v);
normHist_v = xKnt_v(:) / xKntSum_v;             % Normalization

% Plot line approximation of histogram of V
plot(xCenter_v, normHist_v, 'b*-'), hold on;  

% plot theoretical pdf
theo_sigV = sqrt(theo_varV);
theo_meanv = theo_meanV/theo_sigV;
theo_varv = theo_varV/theo_varV;

LBound_v = min(xCenter_v) - xDelta_v/2;
for j = 1:Nbins
    RBound_v = LBound_v + xDelta_v;
    PDF_v(j) = GauPr(LBound_v, theo_meanv, sqrt(theo_varv)) - GauPr(RBound_v, theo_meanv, sqrt(theo_varv));
    LBound_v = LBound_v + xDelta_v;  
end

plot(xCenter_v, PDF_v, 'r+-'); 

% chi-square goodness-of-fit test
[~, chi_v] = chi2gof(v);
title([{'Distribution of (lower)v'}, {'chi-square goodness-of-fit of (lower)v:', num2str(chi_v)}]);
legend('norHist', 'normHistLine', 'theoPDF');
xlabel('v');
ylabel('Pr');
ylim([0 0.2]);
hold off

%% -------------------------------- Task 2 --------------------------------

figure(3);

% Plot histogram of signal under H1
h_V = histogram(V), hold on;
h_V.Normalization = 'probability';  

% Plot histogram of noise under H0
h_V_H0 = histogram(V_H0), hold on;
h_V_H0.Normalization = 'probability'; 

% Plot line approximation of histogram of siganl under H1
plot(xCenter_V, normHist_V, 'b*-'), hold on; 

Nbins = 30;
N = 4;
V_H0_end = mean(V_H0) + [-1*N, N] * (sqrt(s'*s));
[xKnt_V_H0, outKnt_V_H0, xCenter_V_H0, xDelta_V_H0] = myHistc(V_H0, Nbins, V_H0_end);
xKntSum_V_H0 = sum(xKnt_V_H0);
normHist_V_H0 = xKnt_V_H0(:) / xKntSum_V_H0; % Normalization

% plot theoretical pdf of signal under H1
plot(xCenter_V, PDF_V, 'r+-'); 

% Plot line approximation of histogram of noise under H0
plot(xCenter_V_H0, normHist_V_H0, 'b*-'), hold on;  

% plot theoretical pdf of signal under H0
theo_mean_V_H0 = 0;
theo_var_V_H0 = s'*s;
LBound_V_H0 = min(xCenter_V_H0) - xDelta_V_H0/2;
for j = 1:Nbins
    RBound_V_H0 = LBound_V_H0 + xDelta_V_H0;
    PDF_V_H0(j) = GauPr(LBound_V_H0, theo_mean_V_H0, sqrt(theo_var_V_H0)) - GauPr(RBound_V_H0, theo_mean_V_H0, sqrt(theo_var_V_H0));
    LBound_V_H0 = LBound_V_H0 + xDelta_V_H0;  
end

plot(xCenter_V_H0, PDF_V_H0, 'r+-'); 

legend('norHist(V)', 'norHist(w)', 'normHistLine');
title([{'Distribution of (upper)V'}, {'chi-square goodness-of-fit of (upper)V:', num2str(chi_V)}]);
xlabel('V');
ylabel('Pr');
ylim([0 0.2]);

% Use the theoredical value to get Pfa, Pd, vo
Pfa = [10^-1, 10^-2, 10^-3, 10^-4];
v0(:,:) = qfuncinv(Pfa) * (sqrt(s'*s));    % Pfa = Q(v0 / sqrt(var(V_H0))) solve for v0
Pd = GauPr(v0, s'*s, sqrt(s'*s));

line([v0(1) v0(1)], [0 0.18], 'Color', 'g'), hold on;
line([v0(2) v0(2)], [0 0.18], 'Color', 'g'), hold on;
line([v0(3) v0(3)], [0 0.18], 'Color', 'g'), hold on;
line([v0(4) v0(4)], [0 0.18], 'Color', 'g'), hold off;

display('-----------  Table of Pfa, v0 and Pd  -----------');
display(['Pfa:   ', num2str(Pfa)]);
display(['v0:  ', num2str(v0)]);
display(['Pd:   ', num2str(Pd)]);
display('-------------------------------------------------');

% plot Pd vs S
SNRdB = linspace(0, 25, 26);
SNR = 10.^(SNRdB/10);
mean_new_V = sqrt(SNR/(s'*s))*(s'*s);
var_new_V = sqrt(s'*s);

figure(4);
for i = 1:4
    Pd = GauPr(v0(i), mean_new_V, var_new_V);
    semilogy(SNRdB, Pd), hold on;
end

legend('V0~=4.5', 'V0~=8.2', 'V0~=11.0', 'V0~=13.2');
xlabel('SNR(dB)');
ylabel('Pd');
title('Pd vs SNR(dB)');

