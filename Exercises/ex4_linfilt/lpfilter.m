clear;
s=1.4;
[x,y]=meshgrid(-round(3*s):round(3*s),-round(3*s):round(3*s));
g=exp(-(x.*x+y.*y)/(2*s*s));
g=g/sum(sum(g));

x1=-round(3*s):round(3*s); %sample grid
gx= exp(-(x1.*x1 )/(2*s*s)); %smoothing filter in the x?direction
gx=gx/sum(gx); % sum of weights equals one
gy=gx'; %smoothing filter in the y?direction (transpose of gx)


f=double(imread('flowers.jpg'));
f=f(1:256,1:256);
ff=imnoise(f/255,'gaussian',0,0.01).*255; %add noise
y=conv2(ff,g,'valid');
subplot(2,2,1); imshow(ff/255); % original image
subplot(2,2,2); imshow(y/255); % smoothed image

yy=conv2(conv2(ff,gx,'valid'),gy,'valid'); %filter the image
subplot(2,2,4);imshow(yy/255); %and display it

e=y-yy; %compute error
norm_error=sqrt(sum(sum(e.*e))) %print it on screen

Gx=fft(gx,256); %DFT of the filter
subplot(2,2,3);stem(-127:128,fftshift(abs(Gx))); %display the magnitude spectrum

fs=f(1:248,1:248); %extract subpart in the original image f (why 8:249?)
ffs=ff(1:248,1:248); %and in the noisy image ff
e=ffs-fs; norm_error_no=sqrt(sum(sum(e.*e))) %error between noisy and original image
e=yy-fs; norm_error_fo=sqrt(sum(sum(e.*e))) %error between filtered and original image
