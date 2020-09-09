%Excercise2: lineas filtering in the spatial domain
clear all;
close all;

%Creating matrix with room five 256x256 for normal img, noice, and three
%filtered images.
mosaic = zeros(256, 256*5);
%Creating dark square-img with smaller grey square inside
mat=ones(256,256);
mat(1:256,1:256)=64;
mat(128-32:128+32,128-32:128+32)=192;
mosaic(:,1:256)= mat;
%Randomly creating a noise matrix and multiplying by 10 to increase noise
%adding noice to img
noise = randn(256, 256)*10;
noiseMat = mat + noise;
mosaic(:,257:257+255) = noiseMat;

%creating 3 differnt averiging filters using fspecial
avgFilter1 = fspecial('average', 3); 
avgFilter2 = fspecial('average', 7);
avgFilter3 = fspecial('average', 13);

%using filter2 to apply filter
figure(1);
filteredMat1 = filter2(avgFilter1, noiseMat);
filteredMat2 = filter2(avgFilter2, noiseMat);
filteredMat3 = filter2(avgFilter3, noiseMat);
mosaic(:,513:513+255)=filteredMat1;
mosaic(:,769:769+255)=filteredMat2;
mosaic(:,1025:1280)=filteredMat3;
imshow(mosaic, [0 255]);


