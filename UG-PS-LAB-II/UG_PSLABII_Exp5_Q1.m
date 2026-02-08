%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program is for Experiment No-6, Power System Lab-II of B.Tech. (EE)
% This specifically solves Q-1 related to simulation of unsymmetrical fault.
% $Veer Surendra Sai University of Technology, Burla, Odisha, India$
% Copyright (C) 2022  K DHANUSA (Final Year Undergraduate B.Tech.(EE))
% License: GNU GPL v3 (https://www.gnu.org/licenses/gpl-3.0.en.html)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PROBLEM STATEMENT (WRITE A PROGRAM IN MATLAB/OCTAVE TO COMPUTE THE FAULT CURRENT)
%(i) three phase symmetrical fault LG fault
%(ii) LG fault
%(iii)LL fault
%(iv)Double line-to-ground fault
%The ratings are provided below
%Generator: 11 kV, 50 MVA: x'd=15%, x2=xd; XD=8%
%Grounding reactance = 2.5 ohm T1,TZ: 11/132 kV, 60 MVA; X=10%
%M1-11 KV,30 MVA: X'd = X2 = 20%; XD = 8% M2 = 11 kV; 15 MVA;
%Transmission line: X1=X2; 120 ohm reactance; X0=3X1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear;


###GENERATOR###
p1=50
v1=11
x1=0.15
x2=0.15
xo=0.08
%TO GET THE PU VALUE%
zb=v1*v1/p1
xn=2.5/zb
###CHANGE IN THE VOLTAGE DUE TO THE TRANSFORMER###
v2=132
###TO GET THE PU VALUE###
zb1=(v2*v1)/p1
X1=X2= 120/348.48
X0=0.344*3
X1=X2= (0.2*50)/30
X0=0.266
### TO GET THE PU VALUE###
ZB2=v1*v1/p1
xn=3*xn
lb=(50000/(sqrt(3)*11))
### 3 PHASE FAULT ####
pf=lb/0.166
### LLG fault###
llg=3*lb/(0.166+0.166+3.365)
###LL FAULT###
ll=lb/(0.166+0.166)
###LLG Fault###
la0=1/(0.166+((0.166*3.365)/(0.166+3.365)))
Va0=1-(la0*0.166)
llg=3*lb*Va0/3.365
