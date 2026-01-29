clc; clear; clf; 
L = 0.23e-3; %[H]
cm = 23.4e-3; %[Nm/A]
R = 2.4; %[Ohm]
J = 0.23e-6; %[Nm^2]
D = 0.4191e-5; %[N*sec/m]
s = tf('s');
G = cm / ((L*s+R)*(J*s+D) + cm^2);

rlocus(G) % choose gain from plot
grid on; 
Kp = 0.05; % speed controller gain factor

T = feedback(Kp*G,1);
step(T)
title('Closed-loop Speed')
out1=sim('exercise4reabb.slx');
figure;
subplot(2,1,1);
plot(out1.ex.time,out1.ex.signals(1).values);% plotting values for angular speed
xlabel('time');
ylabel('angular speed $\omega(t)$','Interpreter','latex');
grid on;
subplot(2,1,2);
plot(out1.wx.time,out1.wx.signals(1).values);% plotting values for current
ylabel('current i(t)');
xlabel('time');
grid on;
