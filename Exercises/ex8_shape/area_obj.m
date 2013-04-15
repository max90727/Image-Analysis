function matlab_A=area_obj(lab_bact,k)

num_bin_bact=     (lab_bact==k); %make a binary image

 matlab_A= sum(sum(num_bin_bact));
 
return
end