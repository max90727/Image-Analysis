s=2.4; %standard deviation
x2=-round(3*s):round(3*s); %sample grid
dx= x2/(s*s).*exp(-(x2.*x2)/(2*s*s)); %derivative in the x?direction
dy=dx'; %derivative in the y?direction
x1=-round(3*s):round(3*s); %sample grid
gx= exp(-(x1.*x1 )/(2*s*s)); %smoothing filter in the x?direction
gx=gx/sum(gx); % sum of weights equals one
gy=gx'; %smoothing filter in the y?direction (transpose of gx)
subplot(3,2,3); stem(x1,gx); %1D smoothing filter
subplot(3,2,4); stem(x2,dx); %1D derivative filter

f=double(imread('flowers.jpg'));
f=f(1:256,1:256);
ff=imnoise(f/255,'gaussian',0,0.01).*255; %add noise
fx=conv2(conv2(ff,dx,'valid'),gy,'valid'); %derivative in x-direction
fy=conv2(conv2(ff,dy,'valid'),gx,'valid'); %derivative in y-direction

subplot(3,2,1); imshow(ff/255); %show the original image
subplot(3,2,6); imagesc(fx); colormap(gray); axis image; %show derivative image in the xsubplot(
subplot(3,2,5); imagesc(fy); colormap(gray); axis image; %and in the y-direction
y=conv2(ff,gx,'valid'); %filter the image
subplot(3,2,2); imshow(y/255); %and display it


figure(2);
Edge=sqrt(fx.*fx + fy.*fy); %edge filtered image (the magnitude of the gradient)
subplot(3,2,1); imshow(Edge/255); %and display it

Dx=fft(dx,256); %DFT of the dx filter
subplot(3,2,2);stem([-127:128]*pi/128,fftshift(abs(Dx))); %and display the magnitude spectrum
ff=imnoise(f/255,'gaussian',0,0.01).*255; %add noise
subplot(3,2,3); imshow(ff/255); %and display it
fx=conv2(conv2(ff,dx,'valid'),gy,'valid'); %derivative in x-direction
fy=conv2(conv2(ff,dy,'valid'),gx,'valid'); %derivative in y-direction
%subplot(3,2,6); imagesc(fx); colormap(gray); axis image; %show derivative image in the xsubplot(
%subplot(3,2,5); imagesc(fy); colormap(gray); axis image; %and in the y-direction
Edge=sqrt(fx.*fx + fy.*fy); %edge filtered image (the magnitude of the gradient)
subplot(3,2,4); imshow(Edge/255); %and display it


s=1; %standard deviation
x2=-round(3*s):round(3*s); %sample grid
dx= x2/(s*s).*exp(-(x2.*x2)/(2*s*s)); %derivative in the x?direction
dy=dx'; %derivative in the y?direction
x1=-round(3*s):round(3*s); %sample grid
gx= exp(-(x1.*x1 )/(2*s*s)); %smoothing filter in the x?direction
gx=gx/sum(gx); % sum of weights equals one
gy=gx'; %smoothing filter in the y?direction (transpose of gx)
ff=imnoise(f/255,'gaussian',0,0.01).*255; %add noise
fx=conv2(conv2(ff,dx,'valid'),gy,'valid'); %derivative in x-direction
fy=conv2(conv2(ff,dy,'valid'),gx,'valid'); %derivative in y-direction
%subplot(3,2,6); imagesc(fx); colormap(gray); axis image; %show derivative image in the xsubplot(
%subplot(3,2,5); imagesc(fy); colormap(gray); axis image; %and in the y-direction
Edge=sqrt(fx.*fx + fy.*fy); %edge filtered image (the magnitude of the gradient)
subplot(3,2,5); imshow(Edge/255); %and display it
