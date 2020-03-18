%% mws = cst.invoke('NewMWS'); New file
addpath('C:\GapWave') %%%CST directory
addpath(genpath('D:\Meus_Docs\Matlab routines')) %%CST API
exportpath='D:\Meus_Docs\Matlab routines\SpecCorr'

%% Open
cst = actxserver('CSTStudio.application');
mws1 = invoke(cst, 'OpenFile', 'ArrayProbeCorrection.cst'); 

%%
clear all
addpath(genpath('D:\Meus_Docs\Matlab routines')) %%CST API
Path="D:\Meus_Docs\Matlab routines\SpecCorr\Ffase\F";

for ii=1:242
clear A B
filename=Path+num2str(ii)+"_pwMag.txt";
A=importdata(filename);
filename2=Path+num2str(ii)+"_pwph.txt";
B=importdata(filename2);
V(:,ii)=A(:,2).*exp(1i*B(:,2)*pi/180);
end
f=A(:,1);
%%
ind=fiInd(f,28);
Ev=reshape(V(ind,1:2:end),[11 11]);
Eh=reshape(V(ind,2:2:end),[11 11]);

figure,
subplot 221
imagesc(db(Ev))
colorbar
subplot 222
imagesc(180/pi*angle(Ev))
colorbar
subplot 223
imagesc(db(Eh))
colorbar
subplot 224
imagesc(180/pi*angle(Eh))
colorbar