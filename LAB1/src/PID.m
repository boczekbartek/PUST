clear all
Ypp=30.87;
Upp=28;
skok=12;
n = 1000;
Yzad(1:skok) = Ypp;
Yzad(skok+1:500) = 40;
Yzad(501:n) = 32;
U(1:n) = Upp;
 

Y(1:n) = Ypp; %inicjalizacje tablic
U(1:n) = Upp;
u = U - Upp;
err = 0;
yzad = Yzad-Ypp;
y=Y-Ypp; 

K=14.307542; Ti=38.320299; Td=6.677860; Ts=0.5;
 
r2 = K*Td/Ts;
r1 = K*(Ts/(2*Ti)-2*Td/Ts - 1);
r0 = K*(1+Ts/(2*Ti) + Td/Ts);

for k=skok+1:n
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
Y=y+Ypp;
nazwa = strcat('zadanie5_PID_Yzad.txt');
savePlot(1:1:n,Yzad,nazwa);
nazwa = strcat('zadanie5_PID_U.txt');
savePlot(1:1:n,U,nazwa);
nazwa = strcat('zadanie5_PID_Y.txt');
savePlot(1:1:n,Y,nazwa);
 
err = sum(e.^2)
 
figure('Position',  [403 246 820 420]);
subplot('Position', [0.1 0.12 0.8 0.15]);
stairs(U);
ylabel('u');
xlabel('k');
subplot('Position', [0.1 0.37 0.8 0.6]);

stairs(Y);
ylabel('y');
hold on;
stairs(Yzad,':');

