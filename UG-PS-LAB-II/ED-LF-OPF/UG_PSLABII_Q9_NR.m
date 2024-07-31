%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code is for Experiment No-4, Q9, UG Power System Lab-II
% Newton-Raphson Method of Load Flow Solution
% This can be run in MATLAB or OCTAVE
% This code originally belongs to Hadi Saadat Book, Ch-6, Example-8\9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% This code is for Ch-6, Example-9, Hadi Saadat Book 
%% Newton-Raphson Method of Power Flow Solution

clc;
clear; 

V = [1.05; 1.0; 1.04];
d = [0; 0; 0];
Ps=[-4; 2.0];
Qs= -2.5;
YB = [ 20-j*50  -10+j*20    -10+j*30
      -10+j*20   26-j*52    -16+j*32
      -10+j*30  -16+j*32     26-j*62];
Y= abs(YB); t = angle(YB);

iter=0;
pwracur = 0.00025; % Power accuracy
DC = 10;           % Set the maximum power residual to a high value
while max(abs(DC)) > pwracur
iter = iter +1

P=[V(2)*V(1)*Y(2,1)*cos(t(2,1)-d(2)+d(1))+V(2)^2*Y(2,2)*cos(t(2,2))+ ...
   V(2)*V(3)*Y(2,3)*cos(t(2,3)-d(2)+d(3));
   V(3)*V(1)*Y(3,1)*cos(t(3,1)-d(3)+d(1))+V(3)^2*Y(3,3)*cos(t(3,3))+ ...
   V(3)*V(2)*Y(3,2)*cos(t(3,2)-d(3)+d(2))];
Q= -V(2)*V(1)*Y(2,1)*sin(t(2,1)-d(2)+d(1))-V(2)^2*Y(2,2)*sin(t(2,2))- ...
    V(2)*V(3)*Y(2,3)*sin(t(2,3)-d(2)+d(3));
J(1,1)=V(2)*V(1)*Y(2,1)*sin(t(2,1)-d(2)+d(1))+...
       V(2)*V(3)*Y(2,3)*sin(t(2,3)-d(2)+d(3));
J(1,2)=-V(2)*V(3)*Y(2,3)*sin(t(2,3)-d(2)+d(3));
J(1,3)=V(1)*Y(2,1)*cos(t(2,1)-d(2)+d(1))+2*V(2)*Y(2,2)*cos(t(2,2))+...
   V(3)*Y(2,3)*cos(t(2,3)-d(2)+d(3));
J(2,1)=-V(3)*V(2)*Y(3,2)*sin(t(3,2)-d(3)+d(2));
J(2,2)=V(3)*V(1)*Y(3,1)*sin(t(3,1)-d(3)+d(1))+...
       V(3)*V(2)*Y(3,2)*sin(t(3,2)-d(3)+d(2));
J(2,3)=V(3)*Y(2,3)*cos(t(3,2)-d(3)+d(2));
J(3,1)=V(2)*V(1)*Y(2,1)*cos(t(2,1)-d(2)+d(1))+...
       V(2)*V(3)*Y(2,3)*cos(t(2,3)-d(2)+d(3));
J(3,2)=-V(2)*V(3)*Y(2,3)*cos(t(2,3)-d(2)+d(3));
J(3,3)=-V(1)*Y(2,1)*sin(t(2,1)-d(2)+d(1))-2*V(2)*Y(2,2)*sin(t(2,2))-...
        V(3)*Y(2,3)*sin(t(2,3)-d(2)+d(3));
DP = Ps - P;
DQ = Qs - Q;
DC = [DP; DQ]
J
DX = J\DC
d(2) =d(2)+DX(1);
d(3)=d(3) +DX(2);
V(2)= V(2)+DX(3);
V, d, delta =180/pi*d;
end
P1= V(1)^2*Y(1,1)*cos(t(1,1))+V(1)*V(2)*Y(1,2)*cos(t(1,2)-d(1)+d(2))+...
    V(1)*V(3)*Y(1,3)*cos(t(1,3)-d(1)+d(3))
Q1=-V(1)^2*Y(1,1)*sin(t(1,1))-V(1)*V(2)*Y(1,2)*sin(t(1,2)-d(1)+d(2))-...
    V(1)*V(3)*Y(1,3)*sin(t(1,3)-d(1)+d(3))
Q3=-V(3)*V(1)*Y(3,1)*sin(t(3,1)-d(3)+d(1))-V(3)*V(2)*Y(3,2)*...
    sin(t(3,2)-d(3)+d(2))-V(3)^2*Y(3,3)*sin(t(3,3))
