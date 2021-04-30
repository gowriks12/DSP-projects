clc;
%% Sampling the input signal 
% The input signal is sampled with the initial sampling frequency of 6000Hz
% and a part of the input signal which is interfered with noise is plotted.
I=6; D=2; %Example I and D values
fs=6000; %Initial sampling frequency
t=0:1/fs:3; %Since the resulting number of samples is 3*sampling frequency
Noise = 1*randn(size(t)) + 0; %random noise with zero mean and standard deviation equal to 1
sampled_inp=10*cos((2*pi*890).*t)+5*cos((2*pi*385).*t)+4*cos((2*pi*1450).*t)+Noise; %Example signal
figure(1);
plot(sampled_inp(1:1000)); %Plotting 1000 samples of the input signal
title("Part of the input signal, fs="+fs);
xlabel("n-->");ylabel("Amplitude");
%% Sampling rate conversion
% The sampling rate of the input signal is converted by a factor of I/D.
% Part of the output signal with sampling frequency fs*(I/D) is plotted.
[output_sg,fs_out]=SamplingRateConverter(sampled_inp,I,D,fs); %Calling the function sampling rate converter
figure(7);
plot(output_sg(1:1000)); %Plotting 1000 samples of output signal
title("Part of the output signal, fs="+fs_out);
xlabel("n-->");ylabel("Amplitude");
