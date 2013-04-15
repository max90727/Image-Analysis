function E=expand(I,M)
row=size(I,1);
col=size(I,2);

E=zeros(M*row,M*col);
E(1:M:M*row,1:M:M*col)=I;