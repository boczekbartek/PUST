function [E]=zad50dmc(N,Nu,lambda,n,d,c,latex)

%N skalar
%Nu skalar
%lambda wektor n liczb
%rozmiar lambdy, ilosc reg lokalnych
%d skalar? z r�wna� ni�ej wynika �e skalar, ale oni w optymalizatorze podawali wektor n liczb
%c wektor n-1 liczb

close all

N=round(N);
Nu=round(Nu);

s1 = odpowiedzi_skokowe(-1.000,-0.96);
sn = odpowiedzi_skokowe(0.96,1);


D=80;
Upp=0;
Ypp=0;
Umin=-1;
Umax=1;
dupmax = 0.1;
dupmin = -0.1;

kk=1410;
startk=10;


M=zeros(N,Nu);
MP=zeros(N,D-1);
I=eye(Nu);
ku=zeros(n,D-1);
ke=zeros(1,n);

%chyba rozumiem, tu trzeba podzielic odcinek -1:1 na 50 rownych(?) kawalkow
%z nich zebrac odpowiedzi skokowe w sensie skok z jednej granicy do drugiej
%i je wrzuci� do tych 50 dmck�w

for m=1:n
    
    if m==1
        s=s1;
    elseif m==n
        s=sn;
    else
        s = odpowiedzi_skokowe(-1 + m*0.04, -1 + (m*0.04) + 0.04);
    end
       
    
    for i=1:N
        for j=1:Nu
            if (i>=j)
                M(i,j)=s(i-j+1);
            end;
        end;
    end;
    
    for i=1:N
        for j=1:D-1
            if i+j<=D
                MP(i,j)=s(i+j)-s(j);
            else
                MP(i,j)=s(D)-s(j);
            end;
        end;
    end;
    
    K=((M'*M+lambda(m)*I)^-1)*M';
    ku(m,:)=K(1,:)*MP;
    ke(m)=sum(K(1,:));
end



U(1:kk)=Upp;
Y(1:kk)=Ypp;

e=zeros(1,kk);


Yzad(1:startk)=Ypp;
Yzad(startk:210)=0.08;
Yzad(210:410)=0;
Yzad(410:610)=-2.5;
Yzad(610:810)=-1;
Yzad(810:1010)=-0.05;
Yzad(1010:1210)=-0.5;
Yzad(1210:1410)=-1;


deltaup=zeros(1,D-1);

Un=zeros(1,n);
mi=zeros(1,n);

for k=7:kk
    Y(k)= symulacja_obiektu10y(U(k-5),U(k-6),Y(k-1),Y(k-2));
    e(k)=Yzad(k) - Y(k);
    
    for m=1:n
        % n regulatorow, n praw regulacji
        Un(m)=ke(m)*e(k)-ku(m,:)*deltaup';
        
    end
    
    mi(1)=1-1/(1+exp(-d*(Y(k)-c(1)))); %j=1      
    for j=2:n-1
        mi(j)=1/(1+exp(-d*(Y(k)-c(j-1))))-1/(1+exp(-d*(Y(k)-c(j))));%j=2:n-1
    end
    mi(n)=1/(1+exp(-d*(Y(k)-c(n-1)))); %j=n
    
    
    deltauk=sum(Un*mi')/sum(mi);
    
    
    for i=D-1:-1:2
        deltaup(i)=deltaup(i-1);
    end
    
    
    if deltauk>dupmax
        deltauk = dupmax;
    elseif deltauk<dupmin
        deltauk = dupmin;
    end   
    
    
    deltaup(1)=deltauk;
    U(k)=U(k-1)+deltauk;
    
    if U(k)>Umax
        U(k)=Umax;
    elseif U(k)<Umin
        U(k)=Umin;
    end
    
end


if latex==true   
    figure
    plot(Y)
    title('y')
    hold on
    plot(Yzad,'r-')
end

E=sum((e).^2);
end