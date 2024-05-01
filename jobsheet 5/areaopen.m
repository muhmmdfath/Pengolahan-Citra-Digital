%10. membuang objek kecil sekitar objek utama
clc;
clear all;
close all;
SE4 = strel("rectangle",[3 3]);
X = imread("madu_m.jpg");
Xbw = ~(im2bw(X, 0.6));
figure, imshow(Xbw);
title('Citra Asli Hitam Putih');
Areaopen = bwareaopen(Xbw, 500);
figure, imshow(Areaopen);
title('Citra hasil pembuangan objek yang tidak diperlukan'); 