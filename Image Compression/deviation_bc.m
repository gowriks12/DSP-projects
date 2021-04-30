function [out_image] = deviation_bc(inp_image,val)
%DEVIATION_BC Summary of this function goes here
%   Detailed explanation goes here
% Input image matrix
% If value =1 Process rows, If value =2 process columns
% Extract rows from the input image and circularly convolve with the
% high_pass filter
% Downsample the result by a factor of 2
% Output the final matrix
[row,col]=size(inp_image);
out_image=[];
% high = [0.000034211591536,-0.00017105795768,-0.000074275165835,0.0019108974483,...
%     -0.002628890718028,-0.0152750254683,0.0155482680481,0.0802644451161,...
%     -0.03819994286504,-0.4202826497317,0.75774803940516,-0.4202826497317,...
%     -0.03819994286504,0.0802644451161,0.0155482680481,-0.0152750254683,...
%     -0.002628890718028,0.0019108974483,-0.000074275165835,-0.00017105795768,0.000034211591536];
high = [-3.98960956074*10^(-6), 0.00002260778751086, 6.3914743024*10^(-6), -0.000277789678273, ...
    0.000345091651368, 0.00155825777815, -0.00360374050808, -0.00499203440572, ...
    0.02440592511743, 0.02334136673386, -0.106073569652, -0.1467785003718, 0.66490458055676, ...
    0.66490458055676, -0.1467785003718, -0.106073569652, 0.02334136673386, 0.02440592511743, ...
    -0.00499203440572, -0.00360374050808, 0.00155825777815, 0.000345091651368, ...
    -0.000277789678273, 6.3914743024*10^(-6), 0.00002260778751086, -3.98960956074*10^(-6)];
if val==1
   for i=1:1:row
        temp=inp_image(i,:);
        res=cconv(temp,high,col);
        res_d=downsample(res,2);
        out_image=[out_image;res_d];
   end
else
    for i=1:1:col
        temp=inp_image(:,i);
        res=cconv(temp,high,row);
        res_d=downsample(res,2);
        out_image=[out_image,res_d];
    end
end
end

