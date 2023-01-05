%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% POWER SYSTEM LAB-II (M.Tech. (EE-PSE))
% EXPERIMENT No. 3
% To study the dynamic of single machine infinite bus system.
% Modified by: Dr. Rajat Kanti Samal, VSSUT Burla
% The main program for running this function is PG-PSLAB2-Exp03-Main.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This program obtain the power angle curve for a one machine system
function Eacpower(P0, E, V, X)
% This program obtains the power angle curve for a one-machine system
% during normal operation. Using equal area criterion the maximum input
% power that can be suddenly applied for the machine to remain critically
% stable is obtained.
%

if exist('P0')~=1
P0 = input('Generator initial power in p.u. P0 = '); else, end
if exist('E')~=1
E = input('Generator e.m.f. in p.u. E = '); else, end
if exist('V')~=1
V = input('Infinite bus-bar voltage in p.u. V = '); else, end
if exist('X')~=1
X = input('Reactance between internal emf and infinite bus in p.u. X = '); else, end
Pemax= E*V/X;
if P0 >= Pemax
  fprintf('\nP0 must be less than the peak electrical power Pemax = %5.3f p.u. \n', Pemax)
  fprintf('Try again. \n\n')
return, end
d0=asin(P0/Pemax);
delta = 0:.01:pi;
Pe = Pemax*sin(delta);
dmax=pi;
Ddmax=1;
while abs(Ddmax) > 0.00001
    Df = cos(d0) - (sin(dmax)*(dmax-d0)+cos(dmax))
    J=cos(dmax)*(dmax-d0);
    Ddmax=Df/J;
    dmax=dmax+Ddmax;
end
dc=pi-dmax;
Pm2=Pemax*sin(dc);
Pmx =[0  pi-d0]*180/pi; Pmy=[P0 P0];
Pm2x=[0  dmax]*180/pi; Pm2y=[Pm2 Pm2];
x0=[d0 d0]*180/pi; y0=[0 Pm2]; xc=[dc dc]*180/pi; yc=[0 Pemax*sin(dc)];
xm=[dmax dmax]*180/pi; ym=[0 Pemax*sin(dmax)];
d0=d0*180/pi; dmax=dmax*180/pi; dc=dc*180/pi;
x=(d0:.1:dc);
y=Pemax*sin(x*pi/180);
%y1=Pe2max*sin(d0*pi/180);
%y2=Pe2max*sin(dc*pi/180);
x=[d0 x dc];
y=[Pm2 y Pm2];
xx=dc:.1:dmax;
h=Pemax*sin(xx*pi/180);
xx=[dc xx  dmax];
hh=[Pm2 h  Pm2];
delta=delta*180/pi;
%clc
fprintf('\nInitial power                      =%7.3f p.u.\n', P0)
fprintf('Initial power angle                =%7.3f degrees \n', d0)
fprintf('Sudden additional power            =%7.3f p.u.\n', Pm2-P0)
fprintf('Total power for critical stability =%7.3f p.u.\n', Pm2)
fprintf('Maximum angle swing                =%7.3f degrees \n', dmax)
fprintf('New operating angle                =%7.3f degrees \n\n\n', dc)
fill(x,y,'m')
hold;
fill(xx,hh,'c')
plot(delta, Pe,'-', Pmx, Pmy,'g', Pm2x,Pm2y,'g', x0,y0,'c', xc,yc, xm,ym,'r'), grid
Title('Equal-area criterio applied to the sudden change in power')
xlabel('Power angle, degree'), ylabel(' Power, per unit')
axis([0 180  0 1.1*Pemax])
hold off;




