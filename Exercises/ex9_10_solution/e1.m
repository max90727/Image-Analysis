clear all;%clear all variables from memory
close all;%close all figures

load char_e; %load character E
[Re,xe,ye]=FD_contour(char_e,1); %compute ref vector and display contour images in Fig. 1
disp('Reference vector for char_e:'); %print the reference vector on screen
disp(Re');

load char_w; %load character W
[Rw,xw,yw]=FD_contour(char_w,2); %compute ref vector and contour images , and display
disp('Reference vector for char_w:'); disp(Rw');
