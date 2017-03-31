close all; clear all; clc

% ---- problem 1 ----

% Generate a 5 second cosine of frequency 200 Hz assuming an 8kHz
% sampling rate
Fs = 8000;
Fo = 200;
t = 0:1/Fs:5;
x = cos(200.*t);

% First 50 samples using a stem plot with integer times
figure;
n = 0:49;
t_50 = 0:1/Fs:49/Fs;
x_50 = cos(2*pi*Fo.*t_50);
stem(n, x_50);
title('First 50 Samples of Cosine Signal in Discrete-Time');
xlabel('n');
ylabel('x');

% First 50 samples using regular plot function with the C.T.
figure;
plot(t_50, x_50);
title('First 50 Samples of Cosine Signal in Continuous-Time');
xlabel('t(s)');
ylabel('x');

% Wave file generated with cosine function
audiowrite('cosine.wav',x,Fs);
[x,Fs] = audioread('cosine.wav');
sound(x, Fs);


% ---- problem 2 ----

% read the audio file and get the sample frequency
[y,Fs] = audioread('cat.wav');

% play the sound
% sound(y, Fs);

% First 50 samples using a stem plot with integer times
figure;
y_50 = y(1:50);
stem(n, y_50);
title('First 50 Samples of cat.wav in Discrete-Time');
xlabel('n');
ylabel('y');

% First 50 samples using regular plot function with the C.T.
figure;
plot(t_50, y_50);
title('First 50 Samples of cat.wav in Continuous-Time');
xlabel('t(s)');
ylabel('y');


% ---- problem 3 ----

% change the scale of each signal in order to change the loundness
[y,Fs] = audioread('cat.wav');
y_1 = y;
y_2 = 4*y;
y_3 = 0.1*y;
y_4 = zeros(200, 1);

% cascade the different versions of the signal to create the mymeows
ynew = [y_1;y_4;y_2;y_4;y_3;y_4;y_1];

% save mymeows into a audio file and read it
filename = 'mymeows.wav';
audiowrite(filename,ynew,Fs);
[x,Fs] = audioread(filename);
t = (0:length(x) - 1) * (1/Fs);

% play the sound of mymeous.wav
sound(x, Fs);

% plot the waveform of mymeows signal
figure;
plot(t, x);
title('Plot of mymeows.wav in Continuous-Time');
xlabel('t(s)');
ylabel('x');














