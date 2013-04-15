f=imread('cameraman.tif');
f=double(f);
subplot(2,2,1); imagesc(f);title('cameraman.tif');

E=base(256,10,5); %generate the base image E of size 256x256, krow=5 and kcol=?10
subplot(2,2,2); imagesc(real(E));title('real E');

proj=sum(sum(conj(E).*f)) %compute the projection
c=fft2(f); %the DFT of the image f of size 256x256
c(mod(5,256)+1,mod(-10,256)+1); %compare with the DFT value for krow=5 and kcol=?10
scar=proj./(sqrt(sum(sum(E.*E)))*sqrt((sum(sum(f.*f)))))
subplot(2,2,3); imagesc(real(c));title('c');
colormap(gray(256));