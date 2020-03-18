%%% Mimo Beamforming validation
%%% Beam steered for Nselect users for Nantennas
%% Simulations Parameters 
clear all
BW=180e3; %% Bandwidth
Nt=11; %% Number of antennas
Nuselec=3; %% Equal or lower than the number of antennas
Nu=Nuselec; %% Number of Users
fc=30e9; %% Frequency mmWave
% Ns=10;  %% LTE frame with Ns subfames
Noise=-174+10*log10(BW); %%% Noise Power Modeling
th=9 ; %%% SINR threshould
Q=zeros(1,length(Nu)); % Average Capacity=0 Initial
%% User Grid
d=200;  %% Maximum Distance in meters
x=-d/2:10:d/2;%% X-axis grid Distance in meters
y=10:10:d;%% Y-axis Distance in meters
[X,Y]=meshgrid(x,y); %% XY Grid
duser=sqrt(X.^2+Y.^2); %% User distance
phiu=atan(X./Y); %% Angle of arrival of the user
%% Plot Users Position
figure
puser=[375 210 25]; %% Chosen 3 Fixed User Position 
scatter(X(puser),Y(puser)), hold on
scatter(0,0)
legend("Users","Base Station")
grid
xlabel('x-grid','fontsize',14,'fontweight','b');
ylabel('y-grid','fontsize',14,'fontweight','b');
%% User Path loss Modeling
clear Pl
duser(puser); %% Distance for each user  
alpha=61.4;beta=2;sigma=5.8;ecs=0; %% ecs=N(0,sigma^2);
Pl=alpha+10*beta*log10(duser(puser))+ecs;



%% Beamforming MIMO
%%Data Users Vector Initialization
clear user xk
xk=ones(Nuselec,1); %% Resources initialization
%% Mimo Channel
clear tempH ph Hkn 
Hkn=zeros(Nuselec,Nt);
user=1:Nuselec; %% Equal or lower than the number of antennas
ph=puser; %%% User position
%%% Angle of Arrival Vector
tempH=ones(Nuselec,1);
for n=1:Nt-1
tempH=[tempH exp(n*1j*pi*sin(phiu(ph))).']; %% Angle of arrival vector
end
%%%  Angle of Arrival Channel over antenna ports for far-field and desired layers/users with path loss
%%%  Perfect CSI Known
for i=1:Nuselec
   Hkn(i,1:Nt)=tempH(i,1:Nt)*sqrt(10^(-Pl(user(i))/10));
end

%%% Channel Attenuation
Pkn=abs(Hkn).^2;
PkndB=10*log10(Pkn);
% Zero forcing - Beamforming Weights - Precoding
clear  Wnk PWnk
Wnk=(Hkn')*pinv(Hkn*(Hkn)'); %%% Zero Forcing
PWnk=db(abs(Wnk).^2,10); 

% Normalization of Weigths - Application of Power Contraints
clear Wnk2 PWnkdB
Wnk2=sqrt(10^(16/10)/Nt)*Wnk./((abs(Wnk)));  %% < 16 dB
PWnkdB=db(abs(Wnk2).^2,10); %%%Power of Preconding Weigt

% Signal Power - Co-channel Inteference - Noise
clear yk Snk Pkn Icoint Pcoint Pnoise 
yk=Hkn*Wnk2*xk+sqrt(10^(Noise/10)); %%% H*w*x+Noise
Snk=diag(Hkn*Wnk2); %%% Transmitted Stream Signal
Pnk=abs(Snk).^2; %%% Power - Transmitted Stream Signal
Icoint=Hkn*Wnk2*xk-diag(Hkn*Wnk2); %%% Co-channel Interference
Pcoint=abs(Icoint).^2;  %%% Power - Co-channel Interference
Pnoise=10^(Noise/10); %%% Power - Noise

% %%% Capacity
clear Pyk SNR SNRdB SINR SINRdB C
Pyk=10*log10(abs(yk).^2); %%% Received signal power
SNR=Pnk./(Pnoise); %%% SNR
SNRdB=db(SNR,10); %%% SNR dB
SINR=Pnk./(Pcoint+Pnoise); %%% SINR - Signal to Interference Plus Noise
% SINR=SINRThreshold(SINR,th); %%% SINR > th otherwise 0
SINRdB=db(SINR,th); %%% SINR dB
C=BW*log2(1+SINR); %%% Capacity
%% Validation Of Beamforming Weigths by Antenna Array Radiation Pattern
c = 3e8;        % signal propagation speed
lambda = c/fc;  % wavelength
Uangle=180/pi*phiu(ph); %%% Azimutg Angle of the users in the grid

ula = phased.ULA(Nt,lambda/2);
ula.Element.BackBaffled = true;
% Plot the pattern
figure
 pattern(ula,fc,-180:180,0,'PropagationSpeed',c,'Type','powerdb',...
    'CoordinateSystem','rectangular','Weights',(conj(Wnk2))), hold on

pattern(ula,fc,-180:180,0,'PropagationSpeed',c,'Type','powerdb',...
    'CoordinateSystem','rectangular','Weights',sum(conj(Wnk2),2)), hold on
legend(num2str(Uangle(1))+" Degrees",num2str(Uangle(2))+" Degrees",num2str(Uangle(3))+" Degrees","Combined Pattern")
scatter(Uangle,[0 0 0])
ylim([-70 0])

