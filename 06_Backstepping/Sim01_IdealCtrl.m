% Validate backsteping design with ideal control law
% (assume states are ideally known)

% XiaoCY 2022-07-23

%%
clear;clc

% nonlinear stiffness
a = 5;

% initial condition
x0 = -1;
v0 = 0;

% target position
xt = 1;

% target poles
p1 = -1;
p2 = -0.5;
K1 = (-(p1+p2)+sqrt((p1-p2)^2+4))/2;
K2 = (-(p1+p2)-sqrt((p1-p2)^2+4))/2;
G1 = 1+K1*K2;
G2 = K1+K2;

% check pole placement
% A = [-K1 1; -1 -K2];
% disp(eig(A))

% simulation configuration
Ts = 0.001;      % step time
T1 = 10;        % stop time

% use 3rd bang bang control to generate reference command
% (smooth referece position)
du = 0.1;

%%
tic
sim('mdl01_IdealCtrl.slx')
toc

%%
% in ideal case, no measurement/acuation error
% states must perfectly track the reference
figure
plot(t,x,'DisplayName','x')
hold on, grid on
plot(t,xr,'LineStyle','--','DisplayName','xr')
legend
xlabel('Time [s]')
ylabel('Displacement [m]')

figure
plot(t,v,'DisplayName','v')
hold on, grid on
plot(t,vr,'LineStyle','--','DisplayName','vr')
legend
xlabel('Time [s]')
ylabel('Velocity [m/s]')