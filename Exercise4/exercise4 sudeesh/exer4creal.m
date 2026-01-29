clc; clear; close all;

% Parameters
L  = 0.23e-3;
cm = 23.4e-3;
R  = 2.4;
J  = 0.23e-6;
D  = 0.4191e-5;
Kp = 0.05;
omega_ref = 300;

% Closed-loop state equations
motor_cl = @(t,x) [
    (1/L)*(Kp*(omega_ref - x(2)) - R*x(1) - cm*x(2));
    (1/J)*(cm*x(1) - D*x(2))
];

x0 = [0 0];
tspan = [0 0.003];

% Solve using different solvers
[t45,x45]   = ode45(motor_cl, tspan, x0); % medium accuracy solver 
[t23,x23]   = ode23(motor_cl, tspan, x0); % low accuracy solver
[t15s,x15s] = ode15s(motor_cl, tspan, x0);  % stiff solver low to medium
[t23s, x23s] = ode23s(motor_cl, tspan, x0) % stiff solver for low
figure;

subplot(4,1,1)
plot(t45, x45(:,1),'LineWidth',1.5)
title('ode45 Current'), grid on

subplot(4,1,2)
plot(t23, x23(:,1),'LineWidth',1.5)
title('ode23 Current'), grid on

subplot(4,1,3)
plot(t15s, x15s(:,1),'LineWidth',1.5)
title('ode15s Current'), grid on

subplot(4, 1, 4)
plot(t23s, x23s(:,1),'LineWidth',1.5)
title('ode15s Current'), grid on

xlabel('Time [s]')
% Plot motor current comparison
figure;
plot(t45, x45(:,1),'LineWidth',1.5); hold on
plot(t23, x23(:,1),'--','LineWidth',1.5)
plot(t15s, x15s(:,1),':','LineWidth',1.5)
plot(t23s, x23s(:,1),':','LineWidth',1.5)

xlabel('Time [s]')
ylabel('Motor Current [A]')
title('Solver Comparison (Motor Current)')
legend('ode45','ode23','ode15s', 'ode23s')
grid on