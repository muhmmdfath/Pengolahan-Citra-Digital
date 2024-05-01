function myFunction(arg1, arg2)
%4. Operasi Erosi
clc;
clear all;
close all;
Bravo = imread('madu_m.jpg');
F = im2bw(Bravo, 0.2);
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

%Menentukan koordinat piksel bernilai l pada H
for baris = 1 : th
    for kolom = 1 : lh
        if H(baris, kolom) == 1
            jum_anggota = jum_anggota + 1;
            Xh(jum_anggota) = -hotx + kolom;
            Yh(jum_anggota) = -hoty + baris;
        end
    end
end
G = zeros(tf, lf); %nolkan semua pada hasil erosi

%memproses erosi
for baris = 1 : tf
    for kolom = 1 : lf
        cocok = true;
        for indeks = 1 : jum_anggota
            xpos = kolom + Xh(indeks);
            ypos = baris + Yh(indeks);
            if(xpos >= 1) && (xpos <= lf) && ...
              (ypos >= 1) && (ypos <= tf)
                if F(ypos, xpos) ~= 1
                    cocok = false;
                    break;
                end
            else
                cocok = false;
            end
        end
        if cocok
            G(baris, kolom) = 1;
        end
    end
end

figure, imshow(F);
title('Citra Asli Hitam Putih');
figure, imshow(G);
title('Citra Hasil erosi');
end