function [output] = filter_sg(input_sg,wc)
%FILTER_SG Filter the input signal and plot the frequency and impulse
%response
%   The input to this function is a digital signal and its' cutoff frequency which is convoluted with
%   a signal having impulse function h(n)=0.5*sin(wc*n)/pi*n. The impulse
%   response of the filter is plotted along with its frequency and phase
%   response.
n=-60:1:60; %Impulse response of filter is defined between [-60 60]
filter=0.5*(sin(wc.*n)./(pi.*n)); %Definition of filter
filter(61)=0.5*(wc/pi); %Setting the 0th sample to a definite value
%% Frequency response of the filter
freq_filt=fft(filter);
[h,w]=freqz(filter,1); %Using freqz function to find H(w) from h(n)
dB = mag2db(abs(h));
%disp(dB);
%figure(8);plot(dB);
%%
figure(3);
plot(n,filter); %Plotting the impulse response
title("Filter response in time domain");
%%
figure (4);
subplot(2,1,1);plot(w/pi,20*log10(abs(h))); %Plotting frequency response
title("Magnitude response, Wc="+(wc/pi));
xlabel("w");ylabel("H(w) in dB");

subplot(2,1,2);
plot(w/pi,unwrap(angle(h))*(180/pi)); %Plotting phase response
title("Phase response");
xlabel("w"); ylabel("angel");
%%
figure(5); 
plot(abs(freq_filt(1:60))); %Plotting frequency response of filter without using freqz
title("Without freqz");
%% Filtering the input signal
output=conv(input_sg,filter); %Convolution of singal and filter 

end

