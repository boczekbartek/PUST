%obliczenie odpowiedzi skokowej
clear all
zadanie3
params
n = 2500; %dlugosc symulacji

Yzad(1:n) = 1.9;
Yzad(21:n) = 1.6;
Yzad(1001:n)=1.4;
Yzad(1501:n)=2.5;
Yzad(2201:n)=1.4;

Y(1:n) = Ypp; %inicjalizacje tablic
U(1:n) = Upp;
u = U - Upp;
err = 0;

D=110; 
%parametry regulatora dobrane eksperymentalnie
% N=19; Nu=6; lambda=0.15;
%parametry wyznaczone z optymalizacji
N=130.000000; Nu=6.000000; lambda=0.010000;

%inicjalizacja macierzy dUp
for i=1:D-1
   dup(i)=0;
end

%generacja macierzy

M=zeros(N,Nu);
for i=1:N
   for j=1:Nu
      if (i>=j)
         M(i,j)=s(i-j+1);
      end;
   end;
end;

Mp=zeros(N,D-1);
for i=1:N
   for j=1:D-1
      if i+j<=D
         Mp(i,j)=s(i+j)-s(j);
      else
         Mp(i,j)=s(D)-s(j);
      end;      
   end;
end;

%przeksztalcanie wyliczonych macierzy do potrzebnych nam parametrow

K=((M'*M+lambda*eye(Nu))^-1)*M';
Ku=K(1,:)*Mp;
Ke=sum(K(1,:));

%glowna petla

for i=21:n
   
   Y(i)=symulacja_obiektu3Y(U(i-10), U(i-11), Y(i-1), Y(i-2));
   
   e=Yzad(i)-Y(i); %uchyb
   err = err + e^2;
   
   du=Ke*e-Ku*dup'; %regulator
   
   if du>0.05 %ograniczenia na szybkosc zmiany sygnalu sterowania
       du = 0.05;
   elseif du<-0.05
       du = -0.05;
   end
   
   for n=D-1:-1:2
      dup(n)=dup(n-1);
   end
   dup(1)=du;
   u(i)=u(i-1)+dup(1);
   
   if u(i)>0.2 %ograniczenia na min/max sygnalu sterowania
       u(i) = 0.2;
       dup(1) = u(i)-u(i-1);
   elseif u(i)<-0.2
       u(i) = -0.2;
       dup(1) = u(i)-u(i-1);
   end
   
   
   U(i)=u(i)+Upp; %przesuniecie do punktu pracy
end

err

figure('Position',  [403 246 820 420]);
title('obiekt z regulatorem PID');
subplot('Position', [0.1 0.12 0.8 0.15]);
stairs(U);
ylabel('u'); 
xlabel('k');

subplot('Position', [0.1 0.37 0.8 0.6]);
plot(Y);
ylabel('y'); 

hold on; 
stairs(Yzad,':');
%zapisywanie danych do plikow txt w celu narysowania wykresow w LATEXie
nazwa = strcat('wykresy/zadanie6_DMC_Yzad.txt');
savePlot(1:1:2500,Yzad,nazwa);
nazwa = strcat('wykresy/zadanie6_DMC_U.txt');
savePlot(1:1:2500,U,nazwa);
nazwa = strcat('wykresy/zadanie6_DMC_Y.txt');
savePlot(1:1:2500,Y,nazwa);
