clear, clf, clc;

p = setPar();       % set parameters
t.start = 0;        % start time
t.end = 10;         % end time


p.L0 = 0.5; p.v0 = 0; p.fi0 = 0; p.dfi0 = 0; initialState = [p.L0;p.v0;p.fi0;p.dfi0]; disp("Sim 1: "); disp(p); % set new parameters
[t1,y1] = ode45(@pendulumDgl,[t.start t.end],initialState,[],p);    % Simulation with ode45

p.L0 = 0.5; p.v0 = 2; p.fi0 = 0; p.dfi0 = 0; initialState = [p.L0;p.v0;p.fi0;p.dfi0]; disp("Sim 2: "); disp(p);
[t2,y2] = ode45(@pendulumDgl,[t.start t.end],initialState,[],p);

p.L0 = 0.1; p.v0 = 0; p.fi0 = pi/4; p.dfi0 = 0; initialState = [p.L0;p.v0;p.fi0;p.dfi0]; disp("Sim 3: "); disp(p);
[t3,y3] = ode45(@pendulumDgl,[t.start t.end],initialState,[],p);

p.L0 = 0.5; p.v0 = 1; p.fi0 = pi/4; p.dfi0 = pi/4; initialState = [p.L0;p.v0;p.fi0;p.dfi0]; disp("Sim 4: "); disp(p);
[t4,y4] = ode45(@pendulumDgl,[t.start t.end],initialState,[],p);


% plot of the simulations
figure(1)
subplot(2,2,1)
plot(t1,y1(:,1),t2,y2(:,1),t3,y3(:,1),t4,y4(:,1))
title("position x"); xlabel("t [s]"); legend("sim_1","sim_2","sim_3","sim_4")
penduluPath(y1);

figure(1)
subplot(2,2,2)
plot(t1,y1(:,2),t2,y2(:,2),t3,y3(:,2),t4,y4(:,2))
title("velocity v"); xlabel("t [s]"); legend("sim_1","sim_2","sim_3","sim_4")
penduluPath(y2);

figure(1)
subplot(2,2,3)
plot(t1,y1(:,3),t2,y2(:,3),t3,y3(:,3),t4,y4(:,3))
title("angular position φ"); xlabel("t [s]"); legend("sim_1","sim_2","sim_3","sim_4")
penduluPath(y3);

figure(1)
subplot(2,2,4)
plot(t1,y1(:,4),t2,y2(:,4),t3,y3(:,4),t4,y4(:,4))
title("position dφ"); xlabel("t [s]"); legend("sim_1","sim_2","sim_3","sim_4")
penduluPath(y4);



% PARAMETER FUNCTION
function [p] = setPar()
    p.m = 0.1;      % mass [m]
    p.C = 3;        % string [N/m]
    p.g = 9.81;     % gravity force [m/s^2]
    
    p.L0 = 0.5;     % initial position [m]      
        % This value can not be equal to zero because in create a singularity in the differential equation calcolous num/0
        % For the 0 position set a really low value (ex. 1e-10)
    p.v0 = 0;       % initial velocity [m/s]
    p.fi0 = pi/4;   % initial angle [rad]
    p.dfi0 = 0;     % initial angular velocity [rad/s]

end

% DIFFERENTIAL EQUATION OF PENDULUM
function [dz] = pendulumDgl(t,L,p)
    % Assegnazione corretta delle variabili di stato
    x = L(1);       % L(t):  position L [m]
    v = L(2);       % L̇(t):  velocity dL/dt [m/s]
    a = L(3);       % φ(t):  angular position fi [rad]
    av = L(4);      % φ̇(t):  angular velocity dfi/dt [rad/s]

    % Rappresentation of the differential equations
    dv = (1/p.m) * (p.g * p.m * cos(a) - p.C * x + p.C * p.L0 + p.m * x * av^2);
    dav = -((p.g * sin(a) + 2 * v * av) / x);

    dx = v;    
    da = av;   
    
    % output vector dz = [v; dv; av; dav]
    dz = [dx; dv; da; dav];
    
end

% FUNCTION TO RAPPRESENT THE PENDULUM PATH
function penduluPath(y_system)
    y = y_system(:,1);          % Get y position of mass
    fi = y_system(:,3);         % Get angluar position
    x = y.*sin(fi);             % calculate x position


    figure()                    % Create new figure
    clf;                        % Clear the figure (not necessary, but to be sure)
    hold on; grid on;           % activate holding and grid
    hTrace = animatedline('Color', 'b', 'LineWidth', 1);    % Create an object to rappresent the path
    hPendulum = plot([0, x(1)], [0, -y(1)], 'r-o', 'LineWidth', 2, 'MarkerFaceColor', 'r'); % Create an object to rappresent the pendulum
    axis([-1 1 -1.5 0]);         % set axis dimension
    title("Pendulum path"); xlabel("x [m]"); ylabel("y [m]");

    for i = 1:length(x)         
        
        set(hPendulum, 'XData', [0, x(i)], 'YData', [0, -y(i)]);     % Draw the pendulum
        addpoints(hTrace, x(i), -y(i))                               % plot the point position of the mass
        
        drawnow limitrate;      % command for animation
        pause(0.01)             % pause for the visualizzation
    end
end