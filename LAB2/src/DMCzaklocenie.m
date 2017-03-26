
%params
wykresy = 0;
n = 2500; %dlugosc symulacji
sz=yaproksz;

skok = 5;
Yzad(1:skok) = Ypp;
Yzad(skok+1:n) = 40;

czyPomiar = 1;


Z(1:350)=0;
Z(351:500)=30;
Z(501:700)=10;

s = yaproks;

Ypp=31.5;
Upp=31;
Zpp=0;

Y(1:n) = Ypp;
U(1:n) = Upp;
u = U - Upp;
err = 0;

D=110; Dz=50;

%parametry regulatora dobrane eksperymentalnie
N=130.000000; Nu=6.000000; lambda=2;
for i=1:Dz
    dz(i)=0;
end
Zpom = Z;

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

Mz=zeros(N,Dz-1);
for i=1:N
    for j=1:Dz-1
        if i+j<=Dz
            Mz(i,j)=sz(i+j)-sz(j);
        else
            Mz(i,j)=sz(Dz)-sz(j);
        end;
    end;
end;
Mz = [sz(1:N)' Mz];
%podstawienie do wzoru reg. DMC
K=((M'*M+lambda*eye(Nu))^-1)*M';
Ku=K(1,:)*Mp;
Kz=K(1,:)*Mz;
Ke=sum(K(1,:));
addpath('F:\SerialCommunication'); % add a path to the functions
    initSerialControl COM4 % initialise com port
for i=skok:n
    
    Y(i)=MinimalWorkingExample(U(i-1),Z(i-1));
    e=Yzad(i)-Y(i);
    err = err + e^2;
    
    du=Ke*e-Ku*dup'; %reg
    
    
    if czyPomiar 
        du = du - Kz*dz';
        for n=Dz:-1:2
            dz(n)=dz(n-1);
        end
        dz(1)=Zpom(i)-Zpom(i-1);
    end
    for n=D-1:-1:2
        dup(n)=dup(n-1);
    end
    
    dup(1)=du;
    u(i)=u(i-1)+dup(1);
    
    U(i)=u(i)+Upp; %przesuniecie do punktu pracy
    if U(i)>100
        U(i)=100;
    elseif U(i) <0
        U(i)=0;
    end
    i
end

err