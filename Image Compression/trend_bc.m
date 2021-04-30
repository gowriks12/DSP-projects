function [out_image] = trend_bc(inp_image,val)
%TREND_BC Summary of this function goes here
%   Detailed explanation goes here
% Input image matrix
% If value =1 Process rows, If value =2 process columns
% Extract rows from the input image and circularly convolve with the
% low_pass filter
% Downsample the result by a factor of 2
% Output the final matrix
[row,col]=size(inp_image);
out_image=[];
% low=[-0.00552427172802,0.0276213586401,-0.0276213586401,-0.1104854345604,...
%     0.3866990209614,0.87283493302715,0.3866990209614,-0.1104854345604,...
%     -0.0276213586401,0.0276213586401,-0.00552427172802];  
low = [-0.000379700958235, 0.00215163876333, -0.00198612808923,...
    -0.01173621143634, 0.0286885168444, 0.01475409437712, ...
    -0.1290983258, 0.0946721055865, 0.7100407918988, ...
    0.7100407918988, 0.0946721055865, -0.1290983258, ...
    0.01475409437712, 0.0286885168444, -0.01173621143634, ...
    -0.00198612808923, 0.00215163876333, -0.000379700958235];
if val==1
   for i=1:1:row
        temp=inp_image(i,:);
        res=cconv(temp,low,col);
        res_d=downsample(res,2);
        out_image(i,:)=res_d;
   end
else
    for i=1:1:col
        temp=inp_image(:,i);
        res=cconv(temp,low,row);
        res_d=downsample(res,2);
        out_image=[out_image,res_d];
    end
end

end

