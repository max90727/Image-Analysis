f=imread('blood1.tif'); % read image
f=double(f(1:256,1:256));

c=fft2(f); % calculate FT

c(mod(100,256)+1,mod(200,256)+1) % c(30,50) is shown on the screen
c(mod(-100,256)+1,mod(-200,256)+1) % c(?30,?50) is shown on the screen