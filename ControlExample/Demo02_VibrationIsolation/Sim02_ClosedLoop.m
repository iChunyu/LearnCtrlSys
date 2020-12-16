% Finish controller design and test the closed loop

% XiaoCY 2020-12-16

%%
clear;clc
close all


%% Plant
% Dynamic: 2nd order stiffness-damping-mass system
omega = 10*2*pi;
omg2 = omega^2;
xi = 2*omega*0.3;
v0 = 0;  x0 = 0;    % initial condition

% Normalized velocity sensor
Zs = [0 0];
Ps = [-5.89e-3*(1+1i)
    -5.89e-3*(1-1i)
    -180
    -160
    -80]*2*pi;
Hs0 = zpk(Zs,Ps,1);
Hs = Hs0/sigma(Hs0,1*2*pi);

%% Controller
% Phase compensator



% PID
Kp = 200;
Ki = 135;
Kd = 0;
N = 100;

% ADRC

%% Simulation
Ts = 1e-3;                      % sample time
T = 100;                         % total simulation time

% ainFlag: input flag for acceleration
%   0 --- none
%   1 --- step from 0 to 1e-6 at beginning
%   2 --- sine wave of 0.1 Hz with 1e-6 amplitude
%   3 --- white noise with 1e-6 PSD
ainFlag = 2;

% ctrlFlag: controller selection
%   0 --- open loop
%   1 --- phase compensator
%   2 --- PID
%   3 --- ADRC
ctrlType = ["Open Loop","Phase Compensator","PID","ADRC"];
for ctrlFlag = [0 2]
    sim('VibrationIsolation')
    
    figure(100)
    plot(t,x,'DisplayName',ctrlType(ctrlFlag+1))
    hold on
    grid on
    xlabel('Time (s)')
    ylabel('x (m)')
    
    figure(200)
    plot(t,v,'DisplayName',ctrlType(ctrlFlag+1))
    hold on
    grid on
    legend
    xlabel('Time (s)')
    ylabel('v (m/s)')
    
    figure(300)
    plot(t,a,'DisplayName',ctrlType(ctrlFlag+1))
    hold on
    grid on
    legend
    xlabel('Time (s)')
    ylabel('a (m/s^2)')
end