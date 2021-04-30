function [output_sg,out_samp_rate] = SamplingRateConverter(input_sg,I,D,fs)
%SAMPLINGRATECONVERTER Multirate sampling rate converter
%   This function converts the sampling rate of the input signal by a
%   factor I/D. Input to the function is x(n), input signal whose sampling
%   rate has to be converted. I is the interpolating factor, D is the
%   decimating factor. fs is the original sampling frequency of the signal.
%% Determining cutoff frequency
wc= min((pi/I),(pi/D)); % cutoff frequency 
%disp(wc);
%% Upsampling
sg_up = upsample(input_sg,I); %upsampling the input signal by a factor of I
fs_u=fs*I; %Determining the sampling frequency after upsampling
figure(2);
plot(sg_up(1:1000),'red'); %Plotting 1000 samples of upsampled signal
title("Upsampled input signal, fs="+fs_u);
xlabel("n-->");ylabel("Amplitude");
%% Filtering
filtered=filter_sg(sg_up,wc); %Filtering the upsampled signal using function filter_sg
figure(6);
plot(filtered(1:1000),'green'); %Plotting 1000 sampled of filtered signal
title("Filtered signal");
xlabel("n-->");ylabel("Amplitude");
%% Downsampling
output_sg=downsample(filtered,D); %Downsampling the filtered signal by factor D
out_samp_rate= fs_u/D; %Determining output sampling rate

end

