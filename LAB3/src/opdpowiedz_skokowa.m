U(1:3)=U1pp;
U(4:400)=70;
n = 400;
s_y1_g1= zeros(1,n);
for k = 21:n
    s_y1_g1(k-20) = (Y1_G1_70(k)-Y1pp)/(U(k)-U1pp);
end


s_y1_g1 = s_y1_g1(1:379);
stairs(s_y1_g1)
