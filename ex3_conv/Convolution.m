L=zeros(64,64); %zero matrix 64 x 64
L(29:39,29:39)=ones(11,11); %put in a white square 7 x 7
subplot(2,2,1); imshow(L); %show it

FL=fft2(L); %2D DFT
subplot(2,2,2); imshow(fftshift(log10(abs(FL))+1)); %show the centralized DFT

d=circle(10); %generate a white circle on a black background
D=fft2(d); %2D DFT
subplot(2,2,3); imshow(d); %show the circle
subplot(2,2,4); imagesc(fftshift(abs(D))); colormap(gray); axis image %and its DFT