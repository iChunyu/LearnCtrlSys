% Compare PI controllers with/without antiwindup loop

% Ref: Feedback Control of Dynamic Systems, p655.
% XiaoCY 2021-06-19

%% 
clear;clc

T = 4;
Ts = 1e-3;

stepAmp = [1, -1];
stepTime = 2;

intLim = 1;
Ka = [10 50 250];

%%
sim('mdl01_antiwindup')

figure
subplot(211)
plot(t,x,'DisplayName','Input')
grid on
legend('location','best')
ylabel('Input')

subplot(212)
plot(t,y0,'DisplayName','Integral')
hold on
grid on
plot(t,y1,'DisplayName','Integral Saturation')
plot(t,y2,'DisplayName','Integral Antiwindup')
legend('location','best')
xlabel('Time (s)')
ylabel('Output')

figure
subplot(211)
plot(t,y2,'DisplayName','Antiwindup with Logical Loop')
for k = 1:length(Ka)
    subplot(211)
    hold on
    grid on
    plot(t,y3(:,k),'DisplayName',sprintf('Antiwindup with Ka = %d',Ka(k)))
    legend('location','best')
    ylabel('Output')
    
    subplot(212)
    plot(t,y3(:,k)-y2,'DisplayName',sprintf('Ka = %d',Ka(k)))
    hold on
    grid on
    legend('location','best')
    xlabel('Time (s)')
    ylabel('Error')
end