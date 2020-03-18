function Et=Ezfrom2D(Es,par)
ES0=PWS1P(Es,par);
ES0.Ez=-(ES0.Ex.*par.Kx+ES0.Ey.*par.Ky)./par.Kz;
Et=INVPWS1P(ES0,Es);
end