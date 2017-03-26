clear all
odpSkok
Ypp=30.87;
Upp=28;

n = 1000; %dlugosc symulacji
skok = 12;
Yzad(1:skok) = Ypp;
Yzad(skok+1:500) = 40;
Yzad(501:n) = 32;


% Z=zeros(1,n);
Y(1:n) = Ypp; %inicjalizacje tablic
U(1:n) = Upp;
u = U - Upp;
err = 0;

yzad = Yzad-Ypp;

y=Y-Ypp;
%parametry regulatora dobrane eksperymentalnie
D=300;
% N=85; Nu=2.000000; lambda=0.2;
% N=108.000000; Nu=8.000000; lambda=0.010000; %110
D=300;N=130.000000; Nu=6.000000; lambda=0.010000; %300
% N=130.000000; Nu=6.000000; lambda=0.010002; %250
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

% Mz=zeros(N,Dz-1);
% for i=1:N
%     for j=1:Dz-1
%         if i+j<=Dz
%             Mz(i,j)=sz(i+j)-sz(j);
%         else
%             Mz(i,j)=sz(Dz)-sz(j);
%         end;
%     end;
% end;
% Mz = [sz(1:N) Mz];
%przeksztalcanie wyliczonych macierzy do potrzebnych nam parametrow

K=((M'*M+lambda*eye(Nu))^-1)*M';
Ku=K(1,:)*Mp;
% Kz=K(1,:)*Mz;
Ke=sum(K(1,:));

for i=skok+1:n
    
    y(i)=aproksymacjaObiektu(u(i-11),u(i-12),y(i-1),y(i-2));
    
    e=yzad(i)-y(i); %uchyb
    err = err + e^2;
    
    du=Ke*e-Ku*dup'; %regulator
    for n=D-1:-1:2
        dup(n)=dup(n-1);
    end
    dup(1)=du;
    u(i)=u(i-1)+dup(1);
    
    U(i)=u(i)+Upp;%przesuniecie do punktu pracy
   
    %ograniczenia
    if U(i)>100
        U(i)=100;
    elseif U(i) <0
        U(i)=0;
    end
end
Y = y+Ypp;
figure
stairs(Yzad);
hold on 
stairs(y+Ypp);
hold off
figure 
stairs(U);

err

n=1000

nazwa = strcat('zadanie5_DMC_Yzad.txt');
savePlot(1:1:n,Yzad,nazwa);
nazwa = strcat('zadanie5_DMC_U.txt');
savePlot(1:1:n,U,nazwa);
nazwa = strcat('zadanie5_DMC_Y.txt');
savePlot(1:1:n,Y,nazwa);
