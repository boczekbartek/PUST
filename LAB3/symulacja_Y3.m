function [ y3 ] = symulacja_Y3( y_1, y_2, u_1_11, u_1_12,u_2_11, u_2_12 )
%SYMULACJA_Y2 Summary of this function goes here
%   Detailed explanation goes here
T1_G1Y3 =36.9414;
T2_G1Y3 =98.9832;
K_G1Y3 = 0.0651;
alpha1_G1Y3 = exp(-1/T1_G1Y3);
alpha2_G1Y3 = exp(-1/T2_G1Y3);
a1_G1Y3 = -alpha1_G1Y3-alpha2_G1Y3;
a2_G1Y3 = alpha1_G1Y3*alpha2_G1Y3;
b1_G1Y3 = K_G1Y3*(T1_G1Y3*(1- alpha1_G1Y3)-T2_G1Y3*(1-alpha2_G1Y3))/(T1_G1Y3-T2_G1Y3);
b2_G1Y3 = K_G1Y3*(alpha1_G1Y3*T2_G1Y3*(1-alpha2_G1Y3)-alpha2_G1Y3*T1_G1Y3*(1-alpha1_G1Y3))/(T1_G1Y3-T2_G1Y3);

K_G2Y3 = 0.2439;
T2_G2Y3 = 61.0460;
T1_G2Y3 =18.6599;
alpha1_G2Y3 = exp(-1/T1_G2Y3);
alpha2_G2Y3 = exp(-1/T2_G2Y3);
a1_G2Y3 = -alpha1_G2Y3-alpha2_G2Y3;
a2_G2Y3 = alpha1_G2Y3*alpha2_G2Y3;
b1_G2Y3 = K_G2Y3*(T1_G2Y3*(1- alpha1_G2Y3)-T2_G2Y3*(1-alpha2_G2Y3))/(T1_G2Y3-T2_G2Y3);
b2_G2Y3 = K_G2Y3*(alpha1_G2Y3*T2_G2Y3*(1-alpha2_G2Y3)-alpha2_G2Y3*T1_G2Y3*(1-alpha1_G2Y3))/(T1_G2Y3-T2_G2Y3);

%usrednianie parametrow a
y3 = -y_1*(a1_G1Y3+a1_G2Y3)/2 + -y_2*(a2_G1Y3+a2_G2Y3)/2 + b1_G1Y3*u_1_11 + b1_G2Y3*u_2_11 + b2_G1Y3*u_1_12 + b2_G2Y3*u_2_12;

end

