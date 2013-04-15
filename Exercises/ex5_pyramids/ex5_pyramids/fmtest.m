function [mag,arg]=fmtest(Imwidth,freqs,sweight)
% $Id: fmtest.m,v 1.2 2000/03/21 19:06:53 josef Exp $
% (C) Josef Bigun $Date: 2000/03/21 19:06:53 $
%
%  [mag,arg]=fmtest(Imwidth,freqs,sweight)
%
%This function generates a frequency modulated (square) test image. 
%The result consists of two matrices having equal  width and height. 
%The width is controlled by parameter Imwidth and the range of generated spatial 
%frequency is controlled  by the vector freqs=[min_freq, max_freq],
%assuming freqs consists of positive frequency limits  less than the Nyquist 
%frequency, which is PI. The input argument sweight is a real number between 0 and 1
%and controls the amount of signal relative  noise that is added to the right
%half of the image. The value 1 means no noise is added whereas the value 0 means
%that the right half consists of pure noise. The added noise, at full amplitude,
%is Gaussian with mean 0.5 and standard deviation 1/6;
%
%The output argument mag is in the range [0,1.0] whereas arg is in the range [0,2PI].
%
%The function can be called with 0,1,2 or 3 arguments:
%fmtest, fmtest(Imwidth), fmtest(Imwidth,freqs) and fmtest(Imwidth,freqs,sweight)
%The leftout arguments default to:
%        Imwidth=256 
%        freqs=[0.1PI, 0.40PI]; 
%        sweight=1;  
%The resulting image, mag, should be displayed with the truesize command issued after the display. 
%Otherwise aliasing may occur when the image is resized without low-pass filtering. 

%The rate of  change of the spatial frequencies is obtained by solving a
%differential equation:
%       dr     C
%       -- =  --- 
%       dw     w
%where dr is the  spatial coordinate increment (window size) 
%needed in order to represent a sinusoid of
%a given frequency w. The variable dw represents the increment in frequency.
%Essentially it says that the window size must decrease with increased frequency in a pace
%inversely proportional to the frequency, i.e. the higher the frequency smaller the window size.
%or space it needs to be displayed properly. The solution of this equation is 
%given by the internal variable freq, 
%with the boundary conditions minf and maxf occuring at the center and at 
%0.95Imwidht/2 respectively.
%
%It should be noted that, with the sampling period being 1, PI is the maximum frequency 
%that can be generated by means of a digital 1-D sinusoid. A 2-D digital sinusoid with the
%sampling period of 1, has the largest digital frequency of  sqrt(2)*PI  in the two diagonal 
%directions, and the highest digital frequency of PI in the vertical/horizontal directions.
%Hence the Nyquist frequency in 2D is direction dependent. For a 2D sinusoid the 
%sampling period (the average distance between pixels) is alpha where alpha varies between 1 and sqrt(2). 
%Consequently the worst case distance (coarsest discretization) between the sampling points is 
%sqrt(2) meaning that the highest sampling frequency  which can be employed is 2PI/sqrt(2)  
%in this worst case.  Consequently, the sinusoid with highest frequency that can be sampled 
%independent of orientation of the sinusoid is PI/sqrt(2)=0.7PI.  The maximum frequency
%argument of this routine, should never exceed 0.7PI i.e. freqs(2) < 0.7PI.  In practice 
%even 0.7PI can be too high if the lowest frequency is too low, since more frequencies will
%be squeezed to the same space meaning that each frequency will have less space to be 
%displayed on, causing antialiasing. Another source of antialiasing stems from the fact 
%that the frequencies of this routine increase "continiously" along the radii, whereas 
%the correctly representable sinusiods on a square grid have a discrete set of frequencies
%(compare this to the frequency coordinates of DFT). For this reason a good test image having
%both high as well as low frequencies must have a very large Imwidth.  
%


PI = 4*atan(1);
sma=32;

W=256;
maxf=0.40*PI;
minf=0.10*PI;
A=1;


if ( 0<nargin ),
W=Imwidth;
end

if ( 1<nargin ),
minf=freqs(1);
maxf=freqs(2);
end

if ( 2<nargin ),
A=sweight;
end


H=W;
maxr=0.95*(W/2);


y=linspace(H,1,H)'*ones(1,H);
x=ones(1,W)'*linspace(1,W,W);
x=x-W/2; y=y-H/2;

r=sqrt(x.*x + y.*y);

%C=maxf*maxf/2/maxr;freq=sqrt(2*C*r);
%ff=inline('-P1+log(x*P2+1)/x',2);P1=maxf;P2=maxr;C=fzero(ff, maxr/15,[],maxf,maxr);freq=log(C*r+1)/C;
C=log(maxf/minf)/maxr;freq=minf*exp(C*r);
mag=(cos(freq.*r)+1)/2; %Magnitude is in [0,1]
arg= mod(atan2(y,x), 2*PI); %angle is in [0,2PI]

mag= mag.*(r<maxr)+ 0.5 *ones(H,W).*(r>=maxr);
arg= arg.*(r<maxr)+ PI*ones(H,W).*(r>=maxr);

ns=(1/6)*randn(W,W/2)+0.5;
%mean(ns(:)), var(ns(:), figure(2); subplot(2,1,1); bar(linspace(-5,5,256), hist(ns(:),256))
ns(find(ns<0))=0;
ns(find(1<ns))=1;
%mean(ns(:)), var(ns(:), subplot(2,1,2); bar(linspace(-5,5,256), hist(ns(:),256))

              %A represents signal weight and B represents noise weight when A+B=1.  
B=1-A;        %a suitable definition of Signal to Noise (Energy) Ratio is SNR= 2log2(A/1-A) 

mag(:,W/2+1:W)=A*mag(:,W/2+1:W)+B*ns;


%figure(1); colormap(gray(256));
%subplot(1,2,1); imagesc(mag);axis image 
%subplot(1,2,2); imagesc(arg); axis image 
%imwrite((mag/max(mag(:))), 'fmtest.tif','tif')
%figure(2); imshow('fmtest.tif'); truesize; 


