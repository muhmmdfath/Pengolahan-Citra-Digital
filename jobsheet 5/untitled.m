clc;
clear all;
close all;

% Baca citra (grayscale atau berwarna)
citra = imread('madu_m.jpg');

% Konversi ke citra grayscale jika citra berwarna
if size(citra, 3) == 3
    citra = rgb2gray(citra);
end

% Lakukan adaptive thresholding
citraBiner = imbinarize(citra, 'adaptive');

% Tentukan elemen struktur untuk dilasi (misalnya, disk dengan radius 5)
radius = 5;
se = strel('disk', radius);

% Lakukan operasi dilasi (thickening)
citraHasil = imdilate(citraBiner, se);

% Tampilkan citra asli dan hasil thickening
subplot(1, 2, 1), imshow(citra), title('Citra Asli');
subplot(1, 2, 2), imshow(citraHasil), title('Hasil Thickening');

function skeleton = skeletonize(citraBiner)
    % Citra Biner adalah citra input yang telah di-threshold (citra biner)
    
    % Konversi nilai piksel dari tipe logical ke tipe uint8
    citraBiner = uint8(citraBiner);

    % Inisialisasi citra hasil skeleton
    skeleton = false(size(citraBiner));

    % Iterasi sampai tidak ada perubahan lagi pada citra
    while true
        % Langkah 1
        step1 = zhangSuenStep(citraBiner, 1);

        % Langkah 2
        step2 = zhangSuenStep(step1, 2);

        % Periksa perubahan
        perubahan = step1 | step2;
        
        % Hentikan iterasi jika tidak ada perubahan
        if ~any(perubahan(:))
            break;
        end

        % Update citra skeleton
        skeleton = skeleton | (citraBiner & ~perubahan);
        citraBiner = bwmorph(citraBiner, 'thin', Inf);
    end
end

function stepResult = zhangSuenStep(citra, langkah)
    % Fungsi ini melakukan satu langkah dari algoritma Zhang-Suen
    
    % Inisialisasi hasil langkah
    stepResult = false(size(citra));

    [tinggi, lebar] = size(citra);

    % Iterasi melalui setiap piksel citra
    for i = 2:tinggi-1
        for j = 2:lebar-1
            % Langkah 1
            if langkah == 1
                kondisi1 = citra(i, j) == 1;
                kondisi2 = sumNeighbors(citra, i, j) >= 2 && sumNeighbors(citra, i, j) <= 6;
                kondisi3 = bwTransitions(citra, i, j) == 1;
                kondisi4 = citra(i-1, j) == 0 || citra(i, j+1) == 0 || citra(i+1, j) == 0;
                kondisi5 = citra(i, j+1) == 1;
                kondisi6 = sumNeighbors(citra, i-1, j) >= 2 && sumNeighbors(citra, i-1, j) <= 6;
                kondisi7 = bwTransitions(citra, i-1, j) == 1;
                kondisi8 = citra(i-1, j) == 0 || citra(i-1, j-1) == 0 || citra(i, j-1) == 0;
                
                if kondisi1 && kondisi2 && kondisi3 && kondisi4 && kondisi5 && kondisi6 && kondisi7 && kondisi8
                    stepResult(i, j) = true;
                end
            end

            % Langkah 2
            if langkah == 2
                kondisi1 = citra(i, j) == 1;
                kondisi2 = sumNeighbors(citra, i, j) >= 2 && sumNeighbors(citra, i, j) <= 6;
                kondisi3 = bwTransitions(citra, i, j) == 1;
                kondisi4 = citra(i-1, j) == 0 || citra(i, j-1) == 0 || citra(i+1, j) == 0;
                kondisi5 = citra(i, j-1) == 1;
                kondisi6 = sumNeighbors(citra, i, j-1) >= 2 && sumNeighbors(citra, i, j-1) <= 6;
                kondisi7 = bwTransitions(citra, i, j-1) == 1;
                kondisi8 = citra(i-1, j) == 0 || citra(i-1, j+1) == 0 || citra(i, j+1) == 0;
                
                if kondisi1 && kondisi2 && kondisi3 && kondisi4 && kondisi5 && kondisi6 && kondisi7 && kondisi8
                    stepResult(i, j) = true;
                end
            end
        end
    end
end

function transitions = bwTransitions(citra, i, j)
    % Menghitung jumlah perubahan nilai piksel dari 0 ke 1
    transitions = abs(citra(i-1, j) - citra(i-1, j+1)) + ...
                  abs(citra(i-1, j+1) - citra(i, j+1)) + ...
                  abs(citra(i, j+1) - citra(i+1, j+1)) + ...
                  abs(citra(i+1, j+1) - citra(i+1, j)) + ...
                  abs(citra(i+1, j) - citra(i+1, j-1)) + ...
                  abs(citra(i+1, j-1) - citra(i, j-1)) + ...
                  abs(citra(i, j-1) - citra(i-1, j-1)) + ...
                  abs(citra(i-1, j-1) - citra(i-1, j));

function count = sumNeighbors(citra, i, j)
    % Menghitung jumlah tetangga dengan nilai piksel 1
    count = citra(i-1, j-1) + citra(i-1, j) + citra(i-1, j+1) + ...
            citra(i, j-1) + citra(i, j+1) + ...
            citra(i+1, j-1) + citra(i+1, j) + citra(i+1, j+1);


citraSkeleton = skeletonize(citraBiner);
figure, imshow(citraSkeleton);
subplot(1,2,3);
end
end