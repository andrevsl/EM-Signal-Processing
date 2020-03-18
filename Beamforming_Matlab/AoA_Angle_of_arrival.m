%%% Angle of arrival - EM simulator
%%% Plane wave incident in a 3-element array at azimuth=20 Degrees

%% Parameters
clear All
addpath('Support_function')
N=9; %% Number of elements
Freq=2.4; %% Frequency GHz
w=2*pi*Freq*1e9; %% Angular Frequency
Beta=w/3e8; %% Phase constant
F=cell([1 N]); %% Files Elements
ang=0:2*pi/40:pi; %% angle
d=3e8/(Freq*1e9)/2; %% Array element spacement Lamb/2
phi=-90:1:90; %% Phi Coordinate vector
%% Import Array Elements Voltage CST
%%% Frequency Index
clear R
for i=1:N
Path="VoltageEmSimulator\F"+num2str(i)+" (pw).txt";
F{i}=importdata(Path);
end
%%% Frequency Index
ind=fiInd(F{1}(:,1),Freq);

%%% Array Elements Voltage Matrix
for i=1:N
R(i)=F{i}(ind,2)+1i*F{i}(ind,3);
end
R=R.';
%% AOA  2D plane y=0
clear Rss Rxx aoa Pbarllet Pcapon 
Rss=1; %% Source Correlation
A=[R(8) R(5) R(2)].';
Rxx=A*Rss*A'; %% Array Correlation Matrix 
%% Barllet and Capon
for jj=1:length(phi)
aoa=1; %% Angle intialization
for n=1:3-1
aoa=[aoa exp(n*1j*Beta*d*sin(phi(jj)*pi/180))]; %% Angle of arrival vector
end
aoa=aoa.';
Pbarllet(jj)=aoa'*Rxx*aoa; %% Bartlett Pseudospectrum
Pcapon(jj)=1/(aoa'*inv(Rxx)*aoa); %% Capon Pseudospectrum
end


%% Plort Results
figure
plot(phi,20*log10(abs(Pbarllet)/max(abs(Pbarllet)))), hold on
plot(phi,20*log10(abs(Pcapon)/max(abs(Pcapon))))
xlabel('Azimuth (Degrees)','fontsize',14,'fontweight','b');
ylabel('Pseudo Spec(dB)','fontsize',14,'fontweight','b');
set(gca,'XTick',-90:15:90,'fontsize',8,'fontweight','b','FontName','Times');
set(gca,'YTick',-100:20:0,'fontsize',8,'fontweight','b','FontName','Times');
set(gca,...
    'Units','normalized',...
    'FontUnits','points',...
    'FontWeight','Bold',...
    'FontName','Times',...)
    'FontSize',16)
title("AOA Bartlett /Capon")
grid