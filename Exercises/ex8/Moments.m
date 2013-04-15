rect=zeros(21,21); %make a 7 by 3 rectangle image
rect(8:14,10:12)=ones(7,3);
figure(3);subplot(2,2,1); imshow(rect); %and display it
[F_rect,c_rect]=mom_obj(rect); %compute moments and centre
F_rect %print the moments [m0,0, 1,1, 2,0, and 0,2]
c_rect %print the centre [xm, ym]