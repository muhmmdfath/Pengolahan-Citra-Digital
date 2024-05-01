function myFunction(arg1, arg2)
%3. operasi dilasi matlab
clc;
clear all;
close all;
Bravo = imread('madu_m.jpg');
F = im2bw(Bravo, 0.5);

% Elemen Struktural Disk
SE_disk = strel('disk', 5, 8);

% Elemen Struktural Square [3,3]
SE_square = strel('square', 7);

% Dilasi dengan Elemen Struktural Disk
hasilDilasiDisk = imdilate(F, SE_disk);

% Dilasi dengan Elemen Struktural Square [3,3]
hasilDilasiSquare = imdilate(F, SE_square);

% Menampilkan citra-citra
figure, imshow(F);
title('Citra Asli Hitam Putih');

figure, imshow(hasilDilasiDisk);
title('Citra Hasil Dilasi (Disk)');

figure, imshow(hasilDilasiSquare);
title('Citra Hasil Dilasi (Square)');
end
