%%% Mean Square Error of the Neural Network Estimator vs Bartlett/Capon
%% Neural Network Trainning sequence voltage with Noise
clear all
% addpath('Support_function')
Nt=10; %%% Number of Antennas - Spacing Lambda/2
SNR=[100,40]; %% SNR for two Cases
clear ang a1 Vr azimuth index
ang=-75:0.1:75; %%% Azimuth angle space

%%% Angle of Arrivals Voltages Training Sequence for SNR=100 and 40
for na=1:length(ang) 
for t=1:length(SNR)   
%%% Noise Parameters
sig2=1./10.^(SNR(t)/10); %%% Noise Power - variance 
noise=randn(1,Nt)+j*randn(1,Nt); %%% Noise Signal
Rn=sig2*diag(noise./max(abs(noise))); %%% Noise Correlation Matrix
nnoise=sqrt(sig2)*noise./abs(noise); %%% Antenna Noise Voltages
a1=[1]; %%% Inital Initializaiont of Signal 1 Channel Vector    
for n=1:Nt-1
a1=[a1 exp(n*1j*pi*sin(ang(na)*pi/180))];
end
a1=a1+nnoise;
Vr(:,na,t)=[real(a1),imag(a1)];  %%% Inputs splited in real part and imag part for Voltages
angt(t,na)=ang(na);
end
end
%%% Shuffle of indexes and concatantion of data for two SNR
index=randperm(na*t);
Vr2=Vr(:,:,1);Vr2(:,na+1:na*t)=Vr(:,:,2);
angt2=angt(1,:);angt2(na+1:na*t)=angt(2,:);
Vre(:,:)=Vr2(:,index);
azimuth=angt2(index);
%%% Building NN with 30 Hidden Layers
net = feedforwardnet(30);
%%% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
%%% NN Training
[net,tr] = train(net,Vre,azimuth);
%%% Perfomance evaluation
y=net(Vre);
perf = mse(net,azimuth,y,'regularization', 0.01)

%% MSE AOA Estimator Neural Network - Bartlett -  Capon for different SNR
%%% Parameters
Nt=10; %%% Number of Antennas - Spacing Lambda/2
s=[1].'; %%% Source Amplitudes
Rss=1; %%% Source correlation Matrix for 1 user
SNR=5:10:50; %%  SNR range for MSE calculation
ang=-50:1:50; %%  Validation Angles Sequence for MSE Calculations
%% Loop SNR
for t=1:length(SNR)
%%% Noiser Parameters
sig2=1./10.^(SNR(t)/10); %%% Noise Power - variance 
for m=1:length(ang)
noise=randn(1,Nt)+j*randn(1,Nt); %%% Noise Signal
Rn=sig2*diag(noise./max(abs(noise))); %%% Noise Correlation Matrix
nnoise=sqrt(sig2)*noise./abs(noise); %%% Antenna Noise Voltages

%%% Channel of the received Signal
a1=[1]; %%% Inital Initializaiont of the Signal Channel Vector
for n=1:Nt-1
a1=[a1 exp(n*1j*pi*sin(ang(m)*pi/180))];
end
A=a1.'+nnoise.'; %%%  Gaussian Additive Noise
Rxx=A*Rss*A'; %%% Channel Autocorrleation Matrix
az=-90:0.05:90; %%% Azimuth angle space

%%% Bartlett/Capon Estimator
clear aoa PBartlett Pcapon
for j=1:length(az)
aoa=1;
for n=1:Nt-1
aoa=[aoa exp(n*1j*pi*sin(az(j)*pi/180))];
end
aoa=aoa.';
PBartlett(j)=aoa'*Rxx*aoa; %% Bartlett Pseudospectrum
Pcapon(j)=1/(aoa'*pinv(Rxx)*aoa); %% Capon Pseudospectrum
end
%%%Error calculation
[val id1]=max(PBartlett); %% AOA index for PBartlett
[val id2]=max(Pcapon); %% AOA index for Pcapon
E_Ba(m)=FThreshold(vpa(az(id1),5)-ang(m),0);  %% Bartlett Error
E_Ca(m)=FThreshold(vpa(az(id2),5)-ang(m),0);  %% Capon Error
%%% Neural Network AOA
E_Net(m)=FThreshold(net([real(A);imag(A)])-ang(m),0); %% NNet Error
end
MSE_Ba(t)=mean(E_Ba).^2; %% MSE Bartlett
MSE_Ca(t)=mean(E_Ca).^2; %% MSE Capon
MSE_Net(t)=mean(E_Net).^2; %% MSE NNet

end

%% MSE Neural Network AOA Plot
figure
semilogy(SNR,MSE_Ba),hold on
semilogy(SNR,MSE_Ca)
semilogy(SNR,MSE_Net)
xlabel('SNR (dB) ','fontsize',14,'fontweight','b');
ylabel('MSE  ','fontsize',14,'fontweight','b');
legend("Bartlett","Capon","NN trained with noise")
set(gca,...
    'Units','normalized',...
    'FontUnits','points',...
    'FontWeight','Bold',...
    'FontName','Times',...)
    'FontSize',16)
grid
%% Funtion FThreshold
function X=FThreshold(X,th)
for ii=1:length(X)
   if(X(ii))==th
      X(ii)=10e-9; 
   end        
end
end


