clear all;
zadanie3
n = 2500; %dlugosc symulacji, skróæ do 3000 w rysunkach do pdfa i wspomnij
          %o tym w sprawku. wyd³u¿ona do usuniêcia oscylacji
          %przy optymalizacji
% Yzad(1:199) = 2.5;
% Yzad(200:1000) = 2.0;
% Yzad(1001:1500)=1.4;
% Yzad(1501:2200)=1.5;
% Yzad(2201:n)=1.7;
Yzad(1:n) = 1.8;
Yzad(21:n) = 1.6;
Yzad(1001:n)=1.4;
Yzad(1501:n)=1.5;
Yzad(2201:n)=1.7;
Ypp = 2.0; %punkt pracy
Upp = 1.1;
Y(1:n) = 2.0; %inicjalizacje tablic
U(1:n) = 1.1;
u = U - Upp;
err = 0;

%odpowiedzi skokowe pobrane z utworzonego wczesniej pliku



D=100; 
%parametry regulatora dobrane eksperymentalnie
% N=25; Nu=3; lambda=0.6; %err=15.6111
N=171.0; Nu=10.0; lambda=0.290732;
%parametry dobrane skryptem param_optimizer
%N=12; Nu=7; lambda=0.0103;
%N=14; Nu=20; lambda=0.2290;
%N=13; Nu=13; lambda=0;
%N=37.000000; Nu=3.000000; lambda=0.015540; %final w/ err=sum(|e|) as quality index
%N=64.000000; Nu=9.000000; lambda=0.013380; %final w/ normal err
%N=33.000000; Nu=4.000000; lambda=0.018527; %really final, after changing DMC_err yzad
                                %err = 15.5746
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


