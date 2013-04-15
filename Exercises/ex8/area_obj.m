function A=area_obj(lab_bact,num)
num_bin_bact=(lab_bact==num);
A=sum(sum(num_bin_bact));
return
end