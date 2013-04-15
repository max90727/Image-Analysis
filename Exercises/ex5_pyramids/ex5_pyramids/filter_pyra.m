s=1.0; %std in the spatial domain
x=-round(4*s):round(4*s); %sample grid
g1=exp(-(x.*x)/2/s/s); %smoothing filter
g1=g1/sum(g1); %gain=1
g2=2*g1; %gain=2
figure(1); subplot(6,1,1);stem(x,g1); %show filters
subplot(6,1,2);stem(x,g2);

f=ones(1,30);
y=conv(f,g1);
fg=filter2(g1,f,'valid')
subplot(6,1,3);stem(f);
subplot(6,1,4);stem(y);
fz=zeros(1,60); 
fz(1:2:60)= f; 
fzi=conv(fz,g2);
fg2=filter2(g2,fz,'valid')
subplot(6,1,5);stem(fz);
subplot(6,1,6);stem(fzi);

