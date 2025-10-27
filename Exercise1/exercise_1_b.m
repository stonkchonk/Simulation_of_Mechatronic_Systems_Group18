clear; clf; clc;

% segments point
A = [-1;1;1];
B = [-1;0;-1];
C = [1;1;0];
D = [1;-1;0.3];

figure()       %Creation of the second figure (tab)
[C1,C2,dist_min] = plotdistance(A,B,C,D,1)  % Call to the function


% function to get the minimum distance between two segment
function [C1,C2,dist_min] = plotdistance(A,B,C,D,plotVar)

    % 1. calc direction vector
    v1 = B - A;      
    v2 = D - C;      
    P1_P2_diff = A - C; 
    
    % 2. Calc of the scalar product
    a = dot(v1, v1); % a = ||v1||^2
    b = dot(v1, v2); % b = v1 . v2
    c = dot(v2, v2); % c = ||v2||^2
    d = dot(P1_P2_diff, v1);
    e = dot(P1_P2_diff, v2);
    
    % 3. Calc of determinats and the t and u parameters
    Delta = a * c - b * b;

    %chech if the segments are parallel
    if abs(Delta) < 1e-6 
        disp('The segments are parallel');
        return
    else
        % Resolution for t e u
        t0 = (b * e - c * d) / Delta; % bc - de
        u0 = (a * e - b * d) / Delta; % ae - bd
        
        % point C1 and C2
        C1 = A + t0 * v1;
        C2 = C + u0 * v2;
        
        % minimun distance
        dist_min = norm(C1 - C2);
    end

    % if the plot variable is HIGH print plot the results
    if plotVar == 1         % HIGH ==> plot on
        hold on;
        grid on;
        % Plot point A,B,C,D
        plot3(A(1),A(2),A(3),'o',B(1),B(2),B(3),'o',C(1),C(2),C(3),'o',D(1),D(2),D(3),'o')
        % Plot segment AB and BC
        plot3([A(1),B(1)],[A(2),B(2)],[A(3),B(3)],'b');
        plot3([C(1),D(1)],[C(2),D(2)],[C(3),D(3)],'g');
        % plot C1 and C2 position
        plot3(C1(1),C1(2),C1(3),'x');
        plot3(C2(1),C2(2),C2(3),'x');
        % plot minimum lenght segment
        plot3([C1(1),C2(1)],[C1(2),C2(2)],[C1(3),C2(3)],'r');
        % NAme of the axes
        xlabel('X-axis');
        ylabel('Y-axis');
        zlabel('Z-axis');
        % Possibility to set the view position
        %view([-39.69 35.28]) 
    end
end
