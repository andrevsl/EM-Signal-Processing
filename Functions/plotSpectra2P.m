function plotSpectra2P(ES0,ESF,par,klim)
%% Spectral Response
%%% Circle

th = 0:pi/50:2*pi;r=1;
xunit = r * cos(th);
yunit = r * sin(th);
figure
subplot 321
imagesc(par.kx,par.ky,100*abs(abs(ESF.Ex)-abs(ES0.Ex))./abs(ES0.Ex)), hold on
title('PWS Ex Mag')
xlabel('Frequency (GHz)','fontsize',10,'fontweight','b');
ylabel('PWS Ex (Mag)','fontsize',10,'fontweight','b');
plot(xunit, yunit,'--w'), hold off
colorbar
axis([-klim klim -klim klim])
caxis([0 20])
subplot 322
imagesc(par.kx,par.ky,180/pi*angle(ESF.Ex./ES0.Ex)), hold on
title("PWS Ex Phase")
xlabel('Frequency (GHz)','fontsize',10,'fontweight','b');
ylabel('PWS Ex (Deg)','fontsize',10,'fontweight','b');
plot(xunit, yunit,'--w'), hold off
colorbar
%caxis([0 max(max(abs(ESyF)))])
axis([-klim klim -klim klim])

subplot 323
imagesc(par.kx,par.ky,100*abs(abs(ESF.Ey)-abs(ES0.Ey))./abs(ES0.Ey)), hold on
title('PWS Ey Mag')
xlabel('Frequency (GHz)','fontsize',10,'fontweight','b');
ylabel('PWS Ey (Mag)','fontsize',10,'fontweight','b');
plot(xunit, yunit,'--w'), hold off
colorbar
axis([-klim klim -klim klim])
caxis([0 20])

subplot 324
imagesc(par.kx,par.ky,180/pi*angle(ESF.Ey./ES0.Ey)), hold on
title("PWS Ey Phase")
xlabel('Frequency (GHz)','fontsize',10,'fontweight','b');
ylabel('PWS Ey (Deg)','fontsize',10,'fontweight','b');
plot(xunit, yunit,'--w'), hold off
colorbar
axis([-klim klim -klim klim])

subplot 325
imagesc(par.kx,par.ky,100*abs(abs(ESF.Ez)-abs(ES0.Ez))./abs(ES0.Ez)), hold on
title('PWS Ez Mag')
xlabel('Frequency (GHz)','fontsize',10,'fontweight','b');
ylabel('PWS Ez (Mag)','fontsize',10,'fontweight','b');
plot(xunit, yunit,'--w'), hold off
colorbar
axis([-klim klim -klim klim])
caxis([0 20])

subplot 326
imagesc(par.kx,par.ky,180/pi*angle(ESF.Ez./ES0.Ez)), hold on
title("PWS Ez Phase")
xlabel('Frequency (GHz)','fontsize',10,'fontweight','b');
ylabel('PWS Ez (Deg)','fontsize',10,'fontweight','b');
plot(xunit, yunit,'--w'), hold off
colorbar
axis([-klim klim -klim klim])

% figure
% imagesc(par.kx,par.ky,abs(par.Pg)), hold on
% plot(xunit, yunit,'--w'), hold off
% colorbar
% axis([-2 2 -2 2])

end