clc;
clear all;
close all;

Citraasli = imread('madu_polos.jpg');
I = imresize(Citraasli, [250 250]);

citragray = rgb2gray(I);

noiselevel = 0.02;
% Menghasilkan noise salt and pepper secara manual
[row, col] = size(citragray);
citragraynoise = citragray;

% Mengacak lokasi untuk noise
randPixels = rand(row, col);

% Menetapkan noise salt and pepper
citragraynoise(randPixels < noiselevel/2) = 0; % Hitam (pepper noise)
citragraynoise(randPixels >= noiselevel/2 & randPixels < noiselevel) = 255; % Putih (salt noise)

x = -1: .01: 1;
y = -1: .01: 1;
[x_,y_] = meshgrid(x,y);
h1_= exp((-5.*x_.^2)-(5.*y_.^2));

H1_= abs(fft2(h1_));
kernel = h1_/ sum(h1_(:));
filteredimage = conv2(double(citragraynoise), kernel, 'same');
hasilconv = uint8(filteredimage);
figure, imshow(hasilconv);
title('hasil konvolusi bawaan matlab');

