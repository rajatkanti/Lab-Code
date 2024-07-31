%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code is for Experiment No-4, Q9, UG Power System Lab-II
% Fast Decoupled Method of Load Flow Solution
% This can be run in MATLAB or OCTAVE
% This code originally belongs to Hadi Saadat Book, Ch-6, Example-9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear; 

V1= 1.05; V2 = 1.0; V3 = 1.04;
d1 = 0; d2 = 0; d3=0;
Ps2=-4;  Ps3 =2.0;
Qs2= -2.5;
YB = [ 20-j*50  -10+j*20    -10+j*30
      -10+j*20   26-j*52    -16+j*32
      -10+j*30  -16+j*32     26-j*62];
Y = abs(YB); t=angle(YB);
B =[-52 32; 32 -62]
Binv = inv(B)
iter=0;
pwracur = 0.0003;  % Power accuracy
DC = 10;           % Set the max of power mismatch to a high value
while max(abs(DC)) > pwracur
iter = iter +1;
P2= V2*V1*Y(2,1)*cos(t(2,1)-d2+d1)+V2^2*Y(2,2)*cos(t(2,2))+ ...
    V2*V3*Y(2,3)*cos(t(2,3)-d2+d3);
P3= V3*V1*Y(3,1)*cos(t(3,1)-d3+d1)+V3^2*Y(3,3)*cos(t(3,3))+ ...
    V3*V2*Y(3,2)*cos(t(3,2)-d3+d2);
Q2=-V2*V1*Y(2,1)*sin(t(2,1)-d2+d1)-V2^2*Y(2,2)*sin(t(2,2))- ...
    V2*V3*Y(2,3)*sin(t(2,3)-d2+d3);
DP2 = Ps2 - P2; DP2V = DP2/V2;
DP3 = Ps3 - P3; DP3V = DP3/V3;
DQ2 = Qs2 - Q2; DQ2V = DQ2/V2;
DC =[DP2; DP3; DQ2];
Dd = -Binv*[DP2V;DP3V];
DV = -1/B(1,1)*DQ2V;

d2 =d2+Dd(1);
d3 =d3+Dd(2);
V2= V2+DV;
angle2 =180/pi*d2;
angle3 =180/pi*d3;
R = [iter  d2  d3  V2  DP2  DP3 DQ2];
disp(R)
end
Q3=-V3*V1*Y(3,1)*sin(t(3,1)-d3+d1)-V3^2*Y(3,3)*sin(t(3,3))- ...
    V3*V2*Y(3,2)*sin(t(3,2)-d3+d2);
P1= V1^2*Y(1,1)*cos(t(1,1))+V1*V2*Y(1,2)*cos(t(1,2)-d1+d2)+ ...
    V1*V3*Y(1,3)*cos(t(1,3)-d1+d3);
Q1=-V1^2*Y(1,1)*sin(t(1,1))-V1*V2*Y(1,2)*sin(t(1,2)-d1+d2)- ...
    V1*V3*Y(1,3)*sin(t(1,3)-d1+d3);
S1=P1+j*Q1
Q3
