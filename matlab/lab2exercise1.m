%%
clear all;
close all;
img = imread('lena.png');
%Need to fourier trasnform and shift before applying LPF.
fftImg = fft2(img);
figure(1);
%moving the lower frequencies to the middle of the matrix
shifted = fftshift(fftImg);
%Using log to get a more distinct graph
set(surf(log(abs(shifted)+1)), 'Linestyle', 'none');

%%Adding LPF
%%fcoupure = cutoffFrequncy
dimImg = size(img);
lpfMask1 = freqLPF(dimImg, 0.5);
lpfMask2 = freqLPF(dimImg, 0.1);
lpfMask3 = freqLPF(dimImg, 0.03);
% using .* to multiply element by element
filtered_img1 = lpfMask1.*shifted;
filtered_img2 = lpfMask2.*shifted;
filtered_img3 = lpfMask3.*shifted;
figure(2);
imshow(filtered_img3);
%shifting back and doing reverse fourier transform
reverseShifted1 = ifftshift(filtered_img1);
reverseShifted2 = ifftshift(filtered_img2);
reverseShifted3 = ifftshift(filtered_img3);
reverseF1 = ifft2(reverseShifted1);
reverseF2 = ifft2(reverseShifted2);
reverseF3 = ifft2(reverseShifted3);

figure(3);
imshow(reverseF1,[]);
figure(4);
imshow(reverseF2,[]);
figure(5);
imshow(reverseF3,[]);
%%

