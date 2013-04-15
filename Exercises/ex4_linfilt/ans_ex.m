
s=1; %standard deviation
%calculate coordinates of grid point by meshgrid function which needs the size of the grid,
%which in turn is determined by s. At 3*s a gaussian is 0.01, so the omitted parts of the gaussian
%are practically zero.



[x,y]=  meshgrid(-round(3*s):round(3*s),-round(3*s):round(3*s));    
g=exp(-(x.*x + y.*y)/(2*s*s));  %This yields a 2D smoothing filter  g=g/sum(sum(g));  
% sum of weights equals one  figure(1); subplot(2,1,1);mesh(xg,yg,g);  %show the filter  
g=g/sum(sum(g));  % sum of weights equals one  figure(1); subplot(2,1,1);mesh(xg,yg,g);  %show the filter  
figure(1); subplot(2,1,1);
mesh(x,y,g);  %show the filter  


% [x,y]=  meshgrid(-round(3*s):0.1:round(3*s),-round(3*s):0.1:round(3*s));    
% g=exp(-(x.*x + y.*y)/(2*s*s));  %This yields a 2D smoothing filter  g=g/sum(sum(g));  
% % sum of weights equals one  figure(1); subplot(2,1,1);mesh(xg,yg,g);  %show the filter  
% g=g/sum(sum(g));  % sum of weights equals one  figure(1); subplot(2,1,1);mesh(xg,yg,g);  %show the filter  
% figure(1); subplot(2,1,2);
% mesh(x,y,g);  %show the filter  



x1=-round(3*s):round(3*s); %sample grid
gx= exp(-(x1.*x1 )/(2*s*s)); %smoothing filter in the x?direction
gx=gx/sum(gx); % sum of weights equals one
gy=transpose(gx); %smoothing filter in the y?direction (transpose of gx)
figure(1); subplot(2,1,2); stem(x1,gx); %show the 1D smoothing filter


f=double(imread('flowers.jpg')); %load the image
f=f(1:256,1:256); %crop it to 256 x 256 pixels
y=conv2(f,g,'valid'); %filter the image
subplot(2,2,1); imshow(f/255); % original image
subplot(2,2,2); imshow(y/255); % smoothed image


figure(1); truesize;



yy=conv2(conv2(f,gx,'valid'),gx','valid'); %filter the image
subplot(2,2,4);imshow(yy/255); %and display it
e=y-yy; %compute error
sqrt(sum(sum(e.*e))) %print it on screen
subplot(2,2,3);imshow(yy/255); %and display it


% %error
% figure(2)
% subplot(1,2,1)
% imshow(fmtest)
% truesize
% yy=conv2(conv2(fmtest,gx,'valid'),gx,'valid'); %filter the image
% subplot(1,2,2);imagesc(yy); %and display it


% figure(3)
% %e=y-yy; %compute error
% %sum(sum(e.*e)) %print it on screen
% yy=conv2(conv2(fmtest,gx,'valid'),gx','valid'); %filter the image
% imagesc(yy); %and display it
% colormap(gray(256));
% truesize




Gx=fft(gx,256);%DFT of the filter using 256 taps, which is the same size as the image
gx, s %show gx and sigma
figure(2);
subplot(1,2,1);imshow(yy/255); %truesize%and display it
subplot(1,2,2); 
stem(-127:128,fftshift(abs(Gx))); %display the magnitude spectrum




s=2.4;
x1=-round(3*s):round(3*s); %sample grid
gx= exp(-(x1.*x1 )/(2*s*s)); %smoothing filter in the x?direction
gx=gx/sum(gx); % sum of weights equals one
gy=transpose(gx); %smoothing filter in the y?direction (transpose of gx)
figure(1);  
yy=conv2(conv2(f,gx,'valid'),gx','valid'); %filter the image
subplot(2,2,4);imshow(yy/255); %and display it

figure(2); truesize;



figure(3)
ff=imnoise(f/255,'gaussian',0,0.01).*255;  %add noise 
s=2.4;
x1=-round(3*s):round(3*s); %sample grid
gx= exp(-(x1.*x1 )/(2*s*s)); %smoothing filter in the x?direction
gx=gx/sum(gx); % sum of weights equals one
gy=transpose(gx); %smoothing filter in the y?direction (transpose of gx)
figure(1);  
yy=conv2(conv2(ff,gx,'valid'),gy,'valid'); %filter the image
subplot(3,2,1);imshow(ff/255); %and display it
subplot(3,2,2);imshow(yy/255); %and display it


%Now we derivate and find the edges in the flower image...
s=1; %standard deviation
x2=-round(3*s):round(3*s); %sample grid
dx= x2/(s*s).*exp(-(x2.*x2)/(2*s*s)); %derivative in the x?direction
dy=dx'; %derivative in the y?direction
x1=-round(3*s):round(3*s); %sample grid
gx= exp(-(x1.*x1 )/(2*s*s)); %smoothing filter in the x?direction
gx=gx/sum(gx); % sum of weights equals one
gy=gx'; %smoothing filter in the y?direction (transpose of gx)
subplot(3,2,3); stem(x1,gx); %1D smoothing filter
subplot(3,2,4); stem(x2,dx); %1D derivative filter



fx=conv2(conv2(f,dx,'valid'),gy,'valid'); %derivative in x-direction
fy=conv2(conv2(f,dy,'valid'),gx,'valid'); %derivative in y-direction
%subplot(2,2,1); imshow(f/255); %show the original image
subplot(3,2,5); imagesc(fx); colormap(gray); axis image; %show derivative image in the x..
subplot(3,2,6); imagesc(fy); colormap(gray); axis image; %and in the y-direction
 
truesize

figure(4)
Edge=sqrt(fx.*fx + fy.*fy); %edge filtered image (the magnitude of the gradient)
subplot(3,2,1); imshow(Edge/255); %and display it

Dx=fft(dx,256); %DFT of the dx filter....
subplot(3,2,2); 
% stem([-127:128]*pi/128,abs([-127:128]*pi/128),'r'); %and display the magnitude spectrum
% hold on
stem([-127:128]*pi/128,fftshift(abs(Dx))); %and display the magnitude spectrum


%Now we derivate and find the edges in the noisy image using the same sigma..
ff=imnoise(f/255,'gaussian',0,0.01).*255; %add noise
subplot(3,2,3); imshow(ff/255); %and display it
fx=conv2(conv2(ff,dx,'valid'),gy,'valid'); %derivative in x-direction
fy=conv2(conv2(ff,dy,'valid'),gx,'valid'); %derivative in y-direction
Edge=sqrt(fx.*fx + fy.*fy); %edge filtered image (the magnitude of the gradient)
subplot(3,2,4); imshow(Edge/255); %and display it


s=2; %standard deviation
x2=-round(3*s):round(3*s); %sample grid
dx= x2/(s*s).*exp(-(x2.*x2)/(2*s*s)); %derivative in the x?direction
dy=dx'; %derivative in the y?direction
x1=-round(3*s):round(3*s); %sample grid
gx= exp(-(x1.*x1 )/(2*s*s)); %smoothing filter in the x?direction
gx=gx/sum(gx); % sum of weights equals one
gy=gx'; %smoothing filter in the y?direction (transpose of gx)



fx=conv2(conv2(f,dx,'valid'),gy,'valid'); %derivative in x-direction
fy=conv2(conv2(f,dy,'valid'),gx,'valid'); %derivative in y-direction
%subplot(2,2,1); imshow(f/255); %show the original image
Edge=sqrt(fx.*fx + fy.*fy); %edge filtered image (the magnitude of the gradient)
subplot(3,2,5); imshow(Edge/255); %and display it

truesize
