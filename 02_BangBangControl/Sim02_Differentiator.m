% Tracking Differentiator using Bang Bang Control

% XiaoCY 2020-08-19

%%
clear;clc
close all

%%
Ts = 1e-5;
T = 10;

A = 1;
omg = 1;
xn = 0.1;

umax = 20;

%%
xnFlag = 0;
sim('Sim02_TrackingDiff')

figure
plot(t,x)
hold on
grid on
plot(t,y)
plot(t,y0,'--')
xlabel('Time (s)')
legend('x','dx','real-dx')

%%
xnFlag = 1;
sim('Sim02_TrackingDiff')

figure
plot(t,x)
hold on
grid on
plot(t,y)
plot(t,y0,'--')
xlabel('Time (s)')
legend('x','dx','real-dx')