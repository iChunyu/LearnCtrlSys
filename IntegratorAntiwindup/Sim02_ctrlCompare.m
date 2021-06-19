% Compare integrators with/without antiwindup loop

% Ref: Feedback Control of Dynamic Systems, p655.
% XiaoCY 2021-06-18

%% 
clear;clc

T = 10;
Ts = 1e-3;

stepAmp = [0 1];
stepTime = 0;

intLim = 1;
Ka = 50;
Kp = 2;
Ki = 4;

%%
sim('mdl02_ctrlCompare')

figure
subplot(211)
plot(t,y1,t,y2)
grid on
legend('Saturation','Antiwindup')
ylabel('Output')

subplot(212)
plot(t,u1,t,u2)
grid on
legend('Saturation','Antiwindup')
xlabel('Time (s)')
ylabel('Control')