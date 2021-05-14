% Bang Bang Control for 2nd Integrator
% Compare CT/DT controller

% XiaoCY 2020-05-14

%%
clear;clc
close all

%%
Ts = 1e-3;
T = 5;

x0 = 0;
v0 = 0;
umax = 1;

%%
dtFlag = 0;

sim('Sim01_BangBang')

figure(1)
plot(t,y)
grid on
legend('CT','DT')
xlabel('Time (s)')
ylabel('x (m)')

figure(2)
plot(t,u)
grid on
legend('CT','DT')
xlabel('Time (s)')
ylabel('u (m/s^2)')

