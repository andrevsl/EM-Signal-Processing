function Er=INVPWS1P2(ESF,E,par)
Er.Ex= fftshift(ifft2((ESF.Ex)));
Er.Ex=Er.Ex(floor(par.Nfft/2)-floor(length(E.y)/2)+1:floor(par.Nfft/2)+2+floor(length(E.y)/2)-1,floor(par.Nfft/2)-floor(length(E.y)/2)+1:floor(par.Nfft/2)+2+floor(length(E.y)/2)-1);
Er.Ey= fftshift(ifft2((ESF.Ey)));
Er.Ey=Er.Ey(floor(par.Nfft/2)-floor(length(E.y)/2)+1:floor(par.Nfft/2)+2+floor(length(E.y)/2)-1,floor(par.Nfft/2)-floor(length(E.y)/2)+1:floor(par.Nfft/2)+2+floor(length(E.y)/2)-1);
Er.Ez= fftshift(ifft2((ESF.Ez)));
Er.Ez=Er.Ez(floor(par.Nfft/2)-floor(length(E.y)/2)+1:floor(par.Nfft/2)+2+floor(length(E.y)/2)-1,floor(par.Nfft/2)-floor(length(E.y)/2)+1:floor(par.Nfft/2)+2+floor(length(E.y)/2)-1);
Er.x=E.x;Er.y=E.y;Er.z=E.z;


end