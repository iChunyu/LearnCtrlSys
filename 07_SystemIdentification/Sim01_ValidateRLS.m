% Validate RLS method for online system identification
% Second-order plant for example
% RLS: recursive least-square

% XiaoCY 2023-10-10

%% Init
clear;clc
T1 = 1;
Ts = 1e-3;

% Plant
G = 3.5;
w0 = 2*pi*10;
zeta = 0.3;
x0 = 0;
v0 = 0;

s = tf('s');
P = G*w0^2 / (s^2 + 2*zeta*w0*s + w0^2);
Pd = c2d(P,Ts);
[b,a] = tfdata(Pd);
b = b{1};
a = a{1}(2:end);

%% RLS configuration
% Target: estimate discrete-time model
wn_std = 0.1;

N = 2;
M = 1;
lambda = 1;
P0 = 1e4;
Npara = M+N+1;
para0 = zeros(Npara,1);     % [a1; a2; ..., an; b0; b1; ... bm]


%% Simulation
tic
sim('mdl01_sysIdentify.slx')
toc

%% Results
figure
subplot(211)
plot(t,bhat)
hold on
yline(b)
xlabel('Time [s]')
ylabel('Numerator')

subplot(212)
plot(t,ahat)
hold on
yline(a)
xlabel('Time [s]')
ylabel('Denominator')

Phat = tf(b(end,:), [1 a(end,:)], Ts);
figure
bode(Phat, P, Pd)