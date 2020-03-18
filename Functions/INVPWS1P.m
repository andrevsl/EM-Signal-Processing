function Er=INVPWS1P(ESF,E)
Er.Ex= ifft2(ifftshift(ESF.Ex));
Er.Ex=Er.Ex(1:length(E.y),1:length(E.x));
Er.Ey= ifft2(ifftshift(ESF.Ey));
Er.Ey=Er.Ey(1:length(E.y),1:length(E.x));
Er.Ez= ifft2(ifftshift(ESF.Ez));
Er.Ez=Er.Ez(1:length(E.y),1:length(E.x));
Er.x=E.x;Er.y=E.y;Er.z=E.z;


end