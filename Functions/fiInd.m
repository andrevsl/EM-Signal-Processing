function ind=fiInd(A,freq)
ind=0;
for ii=1:length(A)
 if freq==A(ii)
    ind=ii;
    break;
 end    
end