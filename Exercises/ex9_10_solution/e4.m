clear all;%clear all variables from memory
close all;%close all figures

load char_w;
[Rw,xw, yw ] =FD_contour(char_w,1);

load char_e;
[Re,xe, ye ] =FD_contour(char_e,1);

%%% Enlarging: (scale change)
img=imresize(char_e,1.6,'bicubic'); %Enlarge E 1.6 times
[Se,sxe,sye]=FD_contour(img,3); %compute ref vector and contour points, and display

%%% rotation:
img2=imrotate(img,60,'bicubic'); %rotate img (scaled E) with 60 degrees
[SRe,x3re,y3re]=FD_contour(img2,4);


%%%% translation:
zs=zeros(round(1.5*size(img2))); %create a larger image
zs(32:(size(img2,1)+31),15:(size(img2,2)+14))=img2; %Translate the E character with ?x=15 and ?y=32
img3=zs;
[SRTe,x3re,y3re]=FD_contour(img3,5); 

dist_e=norm(SRTe-Re); %distance between scaled/rotated character E and reference E
dist_w=norm(SRTe-Rw); %distance between scaled/rotated character E and reference W

L=dist_w/dist_e;

disp('Likelihood that img is "char_e" rather than "char_w": ');
disp(L);
[Re Se SRe SRTe]