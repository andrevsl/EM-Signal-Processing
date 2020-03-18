function [Eter Etmr Ere]=DeTETM(ES0,par)
%% Decomposition TE TM in Lossless medium
%%%TE
Eter=struct('Ex',[],'Ey',[],'Ez',zeros(par.Nfft, par.Nfft));
Ete=(par.kyy.*ES0.Ex-par.kxx.*ES0.Ey)./par.Kt;
Eter.Ex=Ete.*par.kyy./par.Kt;Eter.Ex=rnan(Eter.Ex);
Eter.Ey=-Ete.*par.kxx./par.Kt;Eter.Ey=rnan(Eter.Ey);
% plotSpectra1P(Eter,par,3)
% figure,
% imagesc(imag(ifft2(ifftshift(Eter.Ex))));

%%%TM
Etmr=struct('Ex',[],'Ey',[],'Ez',[]);
Etm=par.K*(par.kxx.*ES0.Ex+par.kyy.*ES0.Ey)./(par.Kt.*par.kz);
Etmr.Ex=par.kz.*Etm.*par.kxx./(par.K*par.Kt);Etmr.Ex=rnan(Etmr.Ex);
Etmr.Ey=par.kz.*Etm.*par.kyy./(par.K*par.Kt);Etmr.Ey=rnan(Etmr.Ey);
% Etmr.Ez=-(ES0.Ex.*par.Kx+ES0.Ey.*par.Ky)./par.Kz;

% plotSpectra1P(Etmr,par,3)

Ere=struct('Ex',[],'Ey',[],'Ez',[]);
Ere.Ex=Etmr.Ex+Eter.Ex;
Ere.Ey=Etmr.Ey+Eter.Ey;
Ere.Ez=-(ES0.Ex.*par.Kx+ES0.Ey.*par.Ky)./par.Kz;
% Etmz=-(ES0.Ex'.*par.Kx+ESy0'.*par.Ky)./par.Kz;
%%% E resultant

end