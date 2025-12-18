clear; clf; clc; 
s = tf('s');
% PARAMETERS EXERCISE 1
par1.K = 5;             % Gain
par1.T = 4;             % Time constant
par1.u = 1;             % step value
par1.t.start = 0;       % start simulation time
par1.t.stop = 50;       % stop simulation time

% PARAMETERS EXERCISE 2
par2.m = 10;            % mass
par2.C = 100;           % Spring value
par2.D = 3;             % damper value
par2.F = 1;             % force applied
par2.t.start = 0;       % start simulation time
par2.t.stop = 50;       % stop simulation time

% PARAMETERS EXERCISE 3
par3.m1 = 100;          % mass 1
par3.m2 = 10;           % mass 1
par3.C1 = 15;           % Spring value
par3.C2 = 0;            % Spring value
par3.D2 = 0;            % damper value
par3.t.start = 0;       % start simulation time
par3.t.stop = 1000;       % stop simulation time





% EXERCISE A --------------------------------------------------------------
G1 = par1.K/(1+par1.T*s);     % transfer function

G1_de = @(t,x) 1/par1.T*(par1.K*par1.u - x);            % differential equation exercise 1

[t1,y1] = ode45(G1_de,[par1.t.start par1.t.stop],0);    % step response of differential equation

out1 = sim('exercise3_SIM');                             % simulate the system with simulink and get the scope datas

figure()
plot(out1.plotG1_Tf.time,out1.plotG1_Tf.signals(1).values,...       % Plot the result of the simulation in simulink (transfer function)
    out1.plotG1_Tf.time,out1.plotG1_Tf.signals(2).values)
grid on, xlabel('Time [sec]');legend('step','out'); title('step response transfer function SIMULINK');

figure()
plot(out1.plotG1_De.time,out1.plotG1_De.signals(1).values,...       % Plot the result of the simulation in simulink (differential equation)
    out1.plotG1_De.time,out1.plotG1_De.signals(2).values)
grid on, xlabel('Time [sec]');legend('step','out'); title('step response differential equation SIMULINK');

figure()
plot([par1.t.start par1.t.stop], [par1.u par1.u],t1,y1)             % plot the result of the ode45 step response of the differential equation
grid on, xlabel('Time [sec]');legend('step','out'); title('step response differential equation ODE45');



% EXERCISE B --------------------------------------------------------------
initialState1 = [0;0];                % set the initial state for the ode solver
[t2,y2] = ode45(@(t,z) massDgl(t,z,par2),[par2.t.start par2.t.stop],initialState1);    % ode solve of the differential equation exercise b


out2 = sim("exercise3_SIM.slx");      % step response with initial parameters
timeInitial = out2.plotE2.time;
stepResponseInitial = out2.plotE2.signals(2).values;

par2.m = 7;     % reduced mass m
out2 = sim("exercise3_SIM.slx");
timeReducedM = out2.plotE2.time;
stepResponseReducedM = out2.plotE2.signals(2).values;

par2.m = 13;    % increased mass m
out2 = sim("exercise3_SIM.slx");
timeIncreasedM = out2.plotE2.time;
stepResponseIncreasedM = out2.plotE2.signals(2).values;
par2.m = 10; % revert m to initial

par2.D = 2;    % reduced damper constant D
out2 = sim("exercise3_SIM.slx");
timeReducedD = out2.plotE2.time;
stepResponseReducedD = out2.plotE2.signals(2).values;

par2.D = 4;    % increased damper constant D
out2 = sim("exercise3_SIM.slx");
timeIncreasedD = out2.plotE2.time;
stepResponseIncreasedD = out2.plotE2.signals(2).values;
par2.D = 3; % revert D to initial

par2.C = 90;    % reduced spring constant C
out2 = sim("exercise3_SIM.slx");
timeReducedC = out2.plotE2.time;
stepResponseReducedC = out2.plotE2.signals(2).values;

par2.C = 110;    % increased spring constant C
out2 = sim("exercise3_SIM.slx");
timeIncreasedC = out2.plotE2.time;
stepResponseIncreasedC = out2.plotE2.signals(2).values;
par2.C = 100; % revert C to initial

% plot comparing different masses
figure(21);
plot(timeInitial, stepResponseInitial, ...
    timeReducedM, stepResponseReducedM, ...
    timeIncreasedM, stepResponseIncreasedM)
grid on, xlabel('Time [sec]'), ylabel('x [m]');
legend('10kg', '7kg', '13kg'); 
title('step response SIMULINK, physical property: m');

% plot comparing different damper constants
figure(22);
plot(timeInitial, stepResponseInitial, ...
    timeReducedD, stepResponseReducedD, ...
    timeIncreasedD, stepResponseIncreasedD)
grid on, xlabel('Time [sec]'), ylabel('x [m]');
legend('3Ns/m', '2Ns/m', '4Ns/m'); 
title('step response SIMULINK, physical property: D');

% plot comparing different spring constants
figure(23);
plot(timeInitial, stepResponseInitial, ...
    timeReducedC, stepResponseReducedC, ...
    timeIncreasedC, stepResponseIncreasedC)
grid on, xlabel('Time [sec]'), ylabel('x [m]');
legend('100N/m', '90N/m', '110N/m'); 
title('step response SIMULINK, physical property: C');


% differential equation exercise b
function [dz] = massDgl(t,z,par2)
    x = z(1);
    v = z(2);

    dv = 1/par2.m*(-par2.C*x - par2.D*v + par2.F);

    dx = v;

    dz = [dx;dv];
end




% EXERCISE C -----------------------------------------------------------
initialState2 = [0.1;0;0;0];        % set initial condition for ode solver

maxValuesC = [];                    % array that contains the max amplitude value of the simulations
par3.D2 = 0;                        
for i = 1:0.01:5                    % simulate the system with different C2 value
par3.C2 = i;                        % set the C2 value
    [t4,y4] = ode45(@(t,z) dualMassDgl(t,z,par3),[par3.t.start par3.t.stop],initialState2); % simulate the system with ODE45
    maxValuesC = [maxValuesC;i, max(y4(:,2))];      % save the max amplitude value of the simulation in the array
end

maxValuesD = [];
par3.C2 = 0;
for i = 1:0.01:5                    % simulate the system with different C2 value
    par3.D2 = i;                    % set the D2 value
    [t5,y5] = ode45(@(t,z) dualMassDgl(t,z,par3),[par3.t.start par3.t.stop],initialState2); % simulate the system with ODE45
    maxValuesD = [maxValuesD;i, max(y5(:,2))];      % save the max amplitude value of the simulation in the array
end

[bestC2Amplitude, bestC2Index]  = min(maxValuesC(:,2)); % get minimum amplitude value between the maximum value simulation array of C2
[bestD2Amplitude, bestD2Index] = min(maxValuesD(:,2));  % get minimum amplitude value between the maximum value simulation array of D2

par3.C2 = maxValuesC(bestC2Index,1);    % get the corresponding C2 value
par3.D2 = maxValuesD(bestD2Index,1);    % get the corresponding D2 value

[t3,y3] = ode45(@(t,z) dualMassDgl(t,z,par3),[par3.t.start par3.t.stop],initialState2); % simulate with the best C2 and D2 value

figure()
plot(maxValuesC(:,1),maxValuesC(:,2),maxValuesD(:,1),maxValuesD(:,2))       % plot the max amplitude value for each simulation
grid on, xlabel('Spring/Dumper value');legend('max amplitude C2','max amplitude D2'); title('Spring/Dumper coefficient variation');

figure()
plot(t3,y3(:,1),t3,y3(:,2),t3,y3(:,3),t3,y3(:,4))                           % plot the simulation results
grid on, xlabel('Time [sec]');legend('x1','v1','x2','v2'); title('two mass step response ODE45');

figure()
plot(t3,y3(:,1),t3,y3(:,3))                         % plot the simulation results
grid on, xlabel('Time [sec]');legend('m1 pos','m2 pos'); title('two mass oscillation');


% differential equation exercise c
function [dz] = dualMassDgl(t,z,par3)
    x1 = z(1);
    v1 = z(2);
    x2 = z(3);
    v2 = z(4);

    dv1 = 1/par3.m1*(-par3.C1*x1 + par3.C2*(x2-x1) + par3.D2*(v2-v1));
    dv2 = 1/par3.m2*(par3.C2*(x1-x2) + par3.D2*(v1-v2));

    dz = [v1;dv1;v2;dv2];
end
