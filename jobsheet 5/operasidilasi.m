function myFunction(arg1, arg2)
%2. Operasi dilasi
clc;
clear all;
close all;

Bravo = imread('madu_m.jpg');
F = im2bw(Bravo, 0.5);
H = ones(4);
hotx = 0;
hoty = 0;
[th, lh]=size(H);
[tf, lf]=size(F);

if nargin < 3
    hotx = round(lh/2);
    hoty = round(th/2);
end

Xh = [];
Yh = [];
jum_anggota = 0;

% Menuntukan koordinator piksel 1 pada H
for baris = 1 : th
    for kolom = 1 : lh
        if H(baris, kolom) == 1
            jum_anggota = jum_anggota + 1;
            Xh(jum_anggota) = -hotx + kolom;
            Yh(jum_anggota) = -hoty + baris;
        end
    end
end

G = zeros(tf, lf);%Nolkan semuapada hasil dilasi

%memproses dilasi
for baris = 1 : tf
    for kolom = 1 : lf
        for indeks = 1 : jum_anggota
            if F(baris, kolom) == 1
                xpos = kolom + Xh(indeks);
                ypos = baris + Yh(indeks);
                if (xpos >= 1) && (xpos <= lf) && ...
                   (ypos >= 1) && (ypos <= tf)
                    G(ypos, xpos) = 1;
                end
            end
        end
    end
end
figure, imshow(F);
title('Citra Asli Hitam Putih');
figure, imshow(G);
title('Citra Hasil Dilasi');
end