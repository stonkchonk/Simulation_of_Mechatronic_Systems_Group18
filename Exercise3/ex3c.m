clear; clf; clc; 

% initial parameters exercise 3c
par3.m1 = 100;          % mass 1 [kg]
par3.m2 = 10;           % mass 2 [kg]
par3.C1 = 15;           % spring value [N/m]
par3.C2 = 0;            % spring value [N/m]
par3.D2 = 0;            % damper value [N*s/m]
par3.t.start = 0;       % start simulation time [s]
par3.t.stop = 1000;     % stop simulation time [s]

% define upper bounds for damper and spring
maxDamperIdx = 15;
maxSpringIdx = 15;
areaUnderCurve = zeros(maxDamperIdx, maxSpringIdx); % area under squared curve matrix for different values
for damperConstIterator = 1:maxDamperIdx % iterating over damper value from 1 to 15
    for springConstIterator = 1:maxSpringIdx % iterating over spring value from 1 to 15
        damperConst = damperConstIterator / 10;
        springConst = springConstIterator / 10;
        fprintf('damper: %g N*s/m, spring: %g N/m\n', damperConst, springConst); % log current values
        par3.D2 = damperConst; % update damper value
        par3.C2 = springConst;  % update spring value
        out3c = sim('ex3c_simulink.slx'); % simulate the system
        % extract values from simulation
        time = out3c.x1x2.time; % simulation timeframe
        x1 = out3c.x1x2.signals(1).values; % x1 oscillation curve
        x2 = out3c.x1x2.signals(2).values; % x2 oscillation curve
        area = trapz(time, x1.^2); % area under x1 squared curve 
        areaUnderCurve(damperConstIterator, springConstIterator) = area;
    end
end

% plot for area under curve for different damper/spring constants
disp(areaUnderCurve);
figure(1);
surf(areaUnderCurve);
xlabel('D2 damper value [N*s/m]')
ylabel('C2 spring value [N/m]')
zlabel('Area under squared x1 curve')
title('Optimization graphic for different damper/spring constants')
colorbar;

[minVal, linIdx] = min(areaUnderCurve(:)); % extract minimum value
[row, col] = ind2sub(size(areaUnderCurve), linIdx); % optimized values
% run simulation again with otimized values for plotting purposes
fprintf('optimal row: %g, optimal col: %g\n', row, col);
optimalDamper = row*0.1;
optimalSpring = col*0.1;
fprintf('optimal damper: %g N*s/m, optimal spring: %g N/m\n', optimalDamper, optimalSpring);
par3.D2 = optimalDamper; % update damper value
par3.C2 = optimalSpring;  % update spring value
out3c = sim('ex3c_simulink.slx'); % simulate the system
time = out3c.x1x2.time; % simulation timeframe
x1 = out3c.x1x2.signals(1).values; % x1 oscillation curve
x2 = out3c.x1x2.signals(2).values; % x2 oscillation curve

% plot for movement with optimized damper/spring constants
figure(2);
plot(time, x1, time, x2);
xlabel('simulation duration [s]');
ylabel('mass oscillation [m]');
title('Two mass system with optimized spring/damper constants');
legend('x1 oscillation','x2 oscillation')
grid on;
