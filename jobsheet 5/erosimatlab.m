clc;
clear all;
close all;
Bravo = imread("madu_m.jpg");
citragray = rgb2gray(Bravo);
F = im2bw(Bravo, 0.5);

% Elemen Struktural Disk
SE_disk = strel('disk', 5, 8);

% Elemen Struktural Square [7,7]
SE_square = strel('square', 3);

% Erosi dengan Elemen Struktural Disk
hasilErosiDisk = imerode(F, SE_disk);

% Erosi dengan Elemen Struktural Square [3,3]
hasilErosiSquare = imerode(F, SE_square);

% Menampilkan citra-citra
figure, imshow(citragray);
title('Citra Asli Hitam Putih');

figure, imshow(F);
title('Citra Hasil Binerisasi');

figure, imshow(hasilErosiDisk);
title('Citra Hasil Erosi (Disk)');

figure, imshow(hasilErosiSquare);
title('Citra Hasil Erosi (Square)');
