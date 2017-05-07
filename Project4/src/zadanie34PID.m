clear all

n = 1000;
Yzad(1:n) = 0;
Yzad(21:n) = -1;
Yzad(201:n)= -2;
Yzad(401:n)= 0.1;
Yzad(601:n)=-2;
Yzad(801:n)=-1;
U(1:n) = 0;
Y(1:n) = 0;

err = 0;

K=0.17; Ti=3.5; Td=1.1; Ts=0.5;

r2 = K*Td/Ts; 
r1 = K*(Ts/(2*Ti)-2*Td/Ts - 1); 
r0 = K*(1+Ts/(2*Ti) + Td/Ts);

 
for k=21:n
    
     Y(k)=symulacja_obiektu10y(U(k-5), U(k-6), Y(k-1), Y(k-2));
     e(k)=Yzad(k)-Y(k);
     
     du = r2*e(k-2)+r1*e(k-1)+r0*e(k);
     
     U(k)=du+U(k-1);
     
     if U(k)>1
         U(k) = 1;
     end
     if U(k)<-1
         U(k) = -1;
     end
end;
 
err = sum(e.^2)
 
figure('Position',  [403 246 820 420]);
subplot('Position', [0.1 0.12 0.8 0.15]);
stairs(U);

ylabel('u');
xlabel('k');
subplot('Position', [0.1 0.37 0.8 0.6]);
stairs(Y);
savePlot(1:n,U,'zad34pid_U.txt');
savePlot(1:n,Y,'zad34pid_Y.txt');
ylabel('y');
hold on;
stairs(Yzad,':');
