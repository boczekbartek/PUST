function [ y ] = aproksymacjaObiektu( u11,u12,y1,y2 )
%APROKSYMACJAOBIEKTU Summary of this function goes here
%   Detailed explanation goes here
T1=17.099506;
T2=64.970974;
K=0.263644;

alpha1 = exp(-1/T1);
alpha2 = exp(-1/T2);
a1 = -alpha1-alpha2;
a2 = alpha1*alpha2;
b1 = K*(T1*(1- alpha1)-T2*(1-alpha2))/(T1-T2);
b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);
y = b1*u11+b2*u12-a1*y1-a2*y2;

end

