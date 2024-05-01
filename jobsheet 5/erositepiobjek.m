%6. Erosi untuk dapat tepi objek
clc;
clear all;
close all;
SE3 = strel('rectangle',[3 3]);
X = imread('madu_m.jpg');
Xbw = im2bw(X, 0.6);
figure, imshow(Xbw);
hasilErosiMatlab2 = imerode(Xbw, SE3);
figure, imshow(hasilErosiMatlab2);
hasiltepi = Xbw-hasilErosiMatlab2;
figure, imshow(hasiltepi);
title('Citra tepi');