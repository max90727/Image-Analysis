function [F_rect,c_rect]=mom_obj(B)
m00=sum(sum(char));

x=1:size(B,2);
y=[1:size(B,1)]';
x=x*ones(size(B,1),1);
y=y*ones(size(B,1),2);
m10=sum(sum(x.*B));
m01=sum(sum(y.*B));

c_rect=[m10/m00 m01/m00];

xx=x-c_rect(1);
yy=y-c_rect(2);
mu11=sum(sum(xx.*yy.*B));
mu20=sum(sum(xx.^2.*B));
mu02=sum(sum(yy.^2.*B));
F_rect=[m00,mu11,mu20,mu02]';
return