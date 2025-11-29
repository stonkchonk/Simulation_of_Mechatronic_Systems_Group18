clear;clc;clf;
p = setparams();
t = [0, 10];
i = set_initial_vals();
[t1, y1]=ode23(@pendulum_spring_dgl, t, i, [], p);

plot(t1, y1(:, 1), t1, y1(:, 2));
disp(t1);
disp(y1);
xlabel('t [sec]');
ylabel('tbd');
legend('tbd')
grid on;

function [i] = set_initial_vals()
Lt = 0.7;
dLt = 0;
pt = 0.5;
dpt = 0.1;
i = [Lt, dLt, pt, dpt];  % Initialize the state vector
end

function [p] = setparams()
p.g = 9.81;  % gravitational acceleration [m/S^2]
p.m = 0.1;   % mass [kg]
p.C = 3.0;   % [N/m]
p.L0 = 0.5;  % [m]
end


%function [dz] = pendulum_spring_dgl(t, z, p)
%y1 = z(1);
%y2 = z(2);
%y3 = z(3);
%y4 = z(4);

%dy1 = y2;
%dy2 = (p.g*p.m*cos(y3) - p.C*y1 + p.C*p.L0 + p.m*y1*y4^2) / p.m;
%dy3 = y4;
%dy4 = -(p.g*sin(y3) + 2*y2*y4)/y1;

%dz = [dy1; dy2; dy3; dy4];
%end