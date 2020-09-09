% II. Pre-processing: de-noising
%Step 1: load the image and artificially add some noise
clear all;
close all;
img = imread('ic2.tif');
noisy_img = imnoise( img, 'gaussian');

figure();
subplot(1,2,1),imshow(img);
subplot(1,2,2),imshow(noisy_img);

%Step 2: de-noise the image

%Avereage
avgFilter = fspecial('average', [2, 2]);
avgFilteredImg = filter2(avgFilter, noisy_img);

%Median
medianImg = medfilt2(noisy_img);

%Wiener
wienerImg = wiener2(noisy_img);

figure();
subplot(1,3,1), imshow(avgFilteredImg, [0 255]);
subplot(1,3,2), imshow(medianImg);
subplot(1,3,3), imshow(wienerImg);


%III. Processing: low level feature detection
%Step3:highlight edges
%%[Gx, Gy] = imgradientxy(wienerImg, 'prewit');
wienerImgDouble = double(wienerImg);

Gx = [0 0 0; 1 0 -1; 0 0 0];
Gy = [0 1 0; 0 0 0; 0 -1 0];

%Optional methods:
%gradientX2 = imfilter(noisyImgDouble, Gx, 'conv');
%gradientY2 = imfilter(noisyImgDouble, Gy, 'conv');

gradientX = filter2(Gx,wienerImgDouble);
gradientY = filter2(Gy,wienerImgDouble);

%Finding the norm of the gradient
normImg = sqrt(gradientX.*gradientX + gradientY.*gradientY);
%level = graythresh(normImg) Was my orignal plan but a custom value appear
%to work better.
BW = imbinarize(uint8(normImg), 0.4);
figure()
subplot(1,3,1), imshow(gradientX, []);
subplot(1,3,2), imshow(gradientY, []);
subplot(1,3,3), imshow(BW);

%2. Find zero crossings of the Laplacian
LaplacianPattern = [ 0 1 0; 1 -4 1; 0 1 0];
LaplaceImg = filter2(LaplacianPattern, wienerImgDouble);
laplaceEdge = edge(LaplaceImg, 'zerocross');
% Gets multple zerocrossings per edge, which gives more edges then it
% should. This can probably be mitigated but for now it appears Laplace is
% not the best method for this purpose.

%3. Canny edge detector
canny = edge(wienerImgDouble, 'canny');
figure()
subplot(1, 3, 1), imshow(BW);
subplot(1, 3, 2), imshow(laplaceEdge);
subplot(1,3,3), imshow(canny);

%B. Step 4: compute the Radon transform
radonGradient = radon(BW);
radonLaplace = radon(laplaceEdge);
radonCanny = radon(canny);
figure();
subplot(1, 3, 1), imshow(radonGradient, []);
subplot(1, 3, 2), imshow(radonLaplace, []);
subplot(1, 3, 3), imshow(radonCanny, []);

% IV. Post-processing: high level detection & interpretation
%Type following in command line: interactiveLine(canny,radonCanny, 5);


% B. Step 6: find the image orientation and rotate it

V = max(radonCanny); %Creating vector of max values for each column
[y, x] = max(V(1:90)+V(91:180));
%maxOfRowVectorSplit2 = max(maxOfColoumnV(91:180));
figure()
%plot(1:180,maxOfColoumnV(1:180));
subplot(1,2,1), plot(V(1:180));
subplot(1,2,2), plot(V(1:90)+V(91:180));

rotatedImg = imrotate(img,-x,'crop');
figure()
subplot(1,2,1),imshow(img);
subplot(1,2,2),imshow(rotatedImg);


