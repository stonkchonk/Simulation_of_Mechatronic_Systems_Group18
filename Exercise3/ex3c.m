% PARAMETERS EXERCISE 3
par3.m1 = 100;          % mass 1
par3.m2 = 10;           % mass 2
par3.C1 = 15;           % Spring value
par3.C2 = 2;            % Spring value
par3.D2 = 5;            % damper value
par3.t.start = 0;       % start simulation time
par3.t.stop = 1000;       % stop simulation time


out3c = sim('ex3c_simulink.slx');

plot(out3c.getElement('x1').Values);
xlabel('time [sec]');
grid;