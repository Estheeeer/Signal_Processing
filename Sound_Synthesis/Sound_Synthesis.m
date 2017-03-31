%part 1:
Fs = 8000;

t1 = 0: 1 / Fs: 4 * 0.5 - (1/ Fs);
t2 = 0 : 1 / Fs: 2 * 0.5 - (1/ Fs);
t4 = 0: 1/ Fs: 0.5 - (1 /Fs);

yA1 = cos(2 * pi * 220 .* t1);
yA2 = cos(2 * pi * 220 .* t2);
yA4 = cos(2 * pi * 220 .* t4);
yB4 = cos(2 * pi * 220 * 2 ^ (2 / 12) .* t4);
yC4 = cos(2 * pi * 220 * 2 ^ (3 / 12) .* t4);
yE4 = cos(2 * pi * 220 * 2 ^ (7 / 12) .* t4);
yz = zeros(1, 200);

y = [yA2, yz, yA4, yz, yE4, yz, yE4, yz, yE4, yz, yB4, yz, yC4, yz, yB4, yz, yA1];

%part 2:
% for t1;
t_new = (0:length(y)-1) * (1/Fs);
A1 = linspace(0, 1.1, 0.1*(length(t1)));    %rise 10% of signal      
D1 = linspace(1.1, 0.9, 0.15*(length(t1))); %drop of 15% of signal
S1 = linspace(0.9, 0.9, 0.6*(length(t1))); %delay of 60% of signal
R1 = linspace(0.9, 0, 0.15*(length(t1))); %drop of 15% of signal
ADSR1 = [A1 D1 S1 R1];
plot(t1, ADSR1);
% for t2;
A2 = linspace(0, 1.1, 0.1*(length(t2)));    %rise 10% of signal      
D2 = linspace(1.1, 0.9, 0.15*(length(t2))); %drop of 15% of signal
S2 = linspace(0.9, 0.9, 0.6*(length(t2))); %delay of 60% of signal
R2 = linspace(0.9, 0, 0.15*(length(t2))); %drop of 15% of signal
ADSR2 = [A2 D2 S2 R2];

% for t4;
A4 = linspace(0, 1.1, 0.1*(length(t4)));    %rise 10% of signal      
D4 = linspace(1.1, 0.9, 0.15*(length(t4))); %drop of 15% of signal
S4 = linspace(0.9, 0.9, 0.6*(length(t4))); %delay of 60% of signal
R4 = linspace(0.9, 0, 0.15*(length(t4))); %drop of 15% of signal
ADSR4 = [A4 D4 S4 R4];

y_new0 = ADSR2 .* yA2;
y_new1 = ADSR4 .* yA4;
y_new2 = ADSR4 .* yE4;
y_new3 = ADSR4 .* yE4;
y_new4 = ADSR4 .* yE4;
y_new5 = ADSR4 .* yB4;
y_new6 = ADSR4 .* yC4;
y_new7 = ADSR4 .* yB4;
y_new8 = ADSR1 .* yA1;

y_new = [y_new0([1: 7800]), y_new0([7801 : end]) + y_new1([1: 200]), y_new1([201: 3900]), y_new1([3901: 4000])];
y_new = [y_new, y_new2([1: 100]), y_new2([101: 3900]), y_new2([3901: 4000]) + y_new3([1: 100]), y_new3([101: 3900])];
y_new = [y_new, y_new3([3901: 4000]) + y_new4([1: 100]), y_new4([101: 3900]), y_new4([3901: end]) + y_new5([1: 100])];
y_new = [y_new, y_new5([101: 3900]), y_new5([3901: end])+ y_new6([1: 100]), y_new6([101: 3900]), y_new6([3901: end]) + y_new7([1: 100])];
y_new = [y_new, y_new7([101: 3900]), y_new7([3901: end]) + y_new8([1: 100]), y_new8([101: end])];

audiowrite('ImprovedSound.wav', y_new, Fs);

%part 3:
t = 0 : 1 / Fs: 10 - (1 /Fs);
randNum = randn([1 10 * Fs]);
z = randNum .* cos (2 * pi * 80 .* t) .* exp(- t / 2);
z1 = randNum .* cos (2 * pi * 5 .* t) .* exp(- t / 2);
audiowrite('SeaSound.wav', z, Fs);

%part 4:
[tiger,fs_t] = audioread('tiger.wav'); 
[cat, fs_c] = audioread('cat.wav');

tiger_new = resample(cat, 5, 2);

audiowrite('ScaledCatSound.wav',tiger_new, 2 * fs_c / 5);
sound(tiger_new, 2 * fs_c / 5);