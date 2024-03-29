clear; // Remove clear, clc from code if you want to access existing stored variable from the memory

// This code is downloaded from https://cloud.scilab.in/
// This is for Power System Lab-I, Experiment No-7, Q-8
// B.Tech. Electrical Engineering, VSSUT Burla.
// Modified by Dr. Rajat Kanti Samal

//Chapter 5
//Example 5.3
//Modern Power System Analysis by D.P. Kothari and I.J. Nagrath
//Power System Engineering by D.P. Kothari and I.J. Nagrath
//problem with mixed end condition
clc;clear;
Vr=3000; //receiving end voltage
pfs=0.8; //sending end power factor
Ps=2000*10^3; //sending end active power
z=0.4+%i*0.4; //series impedance
Ss=Ps/pfs; //sending end VA 
Qs=Ss*sqrt(1-pfs^2); //sending end reacive power

//by substituting all the values to the equation (iii)
deff('[y]=fx(I)',"y=(Vr^2)*(I^2)+2*Vr*(I^2)*(real(z)*((Ps-real(z)*(I^2))/Vr)+imag(z)*((Qs-imag(z)*(I^2))/Vr))+(abs(z))^2*(I^4)-(Ss^2)");
I=fsolve(100,fx);

pfR=(Ps-real(z)*(I^2))/(Vr*I); //Cos(phi_r)
Pr=Vr*I*pfR;
Vs=(Ps/(I*pfs));

printf('\nLoad Current |I|= %0.2f A',I);
printf('\nLoad Pr=%d W',Pr);
printf('\nReceiving end power factor=%0.2f',pfR);
printf('\nSupply Voltage=%0.2fV',Vs);






