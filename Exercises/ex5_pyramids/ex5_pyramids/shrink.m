function S=shrink(I,M)
row=size(I,1);
col=size(I,2);

S=I(1:M:row,1:M:col);