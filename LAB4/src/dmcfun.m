function err = dmcfun( param )


n = 10000; %dlugosc symulacji
Ypp=35;
Upp=35;

tmp = load('ostateczny.mat');
od = tmp.T1_zad2_skok_40_2;
s = (od(1:400)-Ypp)/(40-Upp);

Yzad(1:n) = Ypp;
Yzad(21:n) = 20;
Yzad(1001:n)=40;
Yzad(1501:n)=30;
Yzad(2201:n)=33;

Y(1:n) = Ypp; %inicjalizacje tablic
U(1:n) = Upp;
u = U - Upp;
err = 0;

yzad = Yzad-Ypp;

y=Y-Ypp;
D=250;

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
      y(i)=symulacja_Y1(u(i-11),u(i-12),y(i-1),y(i-2));
    
    e=yzad(i)-y(i); %uchyb
    err = err + e^2;
    
    du=Ke*e-Ku*dup'; %regulator
    for n=D-1:-1:2
        dup(n)=dup(n-1);
    end
    dup(1)=du;
    u(i)=u(i-1)+dup(1);
    
    U(i)=u(i)+Upp;%przesuniecie do punktu pracy
   
    if U(i)>100
        U(i)=100;
    elseif U(i) <0
        U(i)=0;
    end
end


end
