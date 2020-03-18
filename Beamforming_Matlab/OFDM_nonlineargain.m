%% OFDM signal after PA non linear gain
%% Ilustration of the  OFDM, raised cosin (sincs aproximatelly) are created
%%% due to Windowing effects of the time Symbol Window
%%% FFT can be regarded as trunction of the signal equivalent to be multiplicated by a rectangular window 
%%%(for this reason we have a convolution in frequency with sinc or with the Fourier transform related to the window employed)
%%% Oppositely to the Fourier series that consider an infinity time resolution
Fs=1e6;  %%% Sampling rate
fshift=15e3:15e3:15e3*10; %%% OFDM fftshift
f=Fs/2*linspace(-1,1-1/Nfft,Nfft); %% frequency Vector
figure,
for ii=1:10
plot((sinc(10*pi*(f-fshift(ii))/max(f)))), hold on
end
%% OFDM Parameters
Deltaf=15e3;  %%% Deltaf
Order=16; %%% QAM order
scale=1/3; %%%
t=0:1/Deltaf:5*1/Deltaf; %%% Time samples
Nsymb=180; %%% 180 bins 
Nfft=256; %%% 128 bins = 1.5MHz BW  256 bins = 3 MHz BW  512 bins = 5 MHz BW 2048 bins =  20 MHz BW
f=Nfft*Deltaf*linspace(0,1-1/Nfft,Nfft); %% frequency Vector
offset=10; %%Offset
Guardband=Nfft-offset-Nsymb; %%Guardband
CP=16; %% 16 time samples
SNR=50; %% SNR dB
%% OFDM/QAM modulator
hMod = modem.qammod('M',Order,'PHASEOFFSET', 0, 'SYMBOLORDER', 'BINARY', ...
                                                    'INPUTTYPE', 'BIT');

bstream=randi([0 1],1,Nsymb*log2(Order)); %%% Bitstream
Bmod=s2p(bstream,log2(Order));   %%% Serial to Parallell
sig=modulate(hMod,Bmod)*scale;   %%% QAM Modulation
sig=[zeros([1 offset]) sig  zeros([1 Guardband])] %% OFDM signal Frequency domain
figure, %%% Plot frequency signal
plot(f/1e6,db((sig)))
xlabel("Frequency (MHz)")
ylabel("Amplitude V (dB)")
%% OFDM Signal w/ CP
% xh=[sig conj(sig(floor(Nfft/2)+2:-1:2))]; %%% Force Hermitian symmetry to obtain real signal without I/Q
xofdm=ifft(sig); %%% IFFT single sideband represantation - Frequency Domain without 0 Hz offset and guard band I/Q signal
% xofdm=[xofdm(Nfft-CP+1:Nfft) xofdm]; %%with CP
noisepwr=(xofdm*xofdm')/10^(SNR/10);
noise=sqrt(noisepwr)*randn([1 length(sig)]);
xofdm=xofdm+noise;
GL=10; %% Linear Gain
yofdm=GL*xofdm+20*xofdm.*abs(xofdm).^2+20*xofdm.*abs(xofdm).^4; %% Nonlinear gain - parallel Hammerstein Model 5th order
% M.; Isaksson, D. Wisell, and D. Ronnow, “A comparative analysis ofbehavioral models for RF power amplifiers,
% ”IEEE Trans. Microw. TheoryTech., vol. 54, no. 1, pp. 348–359, Jan. 2006

XF=fftshift(fft(xofdm,Nfft).^2/Nfft);  %%PSD xofdm
YF=fftshift(fft(yofdm,Nfft).^2/Nfft);  %%PSD xofdm after nonlinear gain 

figure,
plot(f/1e6,db(fftshift(XF))-max(db(fftshift(XF)))),hold on
plot(f/1e6,db(fftshift(YF))-max(db(fftshift(YF))))
legend("OFDM signal","Gain NL No DPD")
xlabel("Frequency (MHz)")
ylabel("PSD (dB)")






