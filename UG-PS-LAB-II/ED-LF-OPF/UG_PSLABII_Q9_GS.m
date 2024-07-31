%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code is for Experiment No-4, Q9, UG Power System Lab-II
% Gauss-Siedel Method of Load Flow Solution
% This can be run in MATLAB or OCTAVE
% This code originally belongs to Hadi Saadat Book, Ch-6, Example-8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear;

y12=10-j*20;
y13=10-j*30;
y23=16-j*32;
y33=y13+y23;
V1=1.05+j*0;
format long
iter =0;
S2=-4.0-j*2.5;
P3 = 2;
V2=1+j*0;
Vm3=1.04;
V3=1.04+j*0;
for I=1:10;
iter=iter+1
E2 = V2;
E3=V3;
V2 = (conj(S2)/conj(V2)+y12*V1+y23*V3)/(y12+y23)
DV2 = V2-E2
Q3 = -imag(conj(V3)*(y33*V3-y13*V1-y23*V2))
S3 = P3 +j*Q3;
Vc3 = (conj(S3)/conj(V3)+y13*V1+y23*V2)/(y13+y23)
Vi3 = imag(Vc3);
Vr3= sqrt(Vm3^2 - Vi3^2);
V3 = Vr3 + j*Vi3
DV3=V3-E3
end
format short
I12=y12*(V1-V2); I21=-I12;
I13=y13*(V1-V3); I31=-I13;
I23=y23*(V2-V3); I32=-I23;
S12=V1*conj(I12); S21=V2*conj(I21);
S13=V1*conj(I13); S31=V3*conj(I31);
S23=V2*conj(I23); S32=V3*conj(I32);
I1221=[I12,I21]
I1331=[I13,I31]
I2332=[I23,I32]
S1221=[S12, S21  (S12+S13) S12+S21]
S1331=[S13, S31  (S31+S32) S13+S31]
S2332=[S23, S32  (S23+S21) S23+S32]
