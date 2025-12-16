% PARAMETERS EXERCISE 3
par3.m1 = 100;          % mass 1
par3.m2 = 10;           % mass 2
par3.C1 = 15;           % Spring value
par3.C2 = 1;            % Spring value
par3.D2 = 1;            % damper value
par3.t.start = 0;       % start simulation time
par3.t.stop = 1000;       % stop simulation time


out3c = sim('ex3c_simulink.slx');
time = out3c.x1x2.time;
x1 = out3c.x1x2.signals(1).values;
x2 = out3c.x1x2.signals(2).values;
out_squared = x1.^2;
area = trapz(time, out_squared);
disp('the calculated area: ');
disp(area);
plot(time, x1, time, x2, time, out_squared);
xlabel('time [sec]');
grid;