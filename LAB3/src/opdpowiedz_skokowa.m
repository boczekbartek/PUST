Zpp = 0;
U(1:10)=31;
U(11:350)=50;
Upp=31;
Ypp = 31.5;
n = 350;
s= zeros(1,350);
for k = 21:n
    s(k-20) = (Y_u50(k)-Ypp)/(U(k)-Upp);
end


s = s(1:320);
stairs(s)
