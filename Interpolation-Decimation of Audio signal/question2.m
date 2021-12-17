%% Polyphase filter
clc;
%% Initializing the variables
% From the given information the values of x and h are initialized.
% y is given by the convolution of x and h.
x=[16,13,6,-3,-9,-1,-10,-6,-2,-0.3];
h=[-0.1,0,0.3,1,0.3,0,-0.1];
figure;
subplot(2,1,1);stem(x);
title("Signal x(n)");
xlabel("Number of samples"); ylabel("Value of sample");
subplot(2,1,2);stem(h);
title("Signal h(n)");
xlabel("Number of samples"); ylabel("Value of sample");
y=conv(x,h);
%% Decomposition into polyphase components
% Using the decomposition factor M=2, the filter h is decomposed into 2
% polyphase filters p0 and p1.
M=2;
p0=downsample(h,2);
p1=downsample(h,2,1);
%% Downsampling
% x is downsampled by a factor 2 into two signals. x1 is downsampled
% without and phase shift while x2 is downsampled and phase shifted by 1
% sample. After downsampling, a delay is introduced to signal x2 by padding
% 0 in the beginning.
x1=downsample(x,2);
x2=downsample(x,2,1);
x2=[0 x2];
%% Convolution
% The downsampled polyphase filter and input signal are convolved
% individually. Two convolved signals y1 and y2 are generated.
y1=conv(x1,p0);
y2=conv(x2,p1);
%% Plotting y1 and y2
figure;
title("Two convolved signals y1(n) and y2(n)");
subplot(1,2,1);
stem(y1);
title("Signal y1(n)");
xlabel("Number of samples"); ylabel("Value of sample");
subplot(1,2,2);
stem(y2);
title("Signal y2(n)");
xlabel("Number of samples"); ylabel("Value of sample");
%% Plotting y=x*h and y=y1+y2
% After plotting the comparison between y and y_sum, the relation between
% them is clear. The signal y_sum is the downsampled version of y. The
% factor of downsampling is 2 which is also the factor with which we have
% downsampled h and x.
y_sum=y1+y2;
figure;
title("Comparison between y(n)=x(n)*h(n) and y(n)=y1(n)+y2(n)");
subplot(2,1,1);
stem(y);
title("Signal y(n)=x(n)*h(n)");
xlabel("Number of samples"); ylabel("Value of sample");
subplot(2,1,2);stem(y_sum);
title("Signal ysum(n)=y1(n)+y2(n)");
xlabel("Number of samples"); ylabel("Value of sample");

