L = 0.23e-3; %[H]
cm = 23.4e-3; %[Nm/A]
R = 2.4; %[Ohm]
J = 0.23e-6; %[Nm^2]
D = 0.4191e-5; %[N*sec/m]

out1=sim('ex6modelr.slx');
figure;
title('Responses of sFunction Block')
subplot(2,1,1);
plot(out1.sx.time, out1.sx.signals(1).values) % Signal 1
xlabel('time s')
ylabel('current i(t)')
grid on;
hold on
subplot(2,1,2);
plot(out1.sx.time, out1.sx.signals(2).values) % Signal 2
xlabel('time s')
ylabel('angular speed $\omega(t)$','Interpreter','latex')
grid on;