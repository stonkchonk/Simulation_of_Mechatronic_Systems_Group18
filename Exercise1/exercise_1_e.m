clear; clf; clc;

s = tf('s');
% Parameters
k = 3;
Tt = 0.0;
T = 0.4;
d = 0.5
w = linspace(0.001,100,100000); % Freq values
% Transfer function
G = k/(1+2*T*d*s+(T^2)*(s^2))*exp(-Tt*s);
num = cell2mat(G.Numerator);
den = cell2mat(G.Denominator);

% Call to function
[mag, phase]=mybode3(num,den,Tt,w);

% Plot of the results
figure(1)
subplot(2,1,1);
semilogx(w,mag);
title("Mag");
grid on;
xlim([w(1) w(length(w))]);
ylim([min(mag)-5 max(mag)+5]);
xlabel("Frequency [rad/s]");
ylabel("MAgnitude [dB]");

subplot(2,1,2);
semilogx(w,phase)
title("phase");
grid on;
xlim([w(1) w(length(w))]);
ylim([min(phase)-10 max(phase)+10]);
xlabel("Frequency [rad/s]");
ylabel("Phase [deg]");

figure(2)
bode(G)
grid on;


% Function that get the magnitude and the phase of the G transfer function
% INPUT:
% G = num_coeff/den_coeff:   the numerator and denominator are provided as vectors
% Tt: delay of the transfer function G(s)*exp(-Tt*s)
% w: array of frequency value
% OUTPUT:
% mag_db: array of the magnitude of the transfer function for the frequency
%         values in [dB]
% phase_deg: array of the phase of the transfer function for the frequency
%            values in [deg]
function [mag_db, phase_deg] = mybode3(num_coeff, den_coeff, Tt, w)

    jw = 1i * w;    % s array, s = jw for each frequency

    Num_jw = polyval(num_coeff, jw);    % Calc numerator for each Frequency
    Den_jw = polyval(den_coeff, jw);    % Calc denominator for each Frequency

    G_jw = (Num_jw ./ Den_jw);          % Calc of G for each frequency

 
    mag_lin = abs(G_jw);                % Calc of magnitude
    mag_db = 20*log10(mag_lin);         % Conversioni magnitude in [dB]
    
    phase_rad = angle(G_jw)-w*Tt;       % Calc Phase
    phase_deg = phase_rad * (180 / pi); % Convesione Phase in degree
end
