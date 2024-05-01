clc;
clear all;
close all;

% Elemen Struktural Rectangle [5,5]
SE_rect = strel("rectangle",[5 5]);

% Elemen Struktural Square [3,3]
SE_square = strel('square', 7);

X = imread("madu_m.jpg");
Xbw = ~(im2bw(X, 0.6));

figure, imshow(Xbw);
title('Citra Asli Hitam Putih');

% Opening dengan Elemen Struktural Rectangle [5,5]
XErosi_rect = imerode(Xbw, SE_rect);
Xopening_rect = imdilate(XErosi_rect, SE_rect);

% Opening dengan Elemen Struktural Square [3,3]
XErosi_square = imerode(Xbw, SE_square);
Xopening_square = imdilate(XErosi_square, SE_square);

figure, imshow(Xopening_rect);
title('Citra Hasil Opening (Rectangle)');

figure, imshow(Xopening_square);
title('Citra Hasil Opening (Square)');
