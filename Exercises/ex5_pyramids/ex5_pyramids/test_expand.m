fmt=fmtest(256, [0.1*pi 0.3*pi]); %generate the image fmt
figure(2); imshow(fmt); truesize; %and display in truesize

fmt_s2=expand(fmt,2); %shrink by 2
figure(3);imshow(fmt_s2);truesize; %and display

s=1.0; %std in the spatial domain
x=-round(4*s):round(4*s); %sample grid
g1=exp(-(x.*x)/2/s/s); %smoothing filter
g1=g1/sum(g1); %gain=1
g2=g1*2;

y=conv2(conv2(fmt,g1,'same'),g1','same');
fmtsmooth=expand(y,2);
figure(4);imshow(fmtsmooth);truesize; 

e128_1=expand(y128,2); %first expand
e128_2=conv2(conv2(e128_1,g2,'same'),g2','same'); %then interpolate
L256=fmt-e128_2; %take the difference
e64_1=expand(y64,2); %first expand
e64_2=conv2(conv2(e64_1,g2,'same'),g2','same'); %then interpolate
L128=y128-e64_2; %take the difference
e32_1=expand(y32,2); %first expand
e32_2=conv2(conv2(e32_1,g2,'same'),g2','same'); %then interpolate
L64=y64-e32_2; %take the difference
%display the Laplacian pyramid in truesize
figure(9); imagesc(L256); colormap(gray); truesize;
figure(10); imagesc(L128); colormap(gray); truesize;
figure(11); imagesc(L64); colormap(gray); truesize;