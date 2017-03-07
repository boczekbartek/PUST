function  err  = funkcja_do_optymalizacji( param )

%__init__():
n = 10000;
Yzad(1:n) = 1.8;
Yzad(21:n) = 1.6;
Yzad(1001:n)=1.4;
Yzad(1501:n)=1.5;
Yzad(2201:n)=1.7;
U(1:n) = 1.0;
 
%self.punkt_pracy
Ypp = 2;
Upp = 1.1;
 
Y(1:n) = Ypp;
u = U - Upp;
err = 0;
%end __init__
 
 
K = param(1); Ti = param(2); Td = param(3); Ts = 0.5;
 
 
r2 = K*Td/Ts;
r1 = K*(Ts/(2*Ti)-2*Td/Ts - 1);
r0 = K*(1+Ts/(2*Ti) + Td/Ts);
%co to wogule jest jakies ruwnania na kiju :---DDD
 
%'__name__'==='__main__'
for k=21:n
     Y(k)=symulacja_obiektu3Y(U(k-10), U(k-11), Y(k-1), Y(k-2));
     
     e(k)=Yzad(k)-Y(k);
     
     du = r2*e(k-2)+r1*e(k-1)+r0*e(k);
     
     if du>0.05 %ograniczenia na szybkosc zmiany sygnalu sterowania
         du = 0.05;
     end
     if du<-0.05
         du = -0.05;
     end
     
     u(k)=du+u(k-1);
     
     if u(k)>0.2 %ograniczenia na min/max sygnalu sterowania
         u(k) = 0.2;
     end
     if u(k)<-0.2
         u(k) = -0.2;
     end
     U(k)= u(k) + Upp; %przesuniecie sterowania do punktu pracy
end;
 
err = sum(e.^2)

end

