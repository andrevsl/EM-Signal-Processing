function par=Parameters2(er,sig,dist)
%%%Medium
par=struct()
par.mu0=4*pi*1e-7;
par.eps0=8.854e-12;
par.sig=sig;
par.er=er;
par.f=2.55e9;
par.w=2*pi*par.f;
par.w=2*pi*par.f;
par.c=1/sqrt(par.eps0*par.mu0);
%%%Medium 2
par.sig2=0;
par.er2=10;
%%%% Refrative Index


%%%% Wave Impedance
par.Z=sqrt(1j*par.w*par.mu0/(par.sig+1j*par.w*par.er*par.eps0));
par.Z2=sqrt(1j*par.w*par.mu0/(par.sig2+1j*par.w*par.er2*par.eps0));
par.Z0=sqrt(par.mu0/(par.er*par.eps0));
par.R=(par.Z2-par.Z)/(par.Z2+par.Z);
%%% Grid 
par.ds=1e-3;
par.Nfft=513;
par.dist=dist;

%%% Propagator
par.K=-1j*sqrt(1j*par.w*par.mu0*(par.sig+1j*par.w*par.er*par.eps0));
par.kx=pi/par.ds*linspace(-1,1,par.Nfft)/par.K;
par.ky=pi/par.ds*linspace(-1,1,par.Nfft)/par.K;
[par.Kx,par.Ky]=meshgrid(par.kx*par.K,par.ky*par.K);
[par.kxx,par.kyy]=meshgrid(par.kx,par.ky);
par.Kt=sqrt(par.kxx.^2+par.kyy.^2);
%par.Kz=sqrte(par.K^2-par.Kx.^2-par.Ky.^2);
par.Kz=conj(sqrt(par.K^2-par.Kx.'.^2-par.Ky.'.^2));
par.kz=par.Kz/par.K;
%par.Kz=conj(sqrt(par.K^2-par.Kx.^2-par.Ky.^2));
par.Pg=exp(-1j*par.Kz*par.dist);


