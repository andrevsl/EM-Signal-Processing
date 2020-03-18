function DephaSpec2P(ES0,ESF,par,klim,Ca,Pa)
%% Spectral Response
%%% Circle

th = 0:pi/50:2*pi;r=1;
xunit = r * cos(th);
yunit = r * sin(th);
figure
subplot 321
imagesc(par.kx,par.ky,abs(ESF.Ex./ES0.Ex)), hold on
title('PWS Ex Mag')
xlabel('x-axis (mm)','fontsize',10,'fontweight','b');
ylabel('y-axis (mm)','fontsize',10,'fontweight','b');
plot(xunit, yunit,'--w'), hold off
colorbar
axis([-klim klim -klim klim])
caxis([0 3])
if nargin>=5
caxis(Ca)
end

subplot 322
imagesc(par.kx,par.ky,180/pi*angle(ESF.Ex./ES0.Ex)), hold on
title("PWS Ex Phase")
xlabel('x-axis (mm)','fontsize',10,'fontweight','b');
ylabel('y-axis (mm)','fontsize',10,'fontweight','b');
plot(xunit, yunit,'--w'), hold off
colorbar
if nargin>=6
caxis(Pa)
end
axis([-klim klim -klim klim])

subplot 323
imagesc(par.kx,par.ky,abs(ESF.Ey./ES0.Ey)), hold on
title('PWS Ey Mag')
xlabel('x-axis (mm)','fontsize',10,'fontweight','b');
ylabel('y-axis (mm)','fontsize',10,'fontweight','b');
plot(xunit, yunit,'--w'), hold off
colorbar
axis([-klim klim -klim klim])
caxis([0 1])
if nargin>=5
caxis(Ca)
end


subplot 324
imagesc(par.kx,par.ky,180/pi*angle(ESF.Ey./ES0.Ey)), hold on
title("PWS Ey Phase")
xlabel('x-axis (mm)','fontsize',10,'fontweight','b');
ylabel('y-axis (mm)','fontsize',10,'fontweight','b');
plot(xunit, yunit,'--w'), hold off
colorbar
if nargin>=6
caxis(Pa)
end
axis([-klim klim -klim klim])

subplot 325
imagesc(par.kx,par.ky,abs(ESF.Ez./ES0.Ez)), hold on
title('PWS Ez Mag')
xlabel('x-axis (mm)','fontsize',10,'fontweight','b');
ylabel('y-axis (mm)','fontsize',10,'fontweight','b');
plot(xunit, yunit,'--w'), hold off
colorbar
axis([-klim klim -klim klim])
caxis([0 3])
if nargin>=5
caxis(Ca)     
end

subplot 326
imagesc(par.kx,par.ky,180/pi*angle(ESF.Ez./ES0.Ez)), hold on
title("PWS Ez Phase")
xlabel('x-axis (mm)','fontsize',10,'fontweight','b');
ylabel('y-axis (mm)','fontsize',10,'fontweight','b');
plot(xunit, yunit,'--w'), hold off
colorbar
axis([-klim klim -klim klim])
if nargin>=6
caxis(Pa)
end
% figure
% imagesc(par.kx,par.ky,abs(par.Pg)), hold on
% plot(xunit, yunit,'--w'), hold off
% colorbar
% axis([-2 2 -2 2])

end