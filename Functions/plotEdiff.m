function plotEdiff(E2d0,E2df)
%%
figure
subplot 321
imagesc(E2d0.y,E2d0.x,100*abs(abs(E2df.Ex)-abs(E2d0.Ex))./abs(E2d0.Ex)), hold on
title('Ex Mag')
xlabel('Frequency (GHz)','fontsize',10,'fontweight','b');
ylabel('Ex (Mag)','fontsize',10,'fontweight','b');
colorbar
caxis([0 20])
% axis([-klim klim -klim klim])

subplot 322
imagesc(E2d0.x,E2d0.y,180/pi*angle(E2d0.Ex)), hold on
title("Ex Phase")
xlabel('Frequency (GHz)','fontsize',10,'fontweight','b');
ylabel('Ex (Deg)','fontsize',10,'fontweight','b');
colorbar
%caxis([0 max(max(abs(ESyF)))])
% axis([-klim klim -klim klim])

subplot 323
imagesc(E2d0.x,E2d0.y,100*abs(abs(E2df.Ey)-abs(E2d0.Ey))./abs(E2d0.Ey)), hold on
title('Ey Mag')
xlabel('Frequency (GHz)','fontsize',10,'fontweight','b');
ylabel('Ey (Mag)','fontsize',10,'fontweight','b');
colorbar
% axis([-klim klim -klim klim])

subplot 324
imagesc(E2d0.x,E2d0.y,180/pi*angle(E2d0.Ey)), hold on
title("Ey Phase")
xlabel('Frequency (GHz)','fontsize',10,'fontweight','b');
ylabel('Ey (Deg)','fontsize',10,'fontweight','b');
colorbar
% axis([-klim klim -klim klim])

subplot 325
imagesc(E2d0.x,E2d0.y,100*abs(abs(E2df.Ez)-abs(E2d0.Ez))./abs(E2d0.Ez)), hold on
title('Ez Mag')
xlabel('Frequency (GHz)','fontsize',10,'fontweight','b');
ylabel('Ez (Mag)','fontsize',10,'fontweight','b');
colorbar
% axis([-klim klim -klim klim])

subplot 326
imagesc(E2d0.x,E2d0.y,180/pi*angle(E2d0.Ez)), hold on
title("Ez Phase")
xlabel('Frequency (GHz)','fontsize',10,'fontweight','b');
ylabel('Ez (Deg)','fontsize',10,'fontweight','b');
colorbar
% axis([-klim klim -klim klim])

end