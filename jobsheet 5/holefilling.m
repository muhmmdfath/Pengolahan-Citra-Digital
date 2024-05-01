%11. mengisi lubang (hole filling)
clc;
clear all;
close all;
SE4 = strel("rectangle",[3 3]);
X = imread("madu_m.jpg");
Xbw = ~(im2bw(X, 0.6));
figure, imshow(Xbw);
title('Citra Asli Hitam Putih');
Areaopen = bwareaopen(Xbw, 500);
Holefilling = imfill(Areaopen,'holes');
figure, imshow(Holefilling);
title('Citra hasil Hole filing'); 