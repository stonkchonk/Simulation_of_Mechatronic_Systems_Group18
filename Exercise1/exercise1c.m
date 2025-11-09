clc;clf;
K1=3;
T_val=[1,2,5,10,15,20,40,50];
figure('Name','Pt1_values');
for i= 1:length(T_val)
    T1= T_val(i);
G1= tf(K1,[T1 1]);  
figure(1);
bode(G1);
hold on
figure(2);
step(G1);
hold on
end
figure(1);
title('bode1 plot');
legend('b1values');
figure(2);
title('step response1');
legend('s1values');
xlabel('time');
ylabel('Amplitude');

K2=5;
T2=0.4;
d_val=[0.1,0.3,0.5,0.8,1.0,1.5,2.0];
figure('Name','pt2_values');
for i=1:length(d_val)
    d=d_val(i);
G2=tf(K2,[T2^2 2*T2*d 1]);
figure(3);
hold on;
bode(G2);
grid on;
title('bode2');
legend('b2values');
figure(4);
step(G2);
hold on;
grid on;
title('step response 2');
legend('s2values');
xlabel('time');
ylabel('amplitude');
end
