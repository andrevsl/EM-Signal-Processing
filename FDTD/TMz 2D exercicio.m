% Modo TMz excitado por um pulso gaussiano%

%Definição das constantes%

 mu0=4*pi*1e-7;
 eps0=8.8541878176*1e-12;
 c=1/sqrt(mu0*eps0);
 imax=101;
 im=imax-1;
 jm=im;
 jmax=101;
 %Definição do meio%
  epsr=[1.0];
  sig=[0];
  mur=[1.0];
  p=[0];
  nmedia=1;
 %Interface%
%  NSTEPS=input('Interaçoes de tempo:');
NSTEPS=202;
 S=input('Enter normalized stability factor (c*sqrt(2)*dt/dx): ');
 
 %Definição do pulso gaussiano%
 tau=1.6e-15;
 fc=500e12;
 lambda=c/fc;
 dx=lambda/20;
 dt=S*dx/sqrt(2)/c;
 ntau=round(tau/dt);
 T0=3*ntau;
 pulse(1:NSTEPS)=exp(-((1:NSTEPS)-T0).^2/ntau^2).*sin(2*pi*fc*((1:NSTEPS)-T0)*dt);

 %Definição dos coeficientes de campo%
 for i=1:nmedia
 pme=sig(i)*dt/(2*(epsr(i)*eps0));
 Ca(i)=(1-pme)/(1+pme);
 Cb(i)=(dt/(epsr(i)*eps0*dx))/(1+pme);
 pmh(i)=p*dt/(2*(mur(i)*mu0));
 Da(i)=(1-pmh)/(1+pmh);
 Db(i)=(dt/(mur(i)*mu0*dx))/(1+pmh);
 end
 %Condições iniciais dos Campos Ez e Hy - Fronteiras perfeitamente condutoras% 
 Ez(1:imax,1:imax)=0;
 Hx(1:imax,1:jm)=0;
 Hy(1:im,1:imax)=0;
  
 mediaez(1:imax,1:jmax)=1;
 mediahx(1:imax,1:jm)=1;
 mediahy(1:im,1:jmax)=1;
 
%Calculo dos campos%
figure('Position',[100 100 850 600]);
 for n=1:NSTEPS

 Ez(2:im,2:jm)=Ca(mediaez(2:im,2:jm)).*Ez(2:im,2:jm)+...
     Cb(mediaez(2:im,2:jm)).*( Hy(2:im,2:jm)-Hy(1:(im-1),2:jm)-...
      Hx(2:im,2:jm)+Hx(2:im,1:(jm-1)));
 Ez(is,js)=pulse(n);

Hx(2:im,1:jm)=Da(mediahx(2:im,1:jm)).*Hx(2:im,1:jm)+...
     Db(mediahx(2:im,1:jm)).*( Ez(2:im,1:jm)-Ez(2:im,2:imax));
     
Hy(1:im,2:jm)=Da(mediahy(1:im,2:jm)).*Hy(1:im,2:jm)+...
     Db(mediahy(1:im,2:jm)).*( Ez(2:imax,2:jm)-Ez(1:im,2:jm));
      
    
 timestep=int2str(n);       
 
    imagesc(Ez');   shading flat;
    caxis([-0.2 0.2]);colorbar; 
    axis image; axis xy; 
    title(['Ez at time step = ',timestep]);
    
    F(n)=getframe;
    
    pause(0.03333333);
 
 end

% use 1st frame to get dimensions
[h, w, p] = size(F(1).cdata);
hf = figure; 
% resize figure based on frame's w x h, and place at (150, 150)
set(hf, 'Position', [100 150 w h]);
axis off
% Place frames at bottom left
movie(hf,F,4,30,[0 0 0 0]);
