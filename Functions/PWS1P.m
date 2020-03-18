function ES0=PWS1P(E2d0,par)
ES0.Ez=fftshift(fft2(E2d0.Ez,par.Nfft,par.Nfft));
ES0.Ex=fftshift(fft2(E2d0.Ex,par.Nfft,par.Nfft));
ES0.Ey=fftshift(fft2(E2d0.Ey,par.Nfft,par.Nfft));
end

