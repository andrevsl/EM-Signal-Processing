function plotEcut(E2d0,range)
%%
figure
subplot 321
imagesc(E2d0.y,E2d0.x,db(E2d0.Ex)), hold on
title('Ex Mag (dB)')
xlabel('x-axis','fontsize',10,'fontweight','b');
ylabel('y-axis','fontsize',10,'fontweight','b');
colorbar
cmax=max(max(db(E2d0.Ex)));
cmin=cmax-range;
caxis([cmin cmax]);

subplot 322
% imagesc(E2d0.y,E2d0.x,180/pi*GoldsteinUnwrap2D(E2d0.Ex)), hold on
imagesc(E2d0.y,E2d0.x,180/pi*angle(E2d0.Ex)), hold on
title("Ex Phase")
xlabel('x-axis','fontsize',10,'fontweight','b');
ylabel('y-axis','fontsize',10,'fontweight','b');
colorbar
%caxis([0 max(max(abs(ESyF)))])
% axis([-klim klim -klim klim])

subplot 323
imagesc(E2d0.y,E2d0.x,db(E2d0.Ey)), hold on
title('Ey Mag (dB)')
xlabel('x-axis','fontsize',10,'fontweight','b');
ylabel('y-axis','fontsize',10,'fontweight','b');
colorbar
% axis([-klim klim -klim klim])
cmax=max(max(db(E2d0.Ey)));
cmin=cmax-range;
caxis([cmin cmax])
subplot 324
% imagesc(E2d0.y,E2d0.x,180/pi*GoldsteinUnwrap2D(E2d0.Ey)), hold on
imagesc(E2d0.y,E2d0.x,180/pi*angle(E2d0.Ey)), hold on
title("Ey Phase")
xlabel('x-axis','fontsize',10,'fontweight','b');
ylabel('y-axis','fontsize',10,'fontweight','b');
colorbar
% axis([-klim klim -klim klim])

subplot 325
imagesc(E2d0.y,E2d0.x,db(E2d0.Ez)), hold on
title('Ez Mag (dB)')
xlabel('x-axis','fontsize',10,'fontweight','b');
ylabel('y-axis','fontsize',10,'fontweight','b');
colorbar
% axis([-klim klim -klim klim])
cmax=max(max(db(E2d0.Ez)));
cmin=cmax-range;
caxis([cmin cmax]);

subplot 326
imagesc(E2d0.y,E2d0.x,180/pi*angle(E2d0.Ez)), hold on
title("Ez Phase")
xlabel('x-axis','fontsize',10,'fontweight','b');
ylabel('y-axis','fontsize',10,'fontweight','b');
colorbar
% axis([-klim klim -klim klim])

end