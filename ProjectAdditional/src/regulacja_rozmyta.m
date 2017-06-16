n = 50;

D=80;
Upp=0;
Ypp=0;
Umin=-1;
Umax=1;
dupmax = 0.1;
dupmin = -0.1;

kk=1410;
startk=10;

 load('OptymalizacjaGa_2proba_iter=50.mat')
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


xmin1 = -2.6;
xmax1 = 0;

xmin2 = 0;
xmax2 = 0.08;

Yzad(startk:210)=xmin1+rand*(xmax1-xmin1);
Yzad(210:310)=xmin2+rand*(xmax2-xmin2);
Yzad(310:410)=xmin1+rand*(xmax1-xmin1);
Yzad(410:510)=xmin2+rand*(xmax2-xmin2);
Yzad(510:610)=xmin1+rand*(xmax1-xmin1);
Yzad(610:810)=xmin2+rand*(xmax2-xmin2);
Yzad(810:910)=xmin1+rand*(xmax1-xmin1);
Yzad(90:1010)=xmin2+rand*(xmax2-xmin2);
Yzad(1010:1110)=xmin1+rand*(xmax1-xmin1);
Yzad(1110:1210)=xmin2+rand*(xmax2-xmin2);
Yzad(1210:1410)=xmin1+rand*(xmax1-xmin1);


deltaup=zeros(1,D-1);

Un=zeros(1,n);
mi=zeros(1,n);

d = 250 % "nachylenie" sigmoidy
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
figure
plot(Yzad)
hold on
plot(Y)
E=sum((e).^2);
