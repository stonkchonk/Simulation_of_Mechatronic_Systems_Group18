clear; clf; clc;

xmax = pi;  

x = linspace(-xmax,xmax,100);   % Creation array of X value 

y.sin = sin(x);     % Calcolous of sin function
y.cos = cos(x);     % Calcolous of cos function
y.tan = tan(x);     % Calcolous of tan function
y.asin = asin(x);   % Calcolous of arcsin function
y.acos = acos(x);   % Calcolous of arccos function
y.atan = atan(x);   % Calcolous of arctan function


figure(1);                  % Creation of first figure (tab)
subplot(2,1,1)              % definition of the subplot (2 rows, 1 colums)
plot(x,y.sin,'b',x,y.cos,'c',x,y.tan,'r'); %plot of the function sin, cos, tan
hold on;                    % Maintains the previous graphs in the plot
yline(0);                   % Plot of the X axis
axis([-xmax xmax -2 2]);    % Settings of the value in the axes
grid;                       % Enable the grid in the plot
title("sin-cos-tan");       % Write the title of the plot
xlabel("x-value");          % Write the label of X axis
ylabel("y-value");          % Write the label of Y axis
legend("sin(x)","cos(x)","tan(x)",'Location','best'); % Add the legend of the graphs

subplot(2,1,2)
plot(x,y.asin,'b',x,y.acos,'c',x,y.atan,'r');    %plot of the function arcsin, arccos, arctan
hold on;                    % Maintains the previous graphs in the plot
yline(0);                   % Plot of the X axis
axis([-xmax xmax -2 2]);    % Settings of the value in the axes
grid;                       % Enable the grid in the plot
title("arc-function");      % Write the title of the plot
xlabel("x-value");          % Write the label of X axis
ylabel("y-value");          % Write the label of Y axis
legend("arcsin(x)","arccos(x)","arctan(x)",'location','best');  % Add the legend of the graphs
