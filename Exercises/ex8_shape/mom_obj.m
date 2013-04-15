
function [F_rect,c_rect]=mom_obj(rect)


m00=sum(sum(rect));

x=1:size(rect,2);
y=[1:size(rect,1)]';

x=ones(size(rect,1),1)*x;
y=y*ones(1,size(rect,2));

m10=sum(sum(x.*rect));
m01=sum(sum(y.*rect));

%m12=sum(sum(x.* (y.^2).*rect));

c_rect=[m10/m00 m01/m00]';

%compute now central moments mu11, mu02, mu20 

xx=x-c_rect(1);
yy=y-c_rect(2);

mu11=sum(sum(xx.*yy.*rect));
mu02=sum(sum( (yy.^2 ).*rect));
mu20=sum(sum( (xx.^2 ).*rect));

F_rect=[m00, mu11, mu02, mu20]';

return
