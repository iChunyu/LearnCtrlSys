% Scan DT Tracking Differentiator Frequency Response

% XiaoCY 2020-08-19

%%
clear;clc
close all

%%
xn = 0.1;
xnFlag = 0;

A = 1;

Ts = 1e-4;
r = 20;
h = 10*Ts;

%%
f = logspace(-1,1,50)';
g = nan(size(f));
p = g;

tic
hwait = waitbar(0,'Starting...');
ft = fittype('sin1');
K = length(f);
for k = 1:K
    waitbar(k/K,hwait,sprintf('%d/%d',k,K));
    omg = 2*pi*f(k);
    T = 21/f(k);
    sim('Sim03_TrackingDiff_DT')
    
    offset = round(1/f(k)/Ts);
    [fobj,~] = fit(t(offset:end),y(offset:end),ft);
    g(k) = fobj.a1;
    p(k) = rad2deg(fobj.c1);
    disp(k)
end
waitbar(1,hwait,'Finished!');
toc

figure
subplot(2,1,1)
loglog(f,g)
grid on
xlabel('Frequency (Hz)')
ylabel('Gain')

subplot(2,1,2)
semilogx(f,p)
grid on
xlabel('Frequency (Hz)')
ylabel('Phase (deg)')
