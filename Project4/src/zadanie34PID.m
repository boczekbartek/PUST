clear all

Ypp=0;
Upp=0;

%__init__():
n = 2500;
Yzad(1:n) = 1.9;
Yzad(21:n) = 1.6;
Yzad(1001:n)=1.4;
Yzad(1501:n)=2.5;
Yzad(2201:n)=1.4;
U(1:n) = Upp;
Y(1:n) = Ypp;

err = 0;

K=10; Ti=10; Td=0; Ts=0.5;

% r2 = K*Td/Ts;
% r1 = K*(Ts/(2*Ti)-2*Td/Ts - 1);
% r0 = K*(1+Ts/(2*Ti) + Td/Ts);

r2 = K*Td/Ts; 
r1 = K*(Ts/(2*Ti)-2*Td/Ts - 1); 
r0 = K*(1+Ts/(2*Ti) + Td/Ts);

 
for k=21:n
    
     Y(k)=symulacja_obiektu10y(U(k-5), U(k-6), Y(k-1), Y(k-2));
     
     e(k)=Yzad(k)-Y(k);
     
     du = r2*e(k-2)+r1*e(k-1)+r0*e(k);
     U(k)=du+U(k-1);
     
%      if U(k)>1
%          U(k) = 1;
%      end
%      if U(k)<-1
%          U(k) = -1;
%      end
end;
 
err = sum(e.^2);
 
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
