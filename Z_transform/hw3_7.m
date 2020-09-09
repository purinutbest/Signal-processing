%7.1
load handel; sound(y,Fs);
%7.2
alpha = 0.9; d = 5000;
a = 1; b = [1,zeros(1,d),alpha];
v = filter(b,a,y); sound(v,Fs);
%7.3
w = filter(a,b,v); sound(w,Fs);

subplot(3,1,1)
plot(y);
ylabel('y(k)');
xlabel('k');
title('Sound signal');
subplot(3,1,2)
plot(v);
ylabel('v(k)');
xlabel('k');
subplot(3,1,3)
plot(w);
ylabel('w(k)');
xlabel('k');