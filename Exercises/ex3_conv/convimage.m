f=imread('flowers.jpg');
f=double(f(1:256,1:256));
subplot(2,2,1);imagesc(f);

g=ones(21,21)/(21*21);
y=conv2(f,g);
subplot(2,2,2); imshow(y/255);

F=fft2(f,256,256);
G=fft2(g,256,256);
Y=F.*G;
yy1=real(ifft2(Y));
subplot(2,2,3);imshow(yy1/255);

F2=fft2(y,276,276);
G2=fft2(g,276,276);
Y2=F2.*G2;
yy2=real(ifft2(Y2));
subplot(2,2,4);imshow(yy2/255);
colormap(gray);