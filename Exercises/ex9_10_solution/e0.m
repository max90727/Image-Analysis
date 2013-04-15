clear all;%clear all variables from memory
close all;%close all figures

load char_e; %load the character E
b_cell=bwboundaries(char_e); % extract the contour points. see help bwboundaries for output.
xe= b_cell{1}(:,2); %there is one letter, hence one cell, which is a matrix. Pick col 2 for x coords.
ye=- b_cell{1}(:,1); %

xer=resample_periodic(xe,128); %and resample to 128 points %%%Question: Why resample?
yer=resample_periodic(ye,128);


figure(1); subplot(2,2,1); imshow(char_e); axis on; %display E
figure(1); subplot(2,2,2); plot(xe,ye); %and its contour images
figure(1); subplot(2,2,4); plot(xer,yer);
fe=xer+1i*yer; %make a 1D complex signal out of the contour points
Fe=fft(fe,128); %and compute its FDs
% compute the reference feature vector
Re=normFD(Fe,[-4, -3, -2, -1, 2, 3, 4]); % use only the lower values of k

disp('Reference vector for char_e:'); %print the reference vector on screen
disp(Re');

