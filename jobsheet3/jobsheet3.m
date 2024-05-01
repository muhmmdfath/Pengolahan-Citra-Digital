clc;
clear all;
close all;

citra = imread('tomat_m.jpg');
I = imresize(citra, [250 250]);
figure, imshow(I);
title('Citra Asli');

R = I(:,:,1);
geser = I(:,:,2);
B = I(:,:,3);

figure, imshow(R);
title('Citra Channel R');

figure, imshow(geser);
title('Citra Channel G');

figure, imshow(B);
title('Citra Channel B');

gray = rgb2gray(I);
figure, imshow(gray);
title('Citra Grayscale');

figure, histogram(gray, 256);
title('Histogram Citra Grayscale');

[tinggi, lebar] = size(gray);
sx = 45;
sy = -35;

gray2 = double(gray);
geser = zeros(size(gray2));
for y=1 : tinggi
    for x=1 : lebar
        xlama = x-sx;
        ylama = y-sy;

        if (xlama>=1) && (xlama<=lebar) && ...
                (ylama>=1) && (ylama<=tinggi)
            geser(y, x) = gray(ylama, xlama);
        else
            geser(y, x) = 0;
        end
    end
end

geser = uint8(geser);
figure, imshow(geser);
title('Citra Hasil Penggeseran Citra Gray');

sudut = 10;
rad = pi * sudut/180;
cosa = cos(rad);
sina = sin(rad);
rotasi = double(gray);
for y=1 : tinggi
    for x=1 : lebar
        x2 = round(x * cosa + y * sina);
        y2 = round(y * cosa - x * sina);

        if (x2>=1) && (x2<=lebar) && ...
                (y2>=1) && (y2<=tinggi)
            Rotasi2(y, x) = rotasi(y2, x2);
        else
            Rotasi2(y, x) = 0;
        end
    end
end

Rotasi2 = uint8(Rotasi2);
figure, imshow(Rotasi2);
title('Citra hasil Rotasi citra gray');

sudut = 15;
rad = pi * sudut/180;
cosa = cos(rad);
sina = sin(rad);
for y=1 : tinggi
    for x=1 :lebar
        x2 = x * cosa + y * sina;
        y2 = y * cosa - x * sina;

        if (x2>=1) && (x2<=lebar) && ...
                (y2>=1) && (y2<=tinggi)
            p = floor(y2);
            q = floor(x2);
            a = y2-p;
            b = x2-q;

            if (x2 == lebar) || (y2 == tinggi)
                interpolasi(y, x) = gray(floor(y2), floor(x2));
            else
                intensitas = (1-a)*((1-b)*gray(p,q) + ...
                    b * gray(p, q+1)) + ...
                    a * ((1-b)* gray(p+1, q) + ...
                    b * gray(p+1, q+1));

                interpolasi(y, x) = intensitas;
            end
        else
            interpolasi(y, x) = 0;
        end
    end
end

interpolasi = uint8(interpolasi);
figure, imshow(interpolasi);
title('Citra hasil Interpolasi citra gray');

sudut = 5;
rad = pi * sudut/180;
cosa = cos(rad);
sina = sin(rad);
m = floor(tinggi/2);
n = floor(lebar/2);

for y=1 : tinggi
    for x=1 : lebar
        x2 = (x-n) * cosa + (y-m) * sina + n;
        y2 = (y-m) * cosa - (x-n) * sina + m;
        if (x2>=1) && (x2<=lebar) && ...
                (y2>=1) && (y2<=tinggi)
            p = floor(y2);
            q = floor(x2);
            a = y2-p;
            b = x2-q;

            if (x2==lebar) || (y2 == tinggi)
                Rotasi4(y, x) = gray(y2, x2);
            else
                intensitas = (1-a)*((1-b)*gray(p,q) + ...
                b * gray(p, q+1)) + ...
                a * ((1-b)* gray(p+1, q) + ...
                b * gray(p+1, q+1));

                Rotasi4(y, x) = intensitas;
            end
        else
            Rotasi4(y, x) = 0;
        end
    end
end

Rotasi4 = uint8(Rotasi4);
figure, imshow(Rotasi4);
title('Citra hasil rotasi dengan pusat rotasi citra');

sy = 3;
sx = 3;
tinggi_baru = tinggi * sy;
lebar_baru = lebar * sx;

graydouble = double(gray);
for y=1 : tinggi_baru
    y2 = ((y-1) / sy) + 1;
    x2 = ((x-1) / sx) + 1;
    for x=1 : lebar_baru
        x2 = ((x-1) / sx) + 1;
        Gperbesar(y, x) = graydouble(floor(y2), floor(x2));
    end
end

Gperbesar = uint8(Gperbesar);
figure, imshow(Gperbesar);
title('Citra hasil pembesaran');

sy = 3;
sx = 3;
tinggi_baru = round(tinggi * sy);
lebar_baru = round(lebar * sx);
graydouble = double(gray);
for y=1 : tinggi_baru
    y2 = (y-1) / sy + 1;
    for x=1 : lebar_baru
        x2 = (x-1) / sx + 1;
        p = floor(y2);
        q = floor(x2);
        a = y2-p;
        b = x2-q;

        if(floor(x2)==lebar) || ...
            (floor(y2)==tinggi)
            perbesar2(y, x) = graydouble(floor(y2), floor(x2));
        else
            intensitas = (1-a)*((1-b)*graydouble(p,q) + ...
                b * graydouble(p, q+1)) + ...
                a *((1-b) * graydouble(p+1, q) + ...
                b * graydouble(p+1, q+1));

            perbesar2(y, x) = intensitas;
        end
    end
end

perbesar2 = uint8(perbesar2);
figure, imshow(perbesar2);
title('Citra hasil pembesaran dengan interpolasi');

sy = 0.5;
sx = 0.5;
tinggi_baru = tinggi * sy;
lebar_baru = lebar * sx;

graydouble = double(gray);
for y=1 : tinggi_baru
    y2 = ((y-1) / sy) + 1;
    x2 = ((x-1) / sx) + 1;
    for x=1 :lebar_baru
        x2 = ((x-1) / sx) + 1;
        Gpengecilan(y, x) = graydouble(floor(y2), floor(x2));
    end
end

Gpengecilan = uint8(Gpengecilan);
figure, imshow(Gpengecilan);
title('Citra hasil pengecilan');

sy = 0.5;
sx = 0.5;
tinggi_baru = round(tinggi * sy);
lebar_baru = round(lebar * sx);

graydouble = double(gray);
for y=1 : tinggi_baru
    y2 = (y-1) / sy + 1;
    for x=1 : lebar_baru
        x2 = (x-1) / sx + 1;
        p = floor(y2);
        q = floor(x2);
        a = y2-p;
        b = x2-q;
        if(floor(x2)==lebar) || ...
            (floor(y2)==tinggi)
            perkecil(y, x) = graydouble(floor(y2), floor(x2));
        else
            intensitas = (1-a)*((1-b)*graydouble(p,q) + ...
                b * graydouble(p, q+1)) + ...
                a *((1-b) * graydouble(p+1, q) + ...
                b * graydouble(p+1, q+1));

            perkecil(y, x) = intensitas;
        end
    end
end

perkecil = uint8(perkecil);
figure, imshow(perkecil);
title('citra hasil pengecilan citra dengan interpolasi');

for y=1 : tinggi
    for x=1 : lebar
        x2 = lebar - x + 1;
        y2 = y;

        GpencerminanH(y, x) = gray(y2, x2);
    end
end

GpencerminanH = uint8(GpencerminanH);
figure, imshow(GpencerminanH);
title('citra hasil pencerminan horizontal');

for y=1 : tinggi
    for x=1 : lebar
        x2 = x;
        y2 = tinggi -y + 1;

        GpencerminanV(y, x) = gray(y2, x2);
    end
end

GpencerminanV = uint8(GpencerminanV);
figure, imshow(GpencerminanV);
title('citra hasil pencerminan Vertikal');

angle = 45;
RM1 = manualRotateImage(I, angle);

figure, imshow(RM1);
title('Citra hasil rotasi dengan fungsi matlab 1');

angle=45;
RM2 = manualRotateImage1(I,angle, 'bilinear');

figure, imshow(RM2);
title('citra hasil rotasi dengan fungsi matlab 2');

angle=45;
RM3 = manualRotateImage2(I,angle, 'bilinear','crop');

figure, imshow(RM3);
title('citra hasil rotasi dengan fungsi matlab 3');

scale = 0.5;
B1 = imresize(I, scale);

figure, imshow(B1);
title('citra hasil rezise matlab dengan skala');

numrows = 200;
numcols = 300;
B2 = imresize(I,[numrows numcols]);

figure, imshow(B2);
title('citra hasil rezise matlab dengan penentuan baris dan kolom');

function rotatedImage = manualRotateImage(image, angle)
    % Mengambil ukuran citra input
    [rows, cols, ~] = size(image);

    % Menghitung titik tengah citra
    centerX = cols / 2;
    centerY = rows / 2;

    % Menghitung matriks transformasi rotasi
    rotationMatrix = [cosd(angle), -sind(angle); sind(angle), cosd(angle)];

    % Inisialisasi citra yang akan diregenerasi
    rotatedImage = zeros(size(image));
    
    % Melakukan perulangan untuk setiap piksel pada citra hasil
    for y = 1:rows
        for x = 1:cols
            % Menghitung koordinat asal piksel di citra asli
            originalX = rotationMatrix(1, 1) * (x - centerX) + rotationMatrix(1, 2) * (y - centerY) + centerX;
            originalY = rotationMatrix(2, 1) * (x - centerX) + rotationMatrix(2, 2) * (y - centerY) + centerY;

            % Mendekati koordinat asal ke piksel terdekat
            x1 = floor(originalX);
            x2 = x1 + 1;
            y1 = floor(originalY);
            y2 = y1 + 1;

            % Periksa apakah koordinat asal berada dalam batas citra asli
            if x1 >= 1 && x1 <= cols && x2 >= 1 && x2 <= cols && y1 >= 1 && y1 <= rows && y2 >= 1 && y2 <= rows
                % Interpolasi bilinear
                value1 = image(y1, x1, :);
                value2 = image(y1, x2, :);
                value3 = image(y2, x1, :);
                value4 = image(y2, x2, :);

                xFraction = originalX - x1;
                yFraction = originalY - y1;

                % Menghitung nilai piksel hasil interpolasi
                interpolatedValue = (1 - xFraction) * (1 - yFraction) * value1 + xFraction * (1 - yFraction) * value2 + (1 - xFraction) * yFraction * value3 + xFraction * yFraction * value4;

                % Menyimpan nilai interpolasi ke citra hasil rotasi
                rotatedImage(y, x, :) = interpolatedValue;
            end
        end
    end

    % Konversi tipe data citra hasil
    rotatedImage = uint8(rotatedImage);
end

function rotatedImage = manualRotateImage1(image, angle, interpolation)
    % Mengambil ukuran citra input
    [rows, cols, ~] = size(image);

    % Menghitung titik tengah citra
    centerX = cols / 2;
    centerY = rows / 2;

    % Menghitung sudut rotasi dalam radian
    theta = deg2rad(angle);

    % Menghitung matriks transformasi rotasi
    rotationMatrix = [cos(theta), -sin(theta); sin(theta), cos(theta)];

    % Inisialisasi citra yang akan diregenerasi
    rotatedImage = zeros(size(image));

    % Melakukan perulangan untuk setiap piksel pada citra hasil
    for y = 1:rows
        for x = 1:cols
            % Menghitung koordinat asal piksel di citra asli
            offset = [x - centerX; y - centerY];
            originalOffset = rotationMatrix * offset;
            originalX = originalOffset(1) + centerX;
            originalY = originalOffset(2) + centerY;

            % Mendekati koordinat asal ke piksel terdekat
            x1 = floor(originalX);
            x2 = x1 + 1;
            y1 = floor(originalY);
            y2 = y1 + 1;

            % Periksa apakah koordinat asal berada dalam batas citra asli
            if x1 >= 1 && x1 <= cols && x2 >= 1 && x2 <= cols && y1 >= 1 && y1 <= rows && y2 >= 1 && y2 <= rows
                % Interpolasi berdasarkan jenis interpolasi yang diberikan
                if strcmp(interpolation, 'bilinear')
                    value1 = image(y1, x1, :);
                    value2 = image(y1, x2, :);
                    value3 = image(y2, x1, :);
                    value4 = image(y2, x2, :);

                    xFraction = originalX - x1;
                    yFraction = originalY - y1;

                    % Menghitung nilai piksel hasil interpolasi
                    interpolatedValue = (1 - xFraction) * (1 - yFraction) * value1 + xFraction * (1 - yFraction) * value2 + (1 - xFraction) * yFraction * value3 + xFraction * yFraction * value4;
                else
                    % Menambahkan jenis interpolasi lain di sini jika diperlukan
                    error('Jenis interpolasi tidak didukung.');
                end

                % Menyimpan nilai interpolasi ke citra hasil rotasi
                rotatedImage(y, x, :) = interpolatedValue;
            end
        end
    end

    % Konversi tipe data citra hasil
    rotatedImage = uint8(rotatedImage);
end

function rotatedImage = manualRotateImage2(image, angle, interpolation, crop)
    % Mengambil ukuran citra input
    [rows, cols, ~] = size(image);

    % Menghitung titik tengah citra
    centerX = cols / 2;
    centerY = rows / 2;

    % Menghitung sudut rotasi dalam radian
    theta = deg2rad(angle);

    % Menghitung matriks transformasi rotasi
    rotationMatrix = [cos(theta), -sin(theta); sin(theta), cos(theta)];

    % Hitung sudut rotasi maksimum untuk pemotongan
    maxRotationAngle = atan2d(rows/2, cols/2);

    % Inisialisasi citra yang akan diregenerasi
    rotatedImage = zeros(size(image), 'like', image);

    % Melakukan perulangan untuk setiap piksel pada citra hasil
    for y = 1:rows
        for x = 1:cols
            % Menghitung koordinat asal piksel di citra asli
            offset = [x - centerX; y - centerY];
            originalOffset = rotationMatrix * offset;
            originalX = originalOffset(1) + centerX;
            originalY = originalOffset(2) + centerY;

            if strcmp(crop, 'crop') && abs(angle) > maxRotationAngle
                % Lakukan pemotongan jika sudut rotasi melebihi batas maksimum
                rotatedImage(y, x, :) = 0;
            else
                % Mendekati koordinat asal ke piksel terdekat
                x1 = floor(originalX);
                x2 = x1 + 1;
                y1 = floor(originalY);
                y2 = y1 + 1;

                % Periksa apakah koordinat asal berada dalam batas citra asli
                if x1 >= 1 && x1 <= cols && x2 >= 1 && x2 <= cols && y1 >= 1 && y1 <= rows && y2 >= 1 && y2 <= rows
                    % Interpolasi berdasarkan jenis interpolasi yang diberikan
                    if strcmp(interpolation, 'bilinear')
                        value1 = image(y1, x1, :);
                        value2 = image(y1, x2, :);
                        value3 = image(y2, x1, :);
                        value4 = image(y2, x2, :);

                        xFraction = originalX - x1;
                        yFraction = originalY - y1;

                        % Menghitung nilai piksel hasil interpolasi
                        interpolatedValue = (1 - xFraction) * (1 - yFraction) * value1 + xFraction * (1 - yFraction) * value2 + (1 - xFraction) * yFraction * value3 + xFraction * yFraction * value4;
                    else
                        % Menambahkan jenis interpolasi lain di sini jika diperlukan
                        error('Jenis interpolasi tidak didukung.');
                    end

                    % Menyimpan nilai interpolasi ke citra hasil rotasi
                    rotatedImage(y, x, :) = interpolatedValue;
                end
            end
        end
    end
end
