f=imread('blood1.tif');
f=double(f(1:256,1:256));
g=imread('enamel.tif');
g=double(g(1:256,1:256));
F=fft2(f);
G=fft2(g);
fg=sum(sum(f.*g))
ff=sqrt(sum(sum(f.*f)))
FG=sum(sum(conj(F).*G))/256/256
FF=sqrt(sum(sum(F.*F)))

colormap(gray);
figure(1);
subplot(1,2,1); imagesc(f);title('f');
subplot(1,2,2); imagesc(g);title('g');

figure(2);
subplot(1,2,1); imagesc(real(F));title('F');
subplot(1,2,2); imagesc(real(G));title('G');
colormap(gray);
