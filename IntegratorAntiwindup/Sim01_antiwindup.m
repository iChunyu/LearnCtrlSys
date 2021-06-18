% Compare integrators with/without antiwindup loop

% Ref: Feedback Control of Dynamic Systems, p655.
% XiaoCY 2021-06-18

%% 
clear;clc

T = 10;
Ts = 1e-2;

stepAmp = [1, -1];
stepTime = 5;

intLim = 3;
Ka = 500;