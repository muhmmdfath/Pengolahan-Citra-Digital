%7. operasi opening matlab
clc;
clear all;
close all;
SE4 = strel("rectangle",[5 5]);
X = imread("madu_m.jpg");
Xbw = ~(im2bw(X, 0.6));
figure, imshow(Xbw);
title('Citra Asli Hitam Putih');
imopening = imopen(Xbw, SE4);
figure, imshow(imopening);
title('Citra hasil opening matlab'); 