% Try to estimate external force using KF

% XiaoCY 2021-12-06

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

% ????? HOW TO SET Q ?????
Q = diag([0 0 Fn]);
R = 1e-3;

% CT extended state-space
Ac = [0 1 0; -k 0 1; 0 0 0];
Bc = [0 1 0]';
Cc = [1 0 0];

% DT state space
Ad = Ac*Ts+eye(3);
Bd = Bc*Ts;
Cd = Cc;
xk = [0.8 0 0];    % Predicted initial state

%%
sim('Model02_ParaEstimation.slx')

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
ylabel('Position (m)')
legend('$\hat{F}$','$F_{\rm in}$','interpreter','latex')