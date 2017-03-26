function  err  = PIDfun( param )


Ypp=30.87;
Upp=28;
n = 10000;
Yzad(1:n) = Ypp;
Yzad(21:n) = 20;
Yzad(1001:n)=40;
Yzad(1501:n)=30;
Yzad(2201:n)=33;
U(1:n) = 1.0;


Y(1:n) = Ypp; %inicjalizacje tablic
U(1:n) = Upp;
u = U - Upp;
err = 0;

yzad = Yzad-Ypp;

y=Y-Ypp; 
 
K = param(1); Ti = param(2); Td = param(3); Ts = 0.5;

r2 = K*Td/Ts;
r1 = K*(Ts/(2*Ti)-2*Td/Ts - 1);
r0 = K*(1+Ts/(2*Ti) + Td/Ts);

 

for k=21:n
     y(k)=aproksymacjaObiektu(u(k-11), u(k-12), y(k-1), y(k-2));
     
     e(k)=yzad(k)-y(k);
     
     du = r2*e(k-2)+r1*e(k-1)+r0*e(k);
     
     u(k)=du+u(k-1);

     U(k)= u(k) + Upp; %przesuniecie sterowania do punktu pracy
     
    if U(k)>100
        U(k)=100;
    elseif U(k) <0
        U(k)=0;
    end
end;
 
err = sum(e.^2);

end


