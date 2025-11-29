function dy = pendulumDgl(t, y, p)

    % Extract states
    L     = y(1);   % Spring length [m]
    dL    = y(2);   % Spring length velocity [m/s]
    phi   = y(3);   % Angle from vertical [rad]
    dphi  = y(4);   % Angular velocity [rad/s]

    % Extract parameters
    m  = p.m;       % Mass [kg]
    C  = p.C;       % Spring constant [N/m]
    g  = p.g;       % Gravity [m/s^2]
    L0 = p.L0;      % Natural spring length [m]

    % Radial acceleration (spring + gravity + centripetal) [m/s^2]
    ddL = ( g*m*cos(phi) - C*L + C*L0 + m*L*dphi^2 ) / m;

    % Angular acceleration (gravity + Coriolis term) [rad/s^2]
    ddphi = -( g*sin(phi) + 2*dL*dphi ) / L;

    % Return derivative vector
    dy = [dL; ddL; dphi; ddphi];
end


% Main script
clear; clc; close all;

% Parameters
p.m  = 0.1;        % mass
p.g  = 9.81;       % gravity
p.C  = 3;          % spring constant
p.L0 = 0.5;        % natural spring length

% Initial conditions: [L; dL; phi; dphi]
y0 = [0.6; 0; pi/3; 0];

% Simulation time
T = [0; 25];

% Results for different solvers
[t1, y1] = ode23(@(t,y) pendulumDgl(t,y,p), T, y0);
[t2, y2] = ode45(@(t,y) pendulumDgl(t,y,p), T, y0);
[t3, y3] = ode15s(@(t,y) pendulumDgl(t,y,p), T, y0);
[t4, y4] = ode89(@(t,y) pendulumDgl(t,y,p), T, y0);

% Plot all state variables
figure; hold on; grid on;
plot(t1, y1(:,1), 'LineWidth', 1.25);  % L(t)
plot(t1, y1(:,2), 'LineWidth', 1.25);  % dL(t)
plot(t1, y1(:,3), 'LineWidth', 1.25);  % phi(t)
plot(t1, y1(:,4), 'LineWidth', 1.25);  % dphi(t)
title('State Variables');
xlabel('t'); ylabel('y');
legend('L','dL','\phi','d\phi');

% Compare solvers for L(t)
figure; hold on; grid on;
subplot(3, 1, 1)
plot(t2, y2(:,1), 'r-', 'LineWidth', 1.5);  % ode45 solution
hold on;
plot(t1, y1(:,1), 'b--',  'LineWidth', 1.5);  % ode23 solution
title('ode45 vs ode23');
xlabel('t'); ylabel('L(t)');
legend('ode45','ode23');

subplot(3, 1, 2)
plot(t2, y2(:,1), 'r-', 'LineWidth', 1.5);  % ode45 solution
hold on;
plot(t3, y3(:,1), 'k--',  'LineWidth', 1.5);  % ode15s solution
title('ode45 vs ode15s');
xlabel('t'); ylabel('L(t)');
legend('ode45','ode15s');

subplot(3, 1, 3)
plot(t2, y2(:,1), 'r-', 'LineWidth', 1.5);  % ode45 solution
hold on;
plot(t4, y4(:,1), 'g--',  'LineWidth', 1.5);  % ode89 solution
title('ode45 vs ode89');
xlabel('t'); ylabel('L(t)');
legend('ode45','ode89');