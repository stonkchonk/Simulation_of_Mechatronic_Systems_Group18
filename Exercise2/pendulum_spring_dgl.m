function [dz] = pendulum_spring_dgl(t, z, p)
y1 = z(1); % value for L(t) [m]
y2 = z(2); % value for L'(t) [m/s]
y3 = z(3); % value for phi(t) [rad]
y4 = z(4); % value for phi'(t) [rad/s]

% determine derivatives dyi of yi
dy1 = y2;
dy2 = (p.g*p.m*cos(y3) - p.C*y1 + p.C*p.L0 + p.m*y1*y4^2) / p.m;
dy3 = y4;
dy4 = -(p.g*sin(y3) + 2*y2*y4)/y1;

% pack derivatives into return vector
dz = [dy1; dy2; dy3; dy4];
end