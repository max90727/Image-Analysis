clear;
load imbact; %load the image imbact
figure(1); subplot(2,2,1); imshow(imbact); %and display it
%manually find a threshold value T from the histogram of the image
[hist_bact,xx]=imhist(imbact); %compute the histogram
figure(1); subplot(2,2,2); stem(xx,hist_bact); %and display it
%make a binary image by thresholding
T=101; %put in the value for the threshold T here
bin_bact=imbact<T; %make a binary image
figure(1); subplot(2,2,3); imshow(bin_bact); %and display it

[lab_bact,num]=bwlabel(bin_bact); %segment (label) the binary image
figure(2); subplot(2,2,1); imagesc(lab_bact);colormap(jet); axis image %display it
num %print on screen the number of objects

for k=1:num
A(k)=area_obj(lab_bact,k);
end
A
total_bact_pixel=sum(A)

%A_vect=area_obj(lab_bact,num); %compute the area of each object
A_vect=A %print the area values on the screen
figure(2); subplot(2,1,2); hist(A_vect,20); %and the area distribution


rect=zeros(21,21); %make a 7 by 3 rectangle image
rect(8:14,10:12)=ones(7,3);
figure(3);subplot(2,2,1); imshow(rect); %and display it
[F_rect,c_rect]=mom_obj(rect); %compute moments and centre
F_rect %print the moments [m00,mu11,mu20,mu02]
c_rect %print the centre [xc, yc]

load char_e; %load image
load char_w; %
figure(3);subplot(2,2,3); imshow(char_e); %and display them

figure(3);subplot(2,2,4); imshow(char_w);
[F_e,c_e]=mom_obj(char_e); %compute moments and centre
[F_w,c_w]=mom_obj(char_w); %
[F_e, F_w] %and print them on screen
[c_e, c_w]

load char_e; %load character E
figure(4); subplot(2,2,1); imshow(char_e); %and display it
[x y]=perim_sort(char_e); %extract and sort the boundary coordinates
f=x+i*y; %make a complex 1D signal out of the coordinates
N=length(f); %number of boundary points (N=262)
figure(4); subplot(2,2,2); plot(imag(f),real(f)); %plot the boundary
F=fft(f,N); %Fdescriptors of the boundary
fi=ifft(F,N); %go back to boundary points x+i*y
figure(4); subplot(2,2,3); plot(imag(fi),real(fi)); % and plot the boundary

CC=zeros(N,1); %start with a zero filter
% the Fd:s should be put in in pair, i.e. F(k) and F(-k) is a pair
% in the Brick-wall Fourier domain filter
CC=zeros(N,1); %start with a zero filter
CC(mod([0:29],N)+1)=ones(30,1); %add in ones in pair; F(k)
CC(mod([-29:-1],N)+1)=ones(29,1); %F(-k)
FC=F.*CC; % filter
f1=ifft(FC,N); % reconstruct the boundary from the low order Fd:s
figure(4); subplot(2,2,4); plot(imag(f1),real(f1)); %reconstructed boundary