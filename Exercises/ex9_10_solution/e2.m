clear all;%clear all variables from memory
close all;%close all figures

load char_w;
[Rw,xw, yw ] =FD_contour(char_w,1);

load char_e;
[Re,xe, ye ] =FD_contour(char_e,1);

img=imresize(char_e,1.6,'bicubic'); %Enlarge E 1.6 times
[Se,sxe,sye]=FD_contour(img,3); %compute ref vector and contour points, and display

dist_e=norm(Se-Re) %distance between scaled character E and reference E
dist_w=norm(Se-Rw) %distance between scaled character E and reference W

L=dist_w/dist_e;

disp('Likelihood that img is "char_e" rather than "char_w": ');
disp(L);
disp(Re');