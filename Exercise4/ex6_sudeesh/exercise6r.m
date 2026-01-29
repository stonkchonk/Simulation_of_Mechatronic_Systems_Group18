L = 0.23e-3; %[H]
cm = 23.4e-3; %[Nm/A]
R = 2.4; %[Ohm]
J = 0.23e-6; %[Nm^2]
D = 0.4191e-5; %[N*sec/m]

out1=sim('ex6model.slx');
figure;

plot(out1.ex.time, out1.ex.signals(1).values) % Signal 1
hold on
plot(out1.ex.time, out1.ex.signals(2).values) % Signal 2
legend('Signal 1','Signal 2')

grid on;
