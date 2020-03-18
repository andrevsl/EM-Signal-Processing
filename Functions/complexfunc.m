function [w,u,v] = complexfunc(z)
% w=z.^2;
% w=z+0.1./z;
% w=1/2*(z-sqrt(z^2-4*0.1^2));
w=i*(1+z)./(1-z);
% w=(z-i)./(i*(i+z));

% w=exp(z/1);
%  w=log(z)
%w=exp(j*acos(z)); 
u=real(w);
v=imag(w);