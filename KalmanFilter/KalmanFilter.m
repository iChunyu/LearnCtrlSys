% Build my Kalman filter and test it

% XiaoCY 2019-10-02

%% Initialization
set(0,'DefaultLineLineWidth',2)
set(0,'DefaultAxesFontSize',20)
set(0,'DefaultFigureWindowStyle','docked')
set(0,'DefaultFigureColor','w')

clear;clc
close all

%% Set parameters
Ts = 1e-3;

omg0 = 2*pi/1.5;
ksi = 0.5;
m = 1;

% CT state space
Ac = [0 1; -omg0^2 -ksi];
Bc = [ 0 1/m]';
Cc = [ 1 0];
IniS = [ 1 0];      % Initial state

Q = 1e-3;
R = 1e-3;

% DT state space
Ad = Ac*Ts+eye(2);
Bd = Bc*Ts;
Cd = Cc;
PredS = [0.8 0];    % Predicted initial state

%%
sim('KalmanFilterSim')
figure('Name','Result')
plot(t,xm)
hold on
grid on
plot(t,xp)
xlabel('Time (s)')
ylabel('Position (m)')
legend('Measurement','Filtered')