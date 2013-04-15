clear;
close all;
[magn, argument]=fmtest(256,[0.1,0.33]*pi,0.75); %give A a value!
figure(1);
imagesc(magn); colormap(gray); truesize; %display the magnitude image
figure(2);
imagesc(argument); colormap(gray); truesize;

magnone=ones(256,256); %1-magnitude image
im1_c=magnone.*exp(i*2*argument); %complex image
figure(17); lsdisp(im1_c); truesize; %color code for local orientations

[magn, argument]=fmtest(256,[0.1,0.33]*pi, 0.75);
LS=linsymexer(magn); %estimate the linear symmetry (LS)
LS
figure(18);
lsdisp(LS, 0.5); truesize;

fim=double(imread('fingerp.tif','tif')); %read the image
figure(4);
imagesc(fim);colormap(gray);axis image; %and display it
LS2=linsymexer(fim,[1.5,2]); %estimate LS
figure(5);
lsdisp(LS2,0.5); truesize;

mnt=LS2(:,:,3)-LS2(:,:,2);
%Display the result by imagesc and by modulating your response mnt with
%the original image via lsdisp:
figure(6);
lsdisp(fim.*exp(i*7*mnt)); truesize;

fim=double(imread('wood+chain.tif'));
figure(11);
subplot(2,2,1);imagesc(fim); colormap(gray); axis image;
subplot(2,2,2); lsdisp(linsymexer(fim,[0.4 4]),0.2); axis image;
subplot(2,2,3); lsdisp(linsymexer(fim,[6 10]),0.5); axis image