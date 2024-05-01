% Baca citra (grayscale atau berwarna)
citra = imread('madu_polos.jpg');

% Konversi ke citra grayscale jika citra berwarna
if size(citra, 3) == 3
    citra = rgb2gray(citra);
end

% Lakukan adaptive thresholding
citraBiner = imbinarize(citra, 'adaptive');

% Tampilkan citra asli dan citra biner
subplot(1, 2, 1), imshow(citra), title('Citra Asli');
subplot(1, 2, 2), imshow(citraBiner), title('Citra Biner (Adaptive)');
