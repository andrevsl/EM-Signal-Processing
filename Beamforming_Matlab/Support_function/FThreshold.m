function X=FThreshold(X,th)
for ii=1:length(X)
   if(X(ii))==th
      X(ii)=10e-9; 
   end        
end