NoOfCarriers = 11; % Put an Odd Number
f = -5*pi:pi/50:5*pi;
fnoiseMax = 0;
iMin = -(NoOfCarriers-1)/2;
iMax = (NoOfCarriers-1)/2;
csum = zeros(1,length(f));


figure
fList = [];
cList = [];
subplot(2,1,1);
hold on;

for i=iMin:1:iMax

    fnoise = fnoiseMax*(rand()-0.5);
    fshift = (i* (1/pi)* pi) + fnoise;
    c = sinc(f - fshift);
    csum = csum + c;
    fList = [fList,fshift];
    cList = [cList,max(c)];
    plot(f,c);axis([min(f),max(f),-0.5,1.5]);
    stem((i * (1/pi) * pi) + fnoise,1,'r-');

end;

grid();

hold off;
subplot(2,1,2);
hold on;
plot(f,csum);grid();axis([min(f),max(f),-0.5,1.5]);
stem(fList,cList,'r-');
hold off;
 