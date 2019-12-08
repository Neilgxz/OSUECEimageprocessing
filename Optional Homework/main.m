clear all
close all
%% input image and ratio
I= imread('M-001-01.bmp');
I = im2double(rgb2gray(I));
ratio=0.1; 
%% dctcompress
[I2]=dctcompress(I,ratio);
%% display
figure
subplot(1,2,1)
imshow(I);
title("original picture")
subplot(1,2,2)
imshow(I2);
title("compressed picture")