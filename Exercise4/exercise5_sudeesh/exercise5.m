 
L = 0.23e-3; %[H]
cm = 23.4e-3; %[Nm/A]
R = 2.4; %[Ohm]
J = 0.23e-6; %[Nm^2]
D = 0.4191e-5; %[N*sec/m]

load('exercise5csd.mat') 

out1=sim('exercise5s.slx');
figure;

plot(out1.ex5.time, out1.ex5.signals(1).values) % Signal 1
hold on
plot(out1.ex5.time, out1.ex5.signals(2).values) % Signal 2
legend('Signal 1','Signal 2')

grid on;

