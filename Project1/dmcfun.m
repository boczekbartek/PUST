function err = dmcfun( param )
%DMC_ERR liczy wartosc bledu regulatora dla zadanych parametrow przy D=120
zadanie3

n = 10000; %dlugosc symulacji, skróæ do 3000 w rysunkach do pdfa i wspomnij
          %o tym w sprawku. wyd³u¿ona do usuniêcia oscylacji
          %przy optymalizacji
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

%parametry regulatora dobrane eksperymentalnie

D=100;
%param(1)=30;
%param(2)=3;
%param(3)=0.8;

%inicjalizacja macierzy dUp
for i=1:D-1
   dup(i)=0;
end

%generacja pozostalych macierzy
M=zeros(param(1),param(2));
for i=1:param(1)
   for j=1:param(2)
      if (i>=j)
         M(i,j)=s(i-j+1);
      end;
   end;
end;

Mp=zeros(param(1),D-1);
for i=1:param(1)
   for j=1:D-1
      if i+j<=D
         Mp(i,j)=s(i+j)-s(j);
      else
         Mp(i,j)=s(D)-s(j);
      end;      
   end;
end;

%przeksztalcanie wyliczonych macierzy do potrzebnych nam parametrow

K=((M'*M+param(3)*eye(param(2)))^-1)*M';
Ku=K(1,:)*Mp;
Ke=sum(K(1,:));

%glowna petla

for i=21:n
   
   Y(i)=symulacja_obiektu3Y(U(i-10), U(i-11), Y(i-1), Y(i-2));
   
   e=Yzad(i)-Y(i); %uchyb
   err = err + e^2;
   %err = err + abs(e);
   
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


end
