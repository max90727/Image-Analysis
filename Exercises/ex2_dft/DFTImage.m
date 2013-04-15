f=double(imread('cameraman.tif'));
figure(1);colormap(gray(256)),
imagesc(f); axis image;

figure(2);
c=fft2(f);
f_inverse=ifft2(c);
subplot(2,2,1);imagesc(f);
subplot(2,2,2);imagesc(abs(c));
subplot(2,2,3);imagesc(log(abs(c)));
subplot(2,2,4);imagesc(fftshift(log(abs(c))));
colormap(gray(256));

f_error=f-f_inverse;
norm_f_error=sqrt(sum(sum(f_error.*f_error)))
norm_f=sqrt(sum(sum(f.*f)))
%fg=filter2(double(norm_f),double(norm_f_error),'valide');
rel_error=sum(sum(f_error.*f_error))
%rel_error=fg./(norm_f_error.*norm_f)
