function [ y ] = char_stat( x )
%CHAR_STAT Summary of this function goes here
%   Detailed explanation goes here
m = open('ostateczny.mat')

ya = m.T1_zad2_skok_40(end);
yb = m.T1_zad2_skok_50_3(end);
yc = m.T1_zad2_skok_90_2(end);

if x<50
    y = (ya - yb)/(40-50)*x+(ya-(ya-yb)*40/(40-50))
else
     y = (yc - yb)/(90-50)*x+(yc-(yc-yb)*90/(90-50))
end


end

