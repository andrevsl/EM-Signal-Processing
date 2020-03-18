function E=importCSTfieldInterp(Path,d,minx,maxx,miny,maxy,minz,maxz)
%% Path - File Path and name
%% Flag 0 - 3D volume
%% Flag 1 - 2d  Y 
%cplane=0;
%Path='e-field (f=2.6) [1].txt'
%d=[0.25 0.25 0.25]
%Path='e-field (f=27.18) [1].txt'
headerlinesIn=2;
A=importdata(Path,' ',headerlinesIn);
E=struct('x',unique(A.data(:,1)),'y',unique(A.data(:,2)),'z',unique(A.data(:,3)));
E.Ex=reshape(A.data(:,4)+1j*A.data(:,7),[length(E.x) length(E.y) length(E.z)]);
E.Ey=reshape(A.data(:,5)+1j*A.data(:,8),[length(E.x) length(E.y) length(E.z)]);
E.Ez=reshape(A.data(:,6)+1j*A.data(:,9),[length(E.x) length(E.y) length(E.z)]);
dx=d(1);dy=d(2);dz=d(3);
if nargin <=2
v=ceil(min(E.y)):dy:floor(max(E.y)); u=ceil(min(E.x)):dx:floor(max(E.x)); 
w=ceil(min(E.z)):dz:floor(max(E.z));
else
v=miny:dy:maxy; u=minx:dx:maxx; 
w=minz:dz:maxz; 
end

[U,V,W]=meshgrid(u,v,w);
[X,Y,Z]=meshgrid(E.x,E.y,E.z);
Ex=interp3(X,Y,Z,permute(E.Ex,[2 1 3]),U,V,W);
Ey=interp3(X,Y,Z,permute(E.Ey,[2 1 3]),U,V,W);
Ez=interp3(X,Y,Z,permute(E.Ez,[2 1 3]),U,V,W);
%imagesc(abs(squeeze(Ez(:,4,:))))
    E.x=u;E.y=v;E.z=w;
    E.Ex=Ex;E.Ey=Ey;E.Ez=Ez;


end



