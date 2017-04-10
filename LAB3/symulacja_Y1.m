function [ y1 ] = symulacja_Y1( y_1, y_2,u_1_11, u_1_12,u_2_11, u_2_12)
%SYMULACJA_Y1 Summary of this function goes here
%   Detailed explanation goes here

T1_G1Y1 =10.6113;
T2_G1Y1 =60.2108;
K_G1Y1 =0.2641;
alpha1_G1Y1 = exp(-1/T1_G1Y1);
alpha2_G1Y1 = exp(-1/T2_G1Y1);
a1_G1Y1 = -alpha1_G1Y1-alpha2_G1Y1;
a2_G1Y1 = alpha1_G1Y1*alpha2_G1Y1;
b1_G1Y1 = K_G1Y1*(T1_G1Y1*(1- alpha1_G1Y1)-T2_G1Y1*(1-alpha2_G1Y1))/(T1_G1Y1-T2_G1Y1);
b2_G1Y1 = K_G1Y1*(alpha1_G1Y1*T2_G1Y1*(1-alpha2_G1Y1)-alpha2_G1Y1*T1_G1Y1*(1-alpha1_G1Y1))/(T1_G1Y1-T2_G1Y1);

K_G2Y1 = 0;
T2_G2Y1 = 79.354;
T1_G2Y1 =0.0584;
alpha1_G2Y1 = exp(-1/T1_G2Y1);
alpha2_G2Y1 = exp(-1/T2_G2Y1);
a1_G2Y1 = -alpha1_G2Y1-alpha2_G2Y1;
a2_G2Y1 = alpha1_G2Y1*alpha2_G2Y1;
b1_G2Y1 = K_G2Y1*(T1_G2Y1*(1- alpha1_G2Y1)-T2_G2Y1*(1-alpha2_G2Y1))/(T1_G2Y1-T2_G2Y1);
b2_G2Y1 = K_G2Y1*(alpha1_G2Y1*T2_G2Y1*(1-alpha2_G2Y1)-alpha2_G2Y1*T1_G2Y1*(1-alpha1_G2Y1))/(T1_G2Y1-T2_G2Y1);

%usrednianie parametrow a
y1 = -y_1*(a1_G1Y1+a1_G2Y1)/2 + -y_2*(a2_G1Y1+a2_G2Y1)/2 + b1_G1Y1*u_1_11 + b1_G2Y1*u_2_11 + b2_G1Y1*u_1_12 + b2_G2Y1*u_2_12;

end

