%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% POWER SYSTEM LAB-II (M.Tech. (EE-PSE))
% EXPERIMENT No. 3
% Example-03 on dynamics of single machine infinite bus system.
% Modified by: Dr. Rajat Kanti Samal, VSSUT Burla
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
E=1.35;  V=1.0;  H=9.94;  X=0.65;   Pm=0.6;  D=0.138;    f0=60;
Pmax=E*V/X 
d0=asin(Pm/Pmax)                % Maximum Power
Ps=Pmax*cos(d0)
wn=sqrt(pi*60/H*Ps)
z=D/2*sqrt(pi*60/(H*Ps))
wd=wn*sqrt(1-z^2);   
fd=wd/(2*pi)
tau=1/(z*wn)
th=acos(z)
Dp=0.2;
Du=pi*f0/H*Dp;
t=0:.01:3;
Dd=Du/(wn*sqrt(1-z^2))*exp(-z*wn*t).*sin(wd*t + th);
d=(d0+Dd)*180/pi;
Dw=Du/(wn*sqrt(1-z^2))*exp(-z*wn*t).*sin(wd*t);
f=f0+Dw/(2*pi);
figure(1), subplot(2,1,1), plot(t,d), grid
xlabel('t, sec'),ylabel('Delta, drgree')
subplot(2,1,2), plot(t,f), grid
xlabel('t, sec'),ylabel('Frequency, Hz')
A=[0 1; -wn^2  -2*z*wn];
Dp=0.1;
Du=pi*f0/H*Dp;
B=[0;1]*Du;
C=[1 0; 0 1];
D=[0; 0];
[y,x]= step(A, B, C, D, 1, t);
Dd=x(:,1);  Dw=x(:,2);
d1=(d0+Dd)*180/pi;
f1=f0+Dw/(2*pi);
figure(2),subplot(2,1,1), plot(t,d), grid
xlabel('t,sec'),ylabel('Delta , degrees')
subplot(2,1,2), plot(t,f), grid
xlabel('t, sec'),ylabel('Delta, drgree')
subplot(1,1,1)






