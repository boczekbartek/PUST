function [E]=zad50dmc(N,Nu,lambda,n,d,c,latex)

%aktualnie najlepsze: 
%p6DMC(12,1,[800 0.01 1 110],4,0.4,[-0.05 0.5 1.4],false)
%p6DMC(100,100,[510 25],2,0.2,[0.5],false)

%N skalar
%Nu skalar
%lambda wektor n liczb
%rozmiar lambdy, ilosc reg lokalnych
%d skalar? z równañ ni¿ej wynika ¿e skalar, ale oni w optymalizatorze podawali wektor n liczb
%c wektor n-1 liczb

close all

N=round(N);
Nu=round(Nu);


load('p2/z2_y21.txt')

s1=load('skok_-1.000_-0.900.txt');
sn=load('skok_0.900_1.000.txt');

D=100;
Upp=0;
Ypp=0;
Umin=-1;
Umax=1;
dupmax = 0.1;
dupmin = -0.1;

%inicjalizacja sta?ych
kk=1410;
startk=10;


%DMC
%----------------------------------------------------------------

M=zeros(N,Nu);
MP=zeros(N,D-1);
I=eye(Nu);
ku=zeros(n,D-1);
ke=zeros(1,n);

%chyba rozumiem, tu trzeba podzielic odcinek -1:1 na 50 rownych(?) kawalkow
%z nich zebrac odpowiedzi skokowe w sensie skok z jednej granicy do drugiej
%i je wrzuciæ do tych 50 dmcków
for m=1:n
    if m==1
        s=s1(:,2);
    elseif m==n
        s=sn(:,2);
    elseif m==2 && n==3
        stemp=load('skok_-0.089_0.502.txt');
        s=stemp(:,2);
    elseif m==2 && n==4
        stemp=load('skok_-0.089_0.293.txt');
        s=stemp(:,2);
    elseif m==3 && n==4
        stemp=load('skok_0.293_0.502.txt');
        s=stemp(:,2);
    elseif m==2 && n==5
        stemp=load('skok_-0.089_0.194.txt');
        s=stemp(:,2);
    elseif m==3 && n==5
        stemp=load('skok_0.194_0.377.txt');
        s=stemp(:,2);
    elseif m==4 && n==5
        stemp=load('skok_0.377_0.502.txt');
        s=stemp(:,2);
    end
    
%     s=z2_y21(16:115,2);
    
    
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
Yzad(startk:210)=5;
Yzad(210:410)=2;
Yzad(410:610)=4;
Yzad(610:810)=-0.15;
Yzad(810:1010)=-0.05;
Yzad(1010:1210)=-0.1;
Yzad(1210:1410)=1;


deltaup=zeros(1,D-1);

Un=zeros(1,n);
mi=zeros(1,n);

for k=7:kk
    %symulacja obiektu
    Y(k)= symulacja_obiektu10y(U(k-5),U(k-6),Y(k-1),Y(k-2));
    %uchyb regulacji
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
    
    %pytanie o co mu chodzi³o z -0,1 <= du <= 0,1
    %czy w sensie przyrostu wszystkich lokalnych po kolei czy ju¿
    %zsumowanych, myslê ¿e to drugie, kurde komar mnie ugryz³
    
    if deltauk>0.1
        deltauk = dupmax;
    elseif deltauk<-0.1
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