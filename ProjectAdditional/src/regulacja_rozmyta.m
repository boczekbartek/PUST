
n = 50;

D=80;
Upp=0;
Ypp=0;
Umin=-1;
Umax=1;
dupmax = 0.1;
dupmin = -0.1;

kk=2210;
startk=10;

%�?adowanie parametrów ke i ku dla każdego z 50 regulatorów lokalnych wyliczonych poczas
%optymalizacji

load('OptymalizacjaGa_2proba_iter=50.mat')

% Liczenie zakreów każdego z 50 przedziałów przedziałów

Us = ones(1,50);
Ue = ones(1,50);
Us(1) = -1
Ue(1) = -0.98;
for m=0:47
  Us(m+2) = -0.98 + m*0.0408333333333333;
  Ue(m+2) = -0.98 + (m*0.0408333333333333) + 0.0408333333333333;
end
Us(50)=Ue(49);

U(1:kk)=Upp;
Y(1:kk)=Ypp;

e=zeros(1,kk);


%Losowe dobieranie 10 wartości zadanych
xmin1 = -2.6;
xmax1 = 0;

xmin2 = 0;
xmax2 = 0.08;

Yzad(startk:210)=xmin1+rand*(xmax1-xmin1);
Yzad(210:410)=xmin2+rand*(xmax2-xmin2);
Yzad(410:610)=xmin1+rand*(xmax1-xmin1);
Yzad(610:810)=xmin2+rand*(xmax2-xmin2);
Yzad(810:1010)=xmin1+rand*(xmax1-xmin1);
Yzad(1010:1210)=xmin2+rand*(xmax2-xmin2);
Yzad(1210:1410)=xmin1+rand*(xmax1-xmin1);
Yzad(1410:1610)=xmin2+rand*(xmax2-xmin2);
Yzad(1610:1810)=xmin1+rand*(xmax1-xmin1);
Yzad(1810:2010)=xmin2+rand*(xmax2-xmin2);
Yzad(2010:2210)=xmin1+rand*(xmax1-xmin1);


deltaup=zeros(1,D-1);

Un=zeros(1,n);
mi=zeros(1,n);

d = 500 % "nachylenie" sigmoidy
c = Us(2:50) % offsety każdej z sigmoid, granice przedziałów dla regulatorów lokalnych


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
figure('Position',  [403 246 820 420]);
subplot('Position', [0.1 0.12 0.8 0.15]);
stairs(U)
ylabel('u');
xlabel('k');
subplot('Position', [0.1 0.37 0.8 0.6]);
stairs(Y)
ylabel('y');
xlabel('k');
hold on
stairs(Yzad,':');
E=sum((e).^2);
