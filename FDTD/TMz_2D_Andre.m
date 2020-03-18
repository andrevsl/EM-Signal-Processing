 % Modo TM excitado por um pulso gaussiano%

 %Definição das constantes%
 
 mu0=4*pi*1e-7;
 eps0=8.8541878176*1e-12;
 c=1/sqrt(mu0*eps0);
 nx=300;
 ny=300;

 
 %Interface%
 NSTEPS=input('Interaçoes de tempo:');
 
 ntau=6;
 T0=20;
 pulse(1:NSTEPS)=exp(-0.5*(((1:NSTEPS)-T0)/ntau).^2);
 plot(1:NSTEPS,pulse)
 
 %%%%definição do Material  
 
 er(1:nx,1:nx)=1;
 mur(1:nx,1:ny)=1;

 %Definição dos coeficientes de campo%
 % Como dx=dy
 Db(1:nx,1:nx)=0.5;  %S./(c*mu0*mur);
 Cb(1:nx,1:nx)=0.5;  %S./(c*eps0*er);
 
 
 %Condições iniciais dos Campos Ez,Hx e Hy - Fronteiras perfeitamente condutoras%
 Ez(1:nx,1:nx)=0;
 Hx(1:nx,1:nx)=0;
 Hy(1:nx,1:nx)=0;
 
 %Calculo dos campos%
  figure('position', [200 50 600 600])
 for n=1:NSTEPS
 
 %Cálculo da componete Ez %
 Ez(2:nx-1,2:ny-1)=Ez(2:nx-1,2:ny-1)+Cb(2:nx-1,2:ny-1).*( (Hy(2:nx-1,2:ny-1)-Hy(1:nx-2,2:ny-1)) - (Hx(2:nx-1,2:ny-1)-Hx(2:nx-1,1:ny-2)) ); 
 %Excitação do pulso gaussiano%
 Ez(nx/2,ny/2)=pulse(n);
 
 %Cálculo da componente Hx e Hy%
 Hx(2:nx-1,1:ny-1)=Hx(2:nx-1,1:ny-1)-Db(2:nx-1,1:ny-1).*( Ez(2:nx-1,2:ny)-Ez(2:nx-1,1:ny-1)); 
 Hy(1:nx-1,2:ny-1)=Hy(1:nx-1,2:ny-1)+Db(1:nx-1,2:ny-1).*( Ez(2:nx,2:ny-1)-Ez(1:nx-1,2:ny-1)); 
 
 %Representação gráfica%

 imagesc(1:nx,1:ny,abs(Ez)),xlabel('coordenada x'),ylabel('coordenada y');
 set(gca,'YDir','normal')
 colorbar; 
 title(['n=',num2str(n)]);


 pause(0.0000001);  
 
 end