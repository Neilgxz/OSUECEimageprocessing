clear all 
close all
%create the Sample images matrix T
I1 = imread('1.jpg');
I2 = imread('2.jpg');
I3 = imread('3.jpg');
I4 = imread('4.jpg');
I5 = imread('5.jpg');
image1 = double(rgb2gray(I1));
image2 = double(rgb2gray(I2));
image3 = double(rgb2gray(I3));
image4 = double(rgb2gray(I4));
image5 = double(rgb2gray(I5));
t1 = image1(:);
t2 = image2(:);
t3 = image3(:);
t4 = image4(:);
t5 = image5(:);
T = [t1,t2,t3,t4,t5]';
% SVD of T*T get B=albedo*normal
P = T * T';
[V D] = svds(P,3);
% B = T' * V * D^(-0.5);
B = T' * V;

% VideoWriter for getting the video
v = VideoWriter('bowl1.avi');
open(v);
% change the direction of illuminations and generate new images
for theta = 0:0.1:1
    for phi = 0:0.1:2
        s = [cos(phi*pi)*sin(theta*pi),sin(phi*pi)*sin(theta*pi),cos(theta*pi)]';
        b = max(B * s, 0);
        Z(:) = b;
        Z = reshape(Z,384,512);
        imshow(Z,[]);
        hold on;
        m = getframe;
        writeVideo(v,m);
    end
end