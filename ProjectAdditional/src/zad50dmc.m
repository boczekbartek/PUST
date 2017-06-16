
%aktualnie najlepsze: 
%p6DMC(12,1,[800 0.01 1 110],4,0.4,[-0.05 0.5 1.4],false)
%p6DMC(100,100,[510 25],2,0.2,[0.5],false)

%N skalar
%Nu skalar
%lambda wektor n liczb
%rozmiar lambdy, ilosc reg lokalnych
%d skalar? z r�wna� ni�ej wynika �e skalar, ale oni w optymalizatorze podawali wektor n liczb
%c wektor n-1 liczb

% close all
% 
% N=round(N);
% Nu=round(Nu);
% 
% % 
% % s1=load('skok_-1.000_-0.900.txt');
% % sn=load('skok_0.900_1.000.txt');
% s1 = odpowiedzi_skokowe(-1.000,-0.96);
% sn = odpowiedzi_skokowe(0.96,1);
% 
% 
% D=100;
% Upp=0;
% Ypp=0;
% Umin=-1;
% Umax=1;
% dupmax = 0.1;
% dupmin = -0.1;
% 
% %inicjalizacja sta?ych
% kk=1410;
% startk=10;
% 

%DMC
%----------------------------------------------------------------

%chyba rozumiem, tu trzeba podzielic odcinek -1:1 na 50 rownych(?) kawalkow
%z nich zebrac odpowiedzi skokowe w sensie skok z jednej granicy do drugiej
%i je wrzuci� do tych 50 dmck�w
clear all

% Liczenie zakreów przedziałów
Us = ones(1,50);
Ue = ones(1,50);
Us(1) = -1
Ue(1) = -0.98;
for m=0:47
  Us(m+2) = -0.98 + m*0.0408333333333333;
  Ue(m+2) = -0.98 + (m*0.0408333333333333) + 0.0408333333333333;
end
Us(50)=Ue(49);

for m=1:50
    Ustart = Us(m)
    Uend = Ue(m)
    tic; [ku(m,:),ke(m), e(m) ]=optymalizacja(Ustart,Uend);toc;
    e(m)
    save(sprintf("OptymalizacjaGa_2proba_iter=%d",m))
end

% 
% 
% 
% U(1:kk)=Upp;
% Y(1:kk)=Ypp;
% 
% e=zeros(1,kk);
% 
% 
% Yzad(1:startk)=Ypp;
% Yzad(startk:210)=0.08;
% Yzad(210:410)=0;
% Yzad(410:610)=-2.5;
% Yzad(610:810)=-1;
% Yzad(810:1010)=-0.05;
% Yzad(1010:1210)=-0.5;
% Yzad(1210:1410)=-1;
% 
% 
% deltaup=zeros(1,D-1);
% 
% Un=zeros(1,n);
% mi=zeros(1,n);
% 
% for k=7:kk
%     %symulacja obiektu
%     Y(k)= symulacja_obiektu10y(U(k-5),U(k-6),Y(k-1),Y(k-2));
%     %uchyb regulacji
%     e(k)=Yzad(k) - Y(k);
%     
%     for m=1:n
%         % n regulatorow, n praw regulacji
%         Un(m)=ke(m)*e(k)-ku(m,:)*deltaup';
%         
%     end
%     
%     mi(1)=1-1/(1+exp(-d*(Y(k)-c(1)))); %j=1      
%     for j=2:n-1
%         mi(j)=1/(1+exp(-d*(Y(k)-c(j-1))))-1/(1+exp(-d*(Y(k)-c(j))));%j=2:n-1
%     end
%     mi(n)=1/(1+exp(-d*(Y(k)-c(n-1)))); %j=n
%     
%     
%     
%     deltauk=sum(Un*mi')/sum(mi);
%     
%     
%     
%     for i=D-1:-1:2
%         deltaup(i)=deltaup(i-1);
%     end
%     
%     %pytanie o co mu chodzi�o z -0,1 <= du <= 0,1
%     %czy w sensie przyrostu wszystkich lokalnych po kolei czy ju�
%     %zsumowanych, mysl� �e to drugie, kurde komar mnie ugryz�
%     
%     if deltauk>0.1
%         deltauk = dupmax;
%     elseif deltauk<-0.1
%         deltauk = dupmin;
%     end   
%     
%     
%     deltaup(1)=deltauk;
%     U(k)=U(k-1)+deltauk;
%     
%     if U(k)>Umax
%         U(k)=Umax;
%     elseif U(k)<Umin
%         U(k)=Umin;
%     end
%     
%     
% end
% 
% 
% if latex==true   
%     figure
%     plot(Y)
%     title('y')
%     hold on
%     plot(Yzad,'r-')
% end
% 
% E=sum((e).^2);
