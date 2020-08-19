% Bang Bang Control for 2nd Integrator

% XiaoCY 2020-08-19

%%
clear;clc
close all

%%
Ts = 1e-3;
T = 20;

x0 = 5;
v0 = 0;

umax = 1;

sim('Sim01_BangBang')

figure
plot(t,y)
grid on
xlabel('Time (s)')
ylabel('x (m)')

figure
plot(t,u)
grid on
xlabel('Time (s)')
ylabel('u (m/s^2)')