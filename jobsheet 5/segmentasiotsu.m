clc;
clear all;
close all;

% Membaca citra
X = imread("madu_m.jpg");

% Mengubah citra menjadi citra keabuan
citragray = rgb2gray(X);

% Melakukan segmentasi Otsu
level = graythresh(citragray);
Xbw_otsu = imbinarize(citragray, level);

% Menampilkan citra hasil segmentasi Otsu
figure, imshow(Xbw_otsu);
title('Citra Hasil Segmentasi Otsu');

% Operasi hole filling
SE_rect = strel("rectangle", [3 3]);
Areaopen = bwareaopen(Xbw_otsu, 500);
Holefilling = imfill(Areaopen, 'holes');

% Menampilkan citra setelah hole filling
figure, imshow(Holefilling);
title('Citra Hasil Hole Filling setelah Segmentasi Otsu');
