% Try to estimate external disturbance using KF
% Treat disturbance as extra states

% XiaoCY 2021-12-06
% XiaoCY 2022-10-21, using oscillator model for external disturbance

%% Initialization
clear;clc
close all

%% Set parameters
Ts = 1e-3;
T = 50;

k = 2;          % assume m = 1
x0 = 1;

F0 = 1;
Fn = 1e-3;

% Disturbance
dmax = 1;       % amplitude
domg = 1;       % angular velocity [rad/s]

% ????? HOW TO SET Q ?????
Q = diag([0 0 Fn 0]);
R = 1e-3;

% CT extended state-space
Ac = [0 1 0 0; -k 0 1 0; 0 0 0 1; 0 0 -domg^2 0];
Bc = [0 1 0 0]';
Cc = [1 0 0 0];

% DT state space
Ad = Ac*Ts+eye(4);
Bd = Bc*Ts;
Cd = Cc;
xk = [0.8 0 0 0];    % Predicted initial state

%%
sim('Model02_DisturbEst.slx')

figure
plot(t,xm)
hold on
grid on
plot(t,xhat(:,1))
xlabel('Time (s)')
ylabel('Position (m)')
legend('Measurement','Filtered')

figure
plot(t,xhat(:,3))
hold on
grid on
plot(t,Fin)
xlabel('Time (s)')
ylabel('Force (N)')
legend('$\hat{F}$','$F_{\rm in}$','interpreter','latex')
ylim([-2 2])