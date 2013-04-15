function [Fv,x,y]=FD_contour(im,fig)

b_cell=bwboundaries(im); % extract the contour points. see help bwboundaries for output.
x= b_cell{1}(:,2); %there is one letter, hence one cell, which is a matrix. Pick col 2 for x coords.
y= -b_cell{1}(:,1); %

xer=resample_periodic(x,128); %and resample to 128 points %%%Question: Why resample?
yer=resample_periodic(y,128);


figure(fig); subplot(2,2,1); imshow(im); axis on; %display E
figure(fig); subplot(2,2,2); plot(x,y); %and its contour images
figure(fig); subplot(2,2,4); plot(xer,yer);
fe=xer+1i*yer; %make a 1D complex signal out of the contour points
Fe=fft(fe,128); %and compute its FDs
% compute the reference feature vector
Fv=normFD(Fe,[-4, -3, -2, -1, 2, 3, 4]); % use only the lower values of k




