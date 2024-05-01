clc;
clear all;
close all;

% Elemen Struktural Rectangle [3,3]
SE_rect = strel("rectangle", [3 3]);

% Elemen Struktural Square [3,3]
SE_square = strel('square', 7);

X = imread("madu_m.jpg");
Xbw = ~(im2bw(X, 0.6));

figure, imshow(Xbw);
title('Citra Asli Hitam Putih');

% Closing dengan Elemen Struktural Rectangle [3,3]
XDilasi_rect = imdilate(Xbw, SE_rect);
Xclosing_rect = imerode(XDilasi_rect, SE_rect);

% Closing dengan Elemen Struktural Square [3,3]
XDilasi_square = imdilate(Xbw, SE_square);
Xclosing_square = imerode(XDilasi_square, SE_square);

figure, imshow(Xclosing_rect);
title('Citra Hasil Closing (Rectangle)');

figure, imshow(Xclosing_square);
title('Citra Hasil Closing (Square)');
