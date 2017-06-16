function err = dmcfun( param,Ustart,Uend,odpSkok, wykresy)
%DMC_ERR liczy wartosc bledu regulatora dla zadanych parametrow przy D=120

s = odpSkok;
D=length(s);

n = 2000; %dlugosc symulacji


Umin = -1;
Umax = 1;
dupmax = 0.1;
dupmin = -0.1;


N = param(1);
Nu = param(2);
lambda = param(3);
Ymin=char_stat_fun(Ustart);
Ymax=char_stat_fun(Uend);
% 
N=round(N);
Nu=round(Nu);
Yzad(1:n) = Ymin;
Yzad(21:n) = (Ymax+Ymin)/2;
Yzad(400:n)=(Ymax+Ymin)/3;
Yzad(900:n)=(Ymax+Ymin)/8;
Yzad(1600:n)=(Ymax+Ymin)*7/8;

M=zeros(N,Nu);
MP=zeros(N,D-1);
I=eye(Nu);
ku=zeros(n,D-1);
ke=zeros(1,n);

M=zeros(N,Nu);
for i=1:N
   for j=1:Nu
      if (i>=j)
      
         M(i,j)=s(i-j+1);
      end
   end
end

MP=zeros(N,D-1);
for i=1:N
   for j=1:D-1
      if i+j<=D
         MP(i,j)=s(i+j)-s(j);
      else
         MP(i,j)=s(D)-s(j);
      end;      
   end;
end;

% Obliczanie parametr�w regulatora

I=eye(Nu);
K=((M'*M+lambda*I)^-1)*M'
ku=K(1,:)*MP;
ke=sum(K(1,:));

Upp = Ustart;
Ypp = Ymin;
U(1:n)=Upp;
Y(1:n)=Ypp;

e=zeros(1,n);

deltaup=zeros(1,D-1);

Un=zeros(1,n);
err = 0;
for k=7:n
    %symulacja obiektu
    Y(k)= symulacja_obiektu10y(U(k-5),U(k-6),Y(k-1),Y(k-2));
    %uchyb regulacji
    e(k)=Yzad(k) - Y(k);
    err = err + e(k)^2;
    deltauk=ke*e(k)-ku*deltaup';
   
   for n=D-1:-1:2
      deltaup(n)=deltaup(n-1);
   end
   
     if deltauk>0.1
        deltauk = dupmax;
    elseif deltauk<-0.1
        deltauk = dupmin;
    end   
    
   deltaup(1)=deltauk;
   U(k)=U(k-1)+deltaup(1);
   
   if U(k)>Uend
      	U(k)=Uend;
   elseif U(k)<Ustart
        U(k)=Ustart;
   end
end


if wykresy
    figure 
    plot(Yzad, '-')
    hold on
    plot(Y)
end
