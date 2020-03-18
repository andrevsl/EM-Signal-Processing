function plotSpectra1P(ES0,par,klim)
%% Spectral Response
%%% Circle

th = 0:pi/50:2*pi;r=1;
xunit = r * cos(th);
yunit = r * sin(th);
figure
subplot 321
imagesc(par.kx,par.ky,abs(ES0.Ex)), hold on
title('PWS Ex Mag')
xlabel('x-axis (mm)','fontsize',10,'fontweight','b');
ylabel('y-axis (mm)','fontsize',10,'fontweight','b');
plot(xunit, yunit,'--w'), hold off
colorbar
axis([-klim klim -klim klim])

subplot 322
imagesc(par.kx,par.ky,180/pi*angle(ES0.Ex)), hold on
title("PWS Ex Phase")
xlabel('x-axis (mm)','fontsize',10,'fontweight','b');
ylabel('y-axis (mm)','fontsize',10,'fontweight','b');
plot(xunit, yunit,'--w'), hold off
colorbar
%caxis([0 max(max(abs(ESyF)))])
axis([-klim klim -klim klim])

subplot 323
imagesc(par.kx,par.ky,abs(ES0.Ey)), hold on
title('PWS Ey Mag')
xlabel('x-axis (mm)','fontsize',10,'fontweight','b');
ylabel('y-axis (mm)','fontsize',10,'fontweight','b');
plot(xunit, yunit,'--w'), hold off
colorbar
axis([-klim klim -klim klim])

subplot 324
imagesc(par.kx,par.ky,180/pi*angle(ES0.Ey)), hold on
title("PWS Ey Phase")
xlabel('x-axis (mm)','fontsize',10,'fontweight','b');
ylabel('y-axis (mm)','fontsize',10,'fontweight','b');
plot(xunit, yunit,'--w'), hold off
colorbar
axis([-klim klim -klim klim])

subplot 325
imagesc(par.kx,par.ky,abs(ES0.Ez)), hold on
title('PWS Ez Mag')
xlabel('x-axis (mm)','fontsize',10,'fontweight','b');
ylabel('y-axis (mm)','fontsize',10,'fontweight','b');
plot(xunit, yunit,'--w'), hold off
colorbar
axis([-klim klim -klim klim])

subplot 326
imagesc(par.kx,par.ky,180/pi*angle(ES0.Ez)), hold on
title("PWS Ez Phase")
xlabel('x-axis (mm)','fontsize',10,'fontweight','b');
ylabel('y-axis (mm)','fontsize',10,'fontweight','b');
plot(xunit, yunit,'--w'), hold off
colorbar
axis([-klim klim -klim klim])

% figure
% imagesc(par.kx,par.ky,abs(par.Pg)), hold on
% plot(xunit, yunit,'--w'), hold off
% colorbar
% axis([-2 2 -2 2])

end