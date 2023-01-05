%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% POWER SYSTEM LAB-II (M.Tech. (EE-PSE))
% EXPERIMENT No. 3
% Example-01 on dynamics of single machine infinite bus system.
% Modified by: Dr. Rajat Kanti Samal, VSSUT Burla
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
V=1;  Xd=1;  Xdd=0.3;   Xq=0.6;  th=acos(0.8);
S=0.5/0.8*(0.8+j*0.6)
Ia=conj(S)/V
disp('Neglecting Saliency')
Ed=V+j*Xdd*Ia
Ed=abs(Ed)
Pmax=Ed*V/Xdd
delta=0:.01:pi;
P=Pmax*sin(delta);
disp('Considering the saliency effect')
d= atan(Xq*abs(Ia)*.8/(V+Xq*abs(Ia)*0.6));
dd=d*180/pi
E=V*cos(d)+Xd*abs(Ia)*sin(d+th)
Edq=(Xdd*E-(Xdd-Xd)*V*cos(d))/Xd
Pmax1=Edq*V/Xdd;
Pmax2=V^2*(Xdd-Xq)/(2*Xdd*Xq)
Ps= Pmax1*sin(delta)+Pmax2*sin(2*delta);
%plot(delta*180/pi,P,delta*180/pi , Ps), grid
subplot(1,2,1), plot(delta*180/pi , P), grid
ylabel('Pe')
subplot(1,2,2), plot(delta*180/pi , Ps), grid
ylabel('Pe')
[Pmax  k]=max(Ps)
dmax=delta(k)*180/pi
subplot(1,1,1)





