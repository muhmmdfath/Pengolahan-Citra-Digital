%9. operasi closing matlab
clc;
clear all;
close all;
SE4 = strel("rectangle",[3 3]);
X = imread("madu_m.jpg");
Xbw = ~(im2bw(X, 0.6));
figure, imshow(Xbw);
title('Citra Asli Hitam Putih');
imclosing = imclose(Xbw, SE4);
figure, imshow(imclosing);
title('Citra hasil closing matlab'); 