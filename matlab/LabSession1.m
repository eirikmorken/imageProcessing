%%
clear all;
close all;
img = imread('lena.tif');
ir = imresize (img, 0.25);
size(ir);
irg = rgb2gray(ir);
square=[];
square(1:1024,1:1024)=32;
square(256: 256+511, 256:256+511) = 64;
square(512-127: 512+127, 512-127:512+127) = 128;
square(512-64: 512+63, 512-64:512+63) = irg;
imshow(square, [0 255]);
%%
square2 = uint8(zeros(512,512,3));
i20 =imresize(img, 0.5);
vide =uint8(zeros(size(i20,1),size(i20,2)));
R = cat(3, i20(:,:,1),vide,vide);
G = cat(3, vide,i20(:,:,2),vide);
B = cat(3, vide,vide,i20(:,:,3));
i21 = rot90(B,2);
i22 = fliplr(R);
i23 = flipud(G);
square2(1:256,1:256, 1:3) = i20;
square2(1:256,257:512, 1:3) = i21;
square2(257:512,1:256, 1:3) = i22;
square2(257:512,257:512, 1:3) = i23;
imshow(square2);
%%

img3 = imresize(img, 0.5);
i3g = rgb2gray(img3); 
colormap(gray(256));
set(surf(i3g), 'Linestyle', 'none');
%%
img4 = rgb2gray(imresize(img, 0.5));
rec = zeros(512,1024);
imshow(img4);
for i =1:8
    bitplane = bitget(img4, i);
    row = 256*floor(i/5)+1;
    col = 256*(mod((i-1), 4))+1;
    rec(row:row+255, col:col+255) = bitplane;
end


imshow(rec);






%%