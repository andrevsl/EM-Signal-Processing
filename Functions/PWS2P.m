function [ES0 ESF ESF2]=PWS2P(E2d0,E2df,par)

ES0.Ez=fftshift(fft2(E2d0.Ez,par.Nfft,par.Nfft));
ESF.Ez=fftshift(fft2(E2df.Ez,par.Nfft,par.Nfft));
ESF2.Ez=ES0.Ez.*par.Pg;
ES0.Ex=fftshift(fft2(E2d0.Ex,par.Nfft,par.Nfft));
ESF.Ex=fftshift(fft2(E2df.Ex,par.Nfft,par.Nfft));
ESF2.Ex=ES0.Ex.*par.Pg;
ES0.Ey=fftshift(fft2(E2d0.Ey,par.Nfft,par.Nfft));
ESF.Ey=fftshift(fft2(E2df.Ey,par.Nfft,par.Nfft));
ESF2.Ey=ES0.Ey.*par.Pg;

end