 % Modo TMz excitado por um pulso gaussiano%

 %Defini��o das constantes%
 
 mu0=4*pi*1e-7;
 eps0=8.8541878176*1e-12;
 c=1/sqrt(mu0*eps0);
 nx=400;
 ny=400;
 S=0.7;
 
 %Interface%
 NSTEPS=input('Intera�oes de tempo:');
 
 %Pulso%
 ntau=6;
 T0=20;
 pulse(1:NSTEPS)=exp(-0.5*(((1:NSTEPS)-T0)/ntau).^2);
%  plot(1:NSTEPS,pulse)

 %%%% Defini��o do Material  
 %%%% Meio Ar (1) Interface(2)  Terra (3)
 
 Meio=[1 (50+1)/2  50];
 er(1:nx,1:99)=Meio(3);  % Em y=1:49 permissividade relativa � 100
 er(1:nx,1:100)=Meio(2); % Permissividade relativa da interface em y=100;
 er(1:nx,101:ny)=Meio(1); % Em y=51:nx a permissividade relativa � 1
 mur(1:nx,1:ny)=1;
 

 %Defini��o dos coeficientes de campo%
 % Como dx=dy
 Db(1:nx,1:nx)=S./(c*mu0*mur);
 Cb(1:nx,1:nx)=S./(c*eps0*er);
 
 
 %Condi��es iniciais dos Campos Ez,Hx e Hy - Fronteiras perfeitamente condutoras%
 Ez(1:nx,1:nx)=0;
 Hx(1:nx,1:nx)=0;
 Hy(1:nx,1:nx)=0;
 
 %Calculo dos campos%
 figure('position', [200 50 600 600])
 for n=1:NSTEPS
 
 %C�lculo da componete Ez %
 Ez(2:nx-1,2:ny-1)=Ez(2:nx-1,2:ny-1)+Cb(2:nx-1,2:ny-1).*( (Hy(2:nx-1,2:ny-1)-Hy(1:nx-2,2:ny-1)) - (Hx(2:nx-1,2:ny-1)-Hx(2:nx-1,1:ny-2)) ); 
 
 %Excita��o do pulso gaussiano%
 Ez(nx/2,250)=pulse(n);
 
 %C�lculo da componente Hx e Hy%
 Hx(2:nx-1,1:ny-1)=Hx(2:nx-1,1:ny-1)-Db(2:nx-1,1:ny-1).*( Ez(2:nx-1,2:ny)-Ez(2:nx-1,1:ny-1)); 
 Hy(1:nx-1,2:ny-1)=Hy(1:nx-1,2:ny-1)+Db(1:nx-1,2:ny-1).*( Ez(2:nx,2:ny-1)-Ez(1:nx-1,2:ny-1)); 
 
 %Representa��o gr�fica%

 imagesc(1:nx,1:ny,abs(Ez)'),xlabel('coordenada x'),ylabel('coordenada y');
 set(gca,'YDir','normal')
 colorbar; 
 title(['n=',num2str(n)]);


 pause(0.0000001);  
 
 end