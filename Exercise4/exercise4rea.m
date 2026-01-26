clc; clear; clf; 
L = 0.23e-3; %[H]
cm = 23.4e-3; %[Nm/A]
R = 2.4; %[Ohm]
J = 0.23e-6; %[Nm^2]
D = 0.4191e-5; %[N*sec/m]
out1=sim('exer4areala.slx');
figure;
subplot(2,1,1);
plot(out1.cx.time,out1.cx.signals(1).values);% plot the graph in matlab using the values from simulink
xlabel('time');
ylabel('speed (t)');
grid on;
subplot(2,1,2);
plot(out1.vx.time,out1.vx.signals(1).values);
ylabel('current i(t)');
xlabel('time');
grid on;
