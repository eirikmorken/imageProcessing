%Excercise3: non linear filtering
clear all;
close all;
%Creating same img as exercise2
mosaic = zeros(256, 256*5);
mat=ones(256,256);
mat(1:256,1:256)=64;
mat(128-32:128+32,128-32:128+32)=192;
mosaic(:,1:256)= mat;
noise = randn(256, 256)*10;
noiseMat = mat + noise;
mosaic(:,257:257+255) = noiseMat;

%Using a medfilt2 to apply median filtering
medFiltered1 = medfilt2(noiseMat); %3x3
medFiltered2 = medfilt2(noiseMat, [6, 6]);
medFiltered3 = medfilt2(noiseMat, [9, 9]);


figure(1);

mosaic(:,513:513+255)=medFiltered1;
mosaic(:,769:769+255)=medFiltered2;
mosaic(:,1025:1280)=medFiltered3;

%Can see an arguably better result with median filtering than avereging.
imshow(mosaic, [0 255]);
