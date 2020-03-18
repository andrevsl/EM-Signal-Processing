function Er=EmPad(EDir,ds)
Er=struct;
Er.Ex=zeros(size(EDir.Ex,1)+2,size(EDir.Ex,2)+2);
Er.Ey=zeros(size(EDir.Ex,1)+2,size(EDir.Ex,2)+2);
Er.Ez=zeros(size(EDir.Ex,1)+2,size(EDir.Ex,2)+2);

Er.Ex(2:end-1,2:end-1)=EDir.Ex;
Er.Ey(2:end-1,2:end-1)=EDir.Ey;
Er.Ez(2:end-1,2:end-1)=EDir.Ez;
Er.x=[(EDir.x(1)-ds),EDir.x,(EDir.x(end)+ds)];
Er.y=[(EDir.y(1)-ds),EDir.y,(EDir.y(end)+ds)];
Er.z=EDir.z;

end