clc;
clear all;
close all;

SE_rect = strel("rectangle", [3 3]);
X = imread("madu_m.jpg");
Xbw = ~(im2bw(X, 0.6));

figure, imshow(Xbw);
title('Citra Asli Hitam Putih');

% Menggunakan bwareaopen
Areaopen = bwareaopen(Xbw, 500);

% Menampilkan hasil bwareaopen
figure, imshow(Areaopen);
title('Citra Hasil bwareaopen');

% Menggunakan imfill untuk mengisi lubang
Holefilling = imfill(Areaopen, 'holes');

% Menampilkan citra setelah hole filling
figure, imshow(Holefilling);
title('Citra hasil Hole Filling');
