% Build and simulate plant without control
% Assumptions:
%     1. dynamic as a stiffness-damping-mass system;
%     2. band-pass velocity sensor;
%     3. actuator as unit gain.

% XiaoCY 2020-12-16

%%
clear;clc
close all

bodeopts = bodeoptions;
bodeopts.FreqUnits = 'Hz';
bodeopts.PhaseVisible = 'off';
bodeopts.Grid = 'on';
bodeopts.XLabel.FontSize = 20;
bodeopts.YLabel.FontSize = 20;
bodeopts.XLabel.FontWeight = 'bold';
bodeopts.YLabel.FontWeight = 'bold';
bodeopts.TickLabel.FontSize = 18;
bodeopts.Title.String = [];

%% Plant
%                  s
% P(s) = ----------------------
%         s^2 + xi*s + omega^2
% Dynamic: 2nd order stiffness-damping-mass system
omega = 10*2*pi;
omg2 = omega^2;
xi = 2*omega*0.3;
v0 = 0;  x0 = 0;    % initial condition
P = tf([1 0],[1 xi omg2]);

% Normalized velocity sensor
Zs = [0 0];
Ps = [-5.89e-3*(1+1i)
    -5.89e-3*(1-1i)
    -180
    -160
    -80]*2*pi;
Hs0 = zpk(Zs,Ps,1);
Hs = Hs0/sigma(Hs0,1*2*pi);

figure('Name','Plant')
bodeplot(P,Hs,bodeopts)

%% Simulation
Ts = 1e-3;                      % sample time
T = 1;                          % total simulation time

% ainFlag: input flag for acceleration
%   0 --- none
%   1 --- step from 0 to 1e-6 at beginning
%   2 --- sine wave of 0.1 Hz with 1e-6 amplitude
%   3 --- white noise with 1e-6 PSD
ainFlag = 1;            

% ctrlFlag: controller selection
%   0 --- open loop
%   1 --- phase compensator
%   2 --- PID
%   3 --- ADRC
ctrlFlag = 0;

sim('VibrationIsolation')

figure('Name','Step')
subplot(3,1,1)
plot(t,x)
grid on
xlabel('Time (s)')
ylabel('x (m)')

subplot(3,1,2)
plot(t,v)
hold on
grid on
plot(t,vm,'--')
legend('v','measure')
xlabel('Time (s)')
ylabel('v (m/s)')

subplot(3,1,3)
plot(t,ain)
hold on
grid on
plot(t,a,'--')
legend('ain','aout')
xlabel('Time (s)')
ylabel('a (m/s^2)')