function dy= spring_pendulum1(t,y,p)
L=y(1);
dL=y(2);
phi=y(3);
dphi=y(4);
m=p.m;
C=p.C;
g=p.g;
L0=p.L0;

ddL   = ( g*m*cos(phi) - C*L + C*L0 + m*L*dphi^2 ) / m;
ddphi = -( g*sin(phi) + 2*dL*dphi ) / L;

dy=[dL;ddL;dphi;ddphi];


end

clear; clc; close all;
p.m=0.1;
p.g=9.81;
p.C=3;
p.L0=0.5;

y0=[0.6;0;pi/3;0];
T=[0;10];


[t1,y1] = ode23(@(t,y) spring_pendulum1(t,y,p), T, y0);
[t2,y2] = ode45(@(t,y) spring_pendulum1(t,y,p), T, y0);
[t3,y3] = ode15s(@(t,y) spring_pendulum1(t,y,p), T, y0);

figure; hold on; grid on;
plot(t1,y1(:,1),'Linewidth',1.25);
plot(t1,y1(:,2),'Linewidth',1.25);
plot(t1,y1(:,3),'Linewidth',1.25);
plot(t1,y1(:,4),'Linewidth',1.25);
title('state_variables');
xlabel('t');
ylabel('y');
legend('L','dL','phi','dphi');

figure; hold on; grid on;
plot(t1,y1(:,1),'r-','LineWidth',1.5);
plot(t2,y2(:,1),'m--','LineWidth',1.5);
plot(t3,y3(:,1),'yo','LineWidth',1.5);
title('solvers');
legend('ode23','ode45','ode15s');
xlabel('t');
ylabel('L(t)');