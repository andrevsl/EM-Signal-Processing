function SINR=SINRThreshold(SINR,th)
for ii=1:length(SINR)
   if(SINR(ii))<th
      SINR(ii)=0; 
   end        
end