function [ y1 ] = symulacja_Y1( y_1, y_2,u_1_11, u_1_12)
%SYMULACJA_Y1 Summary of this function goes here
%   Detailed explanation goes here

    T1=32.904529; T2=46.663435; K=0.521417;
    alpha1 = exp(-1/T1);
    alpha2 = exp(-1/T2);
    a1 = -alpha1-alpha2;
    a2 = alpha1*alpha2;
    b1 = K*(T1*(1- alpha1)-T2*(1-alpha2))/(T1-T2);
    b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);

    %usrednianie parametrow a
    y1 = b1*u_1_12+b2*u_1_12-a1*y_1- a2*y_2;


end

