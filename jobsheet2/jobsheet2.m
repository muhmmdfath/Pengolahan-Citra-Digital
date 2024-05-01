clc;
clear all;
close all;

Citraasli = imread("madu_polos.jpg");
I = imresize(Citraasli, [250 250]);
figure, imshow(I);
title ('Citra RGB');

citragray = rgb2gray(I);
figure, imshow(citragray);
title('Citra Grayscale');

figure, histogram(citragray, 256);
title('Histogram Citra Grayscale');

noiselevel = 0.02;
% Menghasilkan noise salt and pepper secara manual
[row, col] = size(citragray);
citragraynoise = citragray;

% Mengacak lokasi untuk noise
randPixels = rand(row, col);

% Menetapkan noise salt and pepper
citragraynoise(randPixels < noiselevel/2) = 0; % Hitam (pepper noise)
citragraynoise(randPixels >= noiselevel/2 & randPixels < noiselevel) = 255; % Putih (salt noise)

figure, imshow(citragraynoise);
title('Citra Grayscale terdegradasi noise salt & pepper');


[tinggi, lebar] = size(citragraynoise);
gbatas = citragraynoise;
for baris=2 : tinggi-1
    for kolom=2 : lebar-1
        minpiksel = min([citragraynoise(baris-1, kolom-1) ...
            citragraynoise(baris-1, kolom) citragraynoise(baris, kolom+1) ...
            citragraynoise(baris, kolom-1) ...
            citragraynoise(baris, kolom+1) citragraynoise(baris+1, kolom-1) ...
            citragraynoise(baris+1, kolom) citragraynoise(baris+1, kolom+1)]);
        makspiksel = max([citragraynoise(baris-1, kolom-1)...
            citragraynoise(baris-1, kolom) citragraynoise(baris, kolom+1)...
            citragraynoise(baris, kolom-1) ...
            citragraynoise(baris, kolom+1) citragraynoise(baris+1, kolom-1) ...
            citragraynoise(baris+1, kolom) citragraynoise(baris+1, kolom+1)]);
        if citragraynoise(baris, kolom) < minpiksel
            gbatas(baris, kolom) = minpiksel;
        else
            if citragraynoise(baris, kolom) > makspiksel
                gbatas(baris, kolom) = makspiksel;
            else
                gbatas(baris, kolom) = citragraynoise(baris, kolom);
            end
        end
    end
end

figure, imshow(gbatas);
title('Hasil filter Batas');

 
F2 = double(citragraynoise);
for baris=2 : tinggi-1
    for kolom=2 : lebar-1
        jum = F2(baris-1, kolom-1)+    ...
              F2(baris-1, kolom) + ...
              F2(baris-1, kolom-1) + ...
              F2(baris, kolom-1) + ...
              F2(baris, kolom) + ...
              F2(baris, kolom+1) + ...
              F2(baris+1, kolom-1) + ...
              F2(baris+1, kolom) + ...
              F2(baris+1, kolom+1);
        G2(baris, kolom) = uint8(1/9*jum);
    end
end

figure, imshow(G2);
title('Hasil filter rerata');


% Menerapkan filter rerata (average filter) secara manual
filterSize = 3; % Ukuran kernel filter (misalnya, 3x3)
[row, col] = size(citragraynoise);
averagefilt = zeros(row, col);

for i = 2:row-1
    for j = 2:col-1
        % Hitung rerata dari piksel di sekitarnya
        neighborhood = citragraynoise(i-1:i+1, j-1:j+1);
        averagefilt(i, j) = mean(neighborhood(:));
    end
end

figure, imshow(averagefilt/255);
title('Hasil filter rerata matlab');

F = citragraynoise;
for baris=2 : tinggi-1
    for kolom=2 : lebar-1
        data = [F(baris-1, kolom-1) ...
              F(baris-1, kolom) ...
              F(baris-1, kolom+1) ...
              F(baris, kolom-1) ...
              F(baris, kolom) ...
              F(baris, kolom+1) ...
              F(baris+1, kolom-1) ...
              F(baris+1, kolom) ...
              F(baris+1, kolom+1)];
        for i=1 : 8
            for j=i+1 : 9
                if data(i) > data(j)
                    tmp = data(i);
                    data(i) = data(j);
                    data(j) = tmp;
                end
            end
        end
        GM(baris, kolom) = data(5);
    end
end
figure, imshow(GM);
title('Hasil Filter Median')


for i = 1:row
    for j = 1:col
        if i > 1 && i < row && j > 1 && j < col
            neighborhood = citragraynoise(i-1:i+1, j-1:j+1);
            Kmedian(i, j) = median(neighborhood(:));
        end
    end
end

figure, imshow(Kmedian);
title('Hasil filter median matlab');

H = [-1 0 -1; 0 4 0; -1 0 -1];
FC = citragray;
[tinggi_f, lebar_f] = size(FC);
[tinggi_h, lebar_h] = size(H);

m2 = floor(tinggi_h/2);
n2 = floor(lebar_h/2);

F3=double(FC);
for y=m2+1 : tinggi_f-m2
    for x=n2+1 : lebar_f-n2
        jml = 0;
        for p=-m2 : m2
            for q=-n2 : n2
                jml = jml +H(p+m2+1, q+n2+1) * ...
                    F3(y-p, x-q);
            end
        end
        G3(y-m2, x-n2) = jml;
    end
end

G4 = uint8(G3);
figure, imshow(G4);
title('Hasil Konvolusi quick mask');

x = -1: .01: 1;
y = -1: .01: 1;
[x_,y_] = meshgrid(x,y);
h1_= exp((-5.*x_.^2)-(5.*y_.^2));

H1_= abs(fft2(h1_));
kernel = h1_/ sum(h1_(:));
filteredimage = conv2(double(citragraynoise), kernel, 'same');
hasilconv = uint8(filteredimage);
figure, imshow(hasilconv);
title('hasil konvolusi bawaan matlab');


% Membuat kernel Gaussian secara manual
PSFSize = 5;
PSFStdDev = 2;
[x, y] = meshgrid(-(PSFSize-1)/2:(PSFSize-1)/2, -(PSFSize-1)/2:(PSFSize-1)/2);
PSF = exp(-(x.^2 + y.^2) / (2 * PSFStdDev^2));
PSF = PSF / sum(PSF(:)); % Normalize the PSF so that it sums to 1

% Membuat filter gerakan (motion filter) secara manual
filter = 10; % Ukuran filter
angle = 45; % Sudut pergerakan
motion_filter = zeros(filter);
center = (filter - 1) / 2;
% Calculate coordinates for the motion filter
x_coords = round(center + sind(angle) * (-(center):(center)));
y_coords = round(center + cosd(angle) * (-(center):(center)));

% Set the values in the motion filter
motion_filter(sub2ind(size(motion_filter), y_coords, x_coords)) = 1 / filter;

konvolusi_dengan_gaussian_filter = conv2(PSF, citragraynoise);
konvolusi_dengan_motion_filter = conv2(citragraynoise, motion_filter, 'same');
self_convolution = conv2(citragraynoise, citragraynoise);

subplot(2,2,1), imshow(I); title('citra original');
subplot(2,2,2), imshow(konvolusi_dengan_gaussian_filter,[]);
title('gaussian fiter');
subplot(2,2,3), imshow(konvolusi_dengan_motion_filter,[]);
title ('motion filter');
subplot(2,2,4), imshow(self_convolution,[]); title('self convolution')
