clear; clf; clc;

s = tf('s');    % Definition of the s variable

% Paramenters
kg1 = 3;
Tg1 = 10;

kg2 = 5;
Tg2 = 0.4;
dg2 = 0.5;



leg_array = [];         % Array definition for the legend

for i = 1:8             % Cicle to plot the graph with different T value
    Ti = Tg1-9+3*i;     % Modify the T value
    G1 = kg1/(1+Ti*s);  % Definition of the Transfer function with the new parameters

    figure(1);          
    bode(G1);           % Plot in Figure(1) the bode diagram
    hold on;            % Maintains the previous graphs in the plot

    figure(2);
    step(G1);           % Plot in Figure(2) the step response diagram
    hold on             % Maintains the previous graphs in the plot

    leg_array = [leg_array;"k="+kg1+" T="+Ti];  % Add to the legend array the new graph parameters
end

% Display title and legend for figure (1) and (2)
figure(1)
title("bode plot G1")
legend(leg_array,'location','southeast')
grid on;
figure(2)
title("step response G1");
legend(leg_array,'location','southeast')
grid on;



leg_array = []; % Array definition for the legend

for i = 1:8         % Cicle to plot the graph with different T value
    Ti = Tg2*i;     % Modify the T value
G2 = kg2/(1+2*Ti*dg2*s+(Ti^2)*(s^2));   % Definition of the Transfer function with the new parameters
    
    figure(3);
    bode(G2);       % Plot in Figure(3) the bode diagram
    hold on;        % Maintains the previous graphs in the plot

    figure(4);
    step(G2);       % Plot in Figure(4) the step response diagram
    hold on         % Maintains the previous graphs in the plot

    leg_array = [leg_array;"k="+kg2+" T="+Ti];  % Add to the legend array the new graph parameters
end

% Display title and legend for figure (3) and (4)
figure(3)
title("bode plot G2")
legend(leg_array,'location','southeast')
grid on;
figure(4)
title("step response G2");
legend(leg_array,'location','southeast')
grid on;
