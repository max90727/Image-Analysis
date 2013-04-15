% exsim.m /kn 00-01-26
% inputs image I, and pattern g
%
% Calculate a similarity measure in every position in the image I 
% between the two matrices f and g.
% The similarity measure is based on Schwartz inequality:
% <f,g> <= norm_f * norm_g.
%
% f is a neighbourhood of the image I, equally in size to g.
% g is the matching pattern, must be odd.
%
% simularity measure sim = <f,g>/(norm_f * norm_g)

function sim=exsim(Im,gg)
I=double(Im); g=double(gg); %convert input vector values 
                            %to double precision floating point, if they
                            %are not already in double precision.
sI=size(I) %size of the image
sg=size(g) %size of the pattern

                            
%Calculate  the similarity measure  between the pattern AND  the neighborhoods 
%around each pixel in the image I. 

%1. Calculate the numerator 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the scalar product  between the pattern AND 
% all sub-images. If you call one such sub-image around a pixel as f, then 
%there are as many  scalars produced the scalar products <f,g> as pixels.
% Evidently,  the subpart image f has alwayst the same size as g. 
fg=filter2(g,I,'valid'); %scalar product <f,g>. 
% Because there are so many scalars, the result fg is an image.

%2. Calculate the denominator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%2a) calculate norm_f for each image-neighbourhood of size g
I2=I.*I;  %NOTE that I.*I means pointwise multiplication
c=ones(sg(1),sg(2));
sI2=filter2(c,I2,'valid') % sum of squares at each pixel which now holds squares
norm_f_image=sqrt(sI2);          % square root of each pixel in SI2...


%2b) calculate norm_g. This gives a single scalar.
norm_g=sqrt(sum(sum(g.*g)));%NOTE again note that there is a dot in the 
                            %product...g.*g and means pointwise
                            %pultiplication

                            
%3 calculate the similarity measures for the neighborhoods (of each pixel) in
%the original and the target pattern.
sim=fg./(norm_f_image*norm_g); % similarity measure

%4 PRESENT the results
%4a Marrk the found position(s),that is, the best and the worst ones
%find the minimum and maximum value in sim image
[k,l]=find(sim==max(max(sim))); %most similar positions
[i,j]=find(sim==min(min(sim))); %least similar positions
%4b mark them...
gx=(sg(1)-1)/2; gy=(sg(2)-1)/2;
for n=1:size(i),
   I(i(n)+(gx-1):i(n)+(gx+1),j(n)+(gy-1):j(n)+(gy+1))=zeros(3,3); %mark min with black
end
for m=1:size(k),
   I(k(m)+(gx-1):k(m)+(gx+1),l(m)+(gy-1):l(m)+(gy+1))=ones(3,3).*224; %mark max with white
end
%4c Show the result as  multiple images in one matlab figure.... 
figure(2); colormap(gray);
%subplot(2,2,1);imagesc(I);title('original image'); %square image
subplot(2,3,1);imagesc(I);title('original image'); axis image; 
subplot(10,12,20);imagesc(g); title('matching pattern'); axis image;
%subplot(2,2,3);imagesc(sim); title('similarity image'); %square image
subplot(2,3,4);imagesc(sim); title('similarity image'); axis image; 
