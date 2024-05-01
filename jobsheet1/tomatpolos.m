% Membersihkan kode program, memory, dan menutup seluruh jendela
clc;
clear all;
close all;

% Membaca dan menampilkan citra
I = imread('tomat_p.jpg');
figure, imshow(I);
title('Citra Tomat polos RGB');

% Ekstraksi channel RGB
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

figure, imshow(R);
title('Citra Tomat polos Channel R');

figure, imshow(G);
title('Citra Tomat polos Channel G');

figure, imshow(B);
title('Citra Tomat polos Channel B');

% Mendapatkan nilai piksel pada koordinat tertentu
R11 = R(1,1);
G11 = G(1,1);
B11 = B(1,1);

% Konversi citra RGB ke grayscale
citraGray = rgb2gray(I);
figure, imshow(citraGray);
title('Citra Tomat polos Grayscale');

% Kode program membuat histogram (Cara 1)
Ukuran = size(I);
jum_baris = Ukuran(1);
jum_kolom = Ukuran(2);
Histog = zeros(256, 1);
for baris = 1 : jum_baris
    for kolom = 1: jum_kolom
        Histog(I(baris, kolom)+1) = ...
            Histog(I(baris, kolom)+1) + 1;
    end
end

Horis = (0:255)';
figure, bar(Horis, Histog);
title('Histogram Citra Tomat polos Grayscale Cara 1');

% Kode program membuat histogram (Cara 2)
figure, histogram(citraGray);
title('Histogram Citra Tomat polos Grayscale Cara 2');

% Kode program membuat histogram (Cara 3)
figure, histogram(citraGray, 256);
title('Histogram Citra Tomat polos Grayscale Cara 3');

% Pengaturan Kecerahan
citraCerah = citraGray + 50;
figure, imshow(citraCerah);
title('Citra Tomat polos Tomat polos penambahan intensitas');
figure, histogram(citraCerah);
title('Histogram Citra Tomat polos penambahan intensitas');

citraGelap = citraGray - 50;
figure, imshow(citraGelap);
title('Citra Tomat polos Tomat polos penambahan intensitas');
figure, histogram(citraGelap);
title('Histogram Citra Tomat polos pengurangan intensitas');

% Meregangkan kontras
regangKontras = citraGray * 1.5;
figure, imshow(regangKontras);
title('Citra Tomat polos peregangan kontras');
figure, histogram(regangKontras);
title('Histogram Citra Tomat polos peregangan kontras');

% Membalik citra
balikCitra = 255 - citraGray;
figure, imshow(balikCitra);
title('Citra Tomat polos pembalikan citra');
figure, histogram(balikCitra);
title('Histogram Citra Tomat polos pembalikan citra');

% Pemotongan aras keabuan
Img = citraGray;
f1 = 30;
f2 = 170;
Ukuran = size(Img);
tinggi = Ukuran(1);
lebar = Ukuran(2);

Hasil = Img;
for baris = 1 : tinggi 
    for kolom = 1 : lebar
        if Hasil(baris, kolom) <= f1
            Hasil(baris, kolom) = 0;
        end

        if Hasil(baris, kolom) >= f2
            Hasil(baris, kolom) = 255;
        end
    end
end

figure, imshow(Hasil);
title('Citra Tomat polos grayscale pemotongan aras keabuan');
figure, histogram(Hasil);
title('Histogram Citra Tomat polos grayscale pemotongan aras keabuan');

% Histogram Equalization
Ukuran = size(Img);
jum_baris = Ukuran(1);
jum_kolom = Ukuran(2);

L = 256;
Histog = zeros(L, 1);
for baris = 1 : jum_baris
    for kolom = 1 : jum_kolom
        Histog(Img(baris, kolom) + 1) = ...
            Histog(Img(baris, kolom) + 1) + 1;
    end
end

alpha = (L-1) / (jum_baris* jum_kolom);
C(1) = alpha * Histog(1);
for i = 1: L-2
    C(i+1) = C(i) + round(alpha * Histog(i+1));
end

Hasilekual = Img;
for baris = 1 : jum_baris
    for kolom = 1 : jum_kolom
        Hasilekual(baris, kolom) = C(Img(baris, kolom) + 1);
    end
end

Hasilekual = uint8(Hasilekual);
figure, imshow(Hasilekual);
title('Citra Tomat polos grayscale hasil histeq')
figure, histogram(Hasilekual);
title('Histogram Citra Tomat polos grayscale hasil histeq');