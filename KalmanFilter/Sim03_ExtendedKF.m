% Try Extended Kalman Filter (EKF)
% Demo: single pendulum
%   EQ: x'' + g/L*sin(x) = 0

% XiaoCY 2021-12-08

%%
clear;clc
close all

g = 9.8;
L = 1.75;

Ts = 1e-2;

% DT state equations are embedded in the mod
% x(k+1) f(x(k),u(k))
f = @(x,u) [x(1) + Ts*x(2); -g/L*sin(x(1))*Ts + x(2) + u*Ts];

% DT linearization
A = @(x) [1 Ts; -g/L*Ts*cos(x(1)) 1];
B = [0 1]';
C = [1 0];

R = 1e-2;
Q = diag([0 1e-2]);

x0 = [1 0]';
xk0 = [0 0]';

%%
sim('Model03_TestEKF.slx')

figure
plot(t,xm,'DisplayName','Measurement')
hold on
grid on
plot(t,xhat,'DisplayName','Estimation')
plot(t,x,'DisplayName','True Value')
xlabel('Time (s)')
ylabel('Angle (rad)')