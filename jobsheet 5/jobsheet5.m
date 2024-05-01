function myFunction(arg1, arg2)
clc;
clear all;
close all;

%1. Operasi Logika
%Contoh penggunaan NOT, AND, OR, XOR, di
%kombinasinya

Lingkaran = imread('madu_polos.jpg');
Persegi = imread('tomat_p.png');

[tinggi, lebar, channel] = size(Lingkaran);
Persegi = imresize(Persegi, [tinggi, lebar]);

lingkarangray = rgb2gray(Lingkaran);
persegigray = rgb2gray(Persegi);

% Konversi ke citra biner jika perlu
threshold = 128; % Tentukan nilai ambang sesuai kebutuhan
gambar1_bin = imbinarize(lingkarangray, threshold);
gambar2_bin = imbinarize(persegigray, threshold);

Citra1 = Lingkaran;
subplot(3,3,1);
imshow(Citra1, [0 1]);
title('A');

Citra2 = Persegi;
subplot(3,3,2);
imshow(Citra2, [0 1]);
title('B');

Citra3 = not(Lingkaran);
Citra3 = double(Citra3); % Konversi ke tipe data double jika perlu
Citra3 = Citra3 / max(Citra3(:)); % Normalisasi nilai antara 0 dan 1
subplot(3,3,3);
imshow(Citra3, [0 1]);
title('not(A)');

Citra4 = and(Lingkaran, Persegi);
Citra4 = double(Citra4); % Konversi ke tipe data double jika perlu
Citra4 = Citra4 / max(Citra4(:)); % Normalisasi nilai antara 0 dan 1
subplot(3,3,4);
imshow(Citra4, [0 1]);
title('and(A, B)');

Citra5 = xor(Lingkaran, Persegi);
Citra5 = double(Citra5); % Konversi ke tipe data double jika perlu
Citra5 = Citra5 / max(Citra5(:)); % Normalisasi nilai antara 0 dan 1
subplot(3,3,5); imshow(Citra5, [0 1]);
title('xor(A, B)');

Citra6 = or(Lingkaran, Persegi);
subplot(3,3,6); imshow(Citra6, [0 1]);
title('or(A, B)');

Citra7 = not(and(Lingkaran, Persegi));
subplot(3,3,7); imshow(Citra7, [0 1]);
title('not(and(A, B)');

Citra8 = not(xor(Lingkaran, Persegi));
subplot(3,3,8); imshow(Citra8, [0 1]);
title('not(xor(A, B))');

Citra9 = not(or(Lingkaran, Persegi));
subplot(3,3,9); imshow(Citra9, [0 1]);
title('not(or(A, B))');
end