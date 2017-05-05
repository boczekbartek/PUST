clear uu
clear yy
uu(1) = 0;
uu(2:300) = 1;
plot(uu)
yy(1:300)= 0;
for k = 13:300
    k
    yy(k)=symulacja_Y1(uu(k-11), uu(k-12), yy(k-1), yy(k-2))
end

plot(yy)