%% Image conpression using Biorthogonal Coiflets
%% Procedure to follow
% Consider an image
% Convert it to gray scale
% Process each row of the image matrix with trend function
% Process each row of matrix with deviation function
% Process each column of the trand and deviated image with trend
% and deviation functions
% 4 images are obtained
%%
%inp=imread('illustration-02.jpg');
inp=imread('1829422454.jpg');
%inp=imread('me.jpg');
%figure, imshow(inp);
%whos inp;
inp_image = rgb2gray(inp);
figure; 
subplot(1,2,1),imshow(inp); title("Input image");
subplot(1,2,2);imshow(inp_image); title("Input gray scale image");
%% First level analysis 
figure;
trend1=trend_bc(inp_image,1);trend1=cast(real(trend1),'uint8');
subplot(1,2,1), imshow(trend1); title("Rows processed trend");
dev1=deviation_bc(inp_image,1); dev1=cast(real(dev1),'uint8');
subplot(1,2,2), imshow(dev1); title("Rows processed deviation");
%% Second level in trend branch
figure;
trend12=trend_bc(trend1,2);trend12=cast(real(trend12),'uint8');
subplot(2,2,1), imshow(trend12); title("Trend Column trend");
dev12=deviation_bc(trend1,2); dev12=cast(real(dev12),'uint8');
subplot(2,2,2), imshow(dev12); title("Trend Column dev");
%Second level in deviation branch
trend21=trend_bc(dev1,2);trend21=cast(real(trend21),'uint8');
subplot(2,2,3), imshow(trend21); title("Dev Column trend");
dev21=deviation_bc(dev1,2);dev21=cast(real(dev21),'uint8');
subplot(2,2,4), imshow(dev21); title("Dev Column dev");
%% Reconstruction
%% Reconstruction filters
low=[-0.00552427172802,0.0276213586401,-0.0276213586401,-0.1104854345604,0.3866990209614,0.87283493302715,0.3866990209614,-0.1104854345604,-0.0276213586401,0.0276213586401,-0.00552427172802];
for i=1:length(low)
    g1(i)= -(((-1)^(i-1))*low(i));
end
high = [0.000034211591536,-0.00017105795768,-0.000074275165835,0.0019108974483,-0.002628890718028,-0.0152750254683,0.0155482680481,0.0802644451161,-0.03819994286504,-0.4202826497317,0.75774803940516,-0.4202826497317,-0.03819994286504,0.0802644451161,0.0155482680481,-0.0152750254683,-0.002628890718028,0.0019108974483,-0.000074275165835,-0.00017105795768,0.000034211591536];
for i=1:length(high)
    g0(i)=((-1)^(i-1))*high(i);
end
%% First level Trend branch
trend_re1=[]; trend_re2=[];
[row,col]=size(trend12);
for i=1:1:col
        temp=trend12(:,i);
        res=upsample(temp,2);
        res_d=cconv(res,g0,row);
        trend_re1=[trend_re1,res_d];

end
[row,col]=size(dev12);
for i=1:1:col
        temp=dev12(:,i);
        res=upsample(temp,2);
        res_d=cconv(res,g1,row);
        trend_re2=[trend_re2,res_d];
end
trend_re=trend_re1.*trend_re2;
%% First level dev branch
dev_re1=[];
[row,col]=size(trend21);
for i=1:1:col
        temp=trend21(:,i);
        res=upsample(temp,2);
        res_d=cconv(res,g0,row);
        dev_re1=[dev_re1,res_d];
end
dev_re2=[];
[row,col]=size(dev21);
for i=1:1:col
        temp=dev21(:,i);
        res=upsample(temp,2);
        res_d=cconv(res,g1,row);
        dev_re2=[dev_re2,res_d];
end
dev_re=dev_re1.*dev_re2;
%%
trend_re=cast(real(trend_re),'uint8');
dev_re=cast(real(dev_re),'uint8');
figure; subplot(1,2,1),imshow(trend_re);title("Reconstructed trend");
subplot(1,2,2), imshow(dev_re);title("Reconstructed deviation");
%% Final
im1=[];
[row,col]=size(trend_re);
for i=1:1:row
        temp=trend_re(i,:);
        res=upsample(temp,2);
        res_d=cconv(res,g0,col);
        im1=[im1;res_d];
end
im2=[];
[row,col]=size(dev_re);
for i=1:1:row
        temp=dev_re(i,:);
        res=upsample(temp,2);
        res_d=cconv(res,g1,col);
        im2=[im2;res_d];
end
%%
re_img=im2.*im1;

re_image = cast(real(re_img), 'uint8');
figure;
subplot(1,2,1),imshow(im1);
subplot(1,2,2),imshow(im2);
figure, imshow(re_image);title("Reconstructed Image");
%%
%% Reconstruction filters

for i=1:length(low)
    g1(i)= -(((-1)^(i-1))*low(i));
end

for i=1:length(high)
    g0(i)=((-1)^(i-1))*high(i);
end
%%
%% First level Trend branch
trend_re1=[]; trend_re2=[];
[row,col]=size(trend12);
for i=1:1:row
        temp=trend12(i,:);
        res=upsample(temp,2);
        res_d=cconv(res,g0,col);
        trend_re1=[trend_re1;res_d];

end
[row,col]=size(dev12);
for i=1:1:row
        temp=dev12(i,:);
        res=upsample(temp,2);
        res_d=cconv(res,g1,col);
        trend_re2=[trend_re2;res_d];
end
trend_re=trend_re1+trend_re2;
%% First level dev branch
dev_re1=[];
[row,col]=size(trend21);
for i=1:1:col
        temp=trend21(:,i);
        res=upsample(temp,2);
        res_d=cconv(res,g0,row);
        dev_re1=[dev_re1,res_d];
end
dev_re2=[];
[row,col]=size(dev21);
for i=1:1:col
        temp=dev21(:,i);
        res=upsample(temp,2);
        res_d=cconv(res,g1,row);
        dev_re2=[dev_re2,res_d];
end
dev_re=dev_re1+dev_re2;
%%
trend_re=cast(real(trend_re),'uint8');
dev_re=cast(real(dev_re),'uint8');
figure; subplot(1,2,1),imshow(trend_re);title("Reconstructed trend");
subplot(1,2,2), imshow(dev_re);title("Reconstructed deviation");
%% Final
im1=[];
[row,col]=size(trend_re);
for i=1:1:row
        temp=trend_re(i,:);
        res=upsample(temp,2);
        res_d=cconv(res,g0,col);
        im1=[im1;res_d];
end
im2=[];
[row,col]=size(dev_re);
for i=1:1:row
        temp=dev_re(i,:);
        res=upsample(temp,2);
        res_d=cconv(res,g1,col);
        im2=[im2;res_d];
end
%%
re_img=im2+im1;

re_image = cast(real(re_img), 'uint8').';
figure;
subplot(1,2,1),imshow(im1);
subplot(1,2,2),imshow(im2);
figure, imshow(re_image);title("Reconstructed Image");
