

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program is for Experiment No-5, Q-1 Power System Lab-II of M.Tech. (EE)
% This is related to computation of fault currents for different faults. 
% $Veer Surendra Sai University of Technology, Burla, Odisha, India$
% Copyright (C) 2022  Dr. Rajat Kanti Samal
% License: GNU GPL v3 (https://www.gnu.org/licenses/gpl-3.0.en.html)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;

Zm=[1 2 0.125 0.3
1 3 0.15 0.35
2 3 0.25 0.7125];
Zs1=[0.25 0.25 0];
Zs0=[0.4 0.4 0];
Ns=Zm( :,1); Nr=Zm( :,2) ;
Y1=zeros(3); Y0=zeros(3);

for i=1 :3
  Y1(Ns(i),Nr(i))=-1/(j*Zm(i,3));
  Y0(Ns(i),Nr(i))=-1/(j*Zm(i,4));
end

Y1=Y1+Y1.';Y0=Y0+Y0.';
for i=1:3
    if Zs1(i)==0
      Y1(i,i)=-sum(Y1(i,:));
    else
      Y1(i,i)=(1/(j*Zs1(i)))-sum(Y1(i,:));
    end
    if Zs0(i)==0
      Y0(i,i)=-sum(Y0(i,:));
    else
      Y0(i,i)=(1/(j*Zs0(i)))-sum(Y0(i,:));
    end
end
Z1=inv(Y1);Z0=inv(Y0);Z2=Z1;
Zf=0.1j;Vpf=1;Ib=100/20;
Zf1=Z1(3,3);Zf2=Z2(3,3);Zf0=Z0(3,3);
disp('Symmetrical three phase fault current:kA');
If=abs(Vpf/(Zf1+Zf))*Ib
disp('Single Line to Ground Fault Current:kA');
If=abs((3*Vpf)/(Zf1+Zf2+Zf0+Zf))*Ib
disp('Line to Line Fault Current:kA');
If=abs(-j*sqrt(3)*(Vpf/(Zf1+Zf2+Zf)))*Ib
disp('Double Line to Ground Fault Current:kA');
Ifa1=Vpf/(Zf1+(Zf2*(Zf0+(3*Zf))/(Zf2+Zf0+(3*Zf))));
Ifa0=-Ifa1*(Zf2/(Zf2+Zf0+(3*Zf)));
If=abs(3*Ifa0*Ib)
