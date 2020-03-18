%%% Selection by Exhaustive search of the best 4 users for a fixed numbers of available users. 
%%% Empirical CDF of the Capacity for random distributions of fixed users position
%% Simulations Parameters 
clear all
addpath('Support_function')
BW=180e3; %% Bandwidth
Nt=4; %% Number of antennas
Nuselec=4; %% Equal or lower than the number of antennas
Nu=12; %% Number of Users
Nrealization=1000; %% Number of random distribution of the users position
fc=2.5e9; %% Frequency 
fmm=28e9; %% Frequency mmWave
Noise=-174+10*log10(BW); %%% Noise Power Modeling
th=9 ; %%% SINR threshould
Q=zeros(1,Nrealization); % Average Capacity=0 Initial
%% User Grid
d=200;  %% Maximum Distance in meters
x=-d/2:10:d/2; %% X-axis grid Distance in meters
y=10:10:d; %% Y-axis Distance in meters

[X,Y]=meshgrid(x,y); %% XY Grid
duser=sqrt(X.^2+Y.^2); %% User distance
phiu=atan(Y./X); %% Angle of arrival of the user
%% Plot Users Position
% figure
% puser=randi([0 length(x)*length(y)],1,Nu(end));
% scatter(X(puser),Y(puser)), hold on
% scatter(0,0)
%% User Selection
for k=1:Nrealization
%%%Data Users Vector Initialization
%%% User Path loss Modeling
clear puser Pl
puser=randi([1 length(x)*length(y)],1,Nu); %% Random user position 
duser(puser); %% Distance for each user  
Pl=22.7 + 36.7*log10(duser(puser)) + 26*log10(fc/1e9); %%% The standard 3GPP urban micro (UMi) path 

%%% User Combinations
clear user xk
xk=ones(Nuselec,1); %% Resources initialization
user=combnk(1:Nu,Nuselec); %%% Combination(Nu,Nt) for all possibilities

for j=1:length(user(:,1))
clear tempH ph Hkn 
Hkn=zeros(Nuselec,Nt);
ph=puser(user(j,:));
%%% Angle of Arrival Vector
tempH=[ones(Nuselec,1) exp(1j*pi*sin(phiu(ph))).' exp(1j*pi*2*sin(phiu(ph))).' exp(1j*pi*3*sin(phiu(ph))).'];

%%% Angle of Arrival Channel for antenna ports and desired layers/users -
%%% Farfield Approximation
   for i=1:Nuselec
   Hkn(i,1:Nt)=tempH(i,1:Nt)*sqrt(10^(-Pl(user(j,i))/10));
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
Wnk2=sqrt(10^(16/10)/Nt)*Wnk./abs(Wnk);  %% < 16 dB
PWnkdB=db(abs(Wnk2).^2,10); %%%Power of Preconding Weigt

% Signal Power - Co-channel Inteference - Noise
clear yk Snk Pkn Icoint Pcoint Pnoise 
yk=Hkn*Wnk2*xk+sqrt(10^(Noise/10)); %%% H*w*x+Noise
Snk=diag(Hkn*Wnk2); %%% Transmitted Stream Signal
Pnk=abs(Snk).^2; %%% Power - Transmitted Stream Signal
Icoint=Hkn*Wnk2*xk-diag(Hkn*Wnk2); %%% Co-channel Interference
Pcoint=abs(Icoint).^2;  %%% Power - Co-channel Interference
Pnoise=10^(Noise/10); %%% Power - Noise

%%% Capacity
clear Pyk SNR SNRdB SINR SINRdB C
Pyk=10*log10(abs(yk).^2); %%% Received signal power
SNR=Pnk./(Pnoise); %%% SNR
SNRdB=db(SNR,10); %%% SNR
SINR=Pnk./(Pcoint+Pnoise); %%% SINR - Signal to Interference Plus Noise
SINR=SINRThreshold(SINR,th); %%% SINR > th otherwise 0
SINRdB=db(SINR,10); %%% SINR dB
C=BW*log2(1+SINR); %%% Capacity

if mean(C) > Q(k)
    Q(k)=mean(C);
end

end
   
end
%% CDF Capacity for Nusers
figure,
cdfplot(Q)
grid
ylabel('CDF ','fontsize',14,'fontweight','b');
xlabel('Capacity (bits/s)','fontsize',14,'fontweight','b');
set(gca,...
    'Units','normalized',...
    'FontUnits','points',...
    'FontWeight','Bold',...
    'FontName','Times',...)
    'FontSize',16)

title("CDF 12 Available Users")

