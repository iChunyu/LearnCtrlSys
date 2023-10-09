% MPC example

% XiaoCY 2021-10-28

%%
clear;clc
close all

%%
Ts = 0.01;
T = 10;

A = [1 Ts; 0 1];
B = [0; Ts];

Q = diag([300 10]);
R = 0.1;
F = Q;
N = 5;

x0 = [3; 0];

%%
tic
sim('SimpleMPC')
toc

%%
figure
yyaxis left
plot(t,x(:,1))
xlabel('Time (s)')
ylabel('x (m)')
grid on
yyaxis right
plot(t,x(:,2))
ylabel('v (m/s)')

figure
plot(t,u)
grid on
xlabel('Time (s)')
ylabel('a (m/s^2)')