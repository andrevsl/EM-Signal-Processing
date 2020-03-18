clc,clear
% M?thode du gradient conjugu?
A=Es; b=[-2;4];c=0;
X=C;  % Solution initiale
r=b-A*X;
d=r;
while norm(r)>0.0001
    alpha=r'*r./(d'*A*d);
    X=X-alpha*d;
    ri=r;
    r=ri-alpha*A*d;
    beta=r'*r./ri'*r;
    d=r+beta*d;
end
disp('la solution est:')
disp(X)