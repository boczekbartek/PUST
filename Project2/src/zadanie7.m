clear all
zadanie3;
s=su;
%params
wykresy=1;
n = 2500; %dlugosc symulacji

Yzad(1:20) = 0;
Yzad(21:1000) = 1.6;
Yzad(1001:1500)=1.4;
Yzad(1501:n)=2.5;

czyPomiar = 1;
czySzum = 1; 
snr = 25;

Z=zeros(1,n);
Z(160:800) = 1;
Z(1040:1200) = 1;
Z(1640:2000) = 1;
Z(2290:n)=1;

Ypp=0;
Upp=0;
Zpp=0;

Y(1:n) = Ypp;
U(1:n) = Upp;
u = U - Upp;
err = 0;

D=110; Dz=50;

%parametry regulatora dobrane eksperymentalnie
N=130.000000; Nu=6.000000; lambda=0.920000;
for i=1:Dz
    dz(i)=0;
end
Zp = Z;

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
Mz = [sz(1:N) Mz];
%podstawienie do wzoru reg. DMC
K=((M'*M+lambda*eye(Nu))^-1)*M';
Ku=K(1,:)*Mp;
Kz=K(1,:)*Mz;
Ke=sum(K(1,:));

Zp = Z;

%szumimy sygna³ z czujnika bia³ym szumem o sta³ej wartoœci widma
if czySzum
    Zp = awgn(Zp,snr); 
end

for i=21:n
    
    Y(i)=symulacja_obiektu6y(U(i-6), U(i-7), Z(i-3) , Z(i-4), Y(i-1), Y(i-2));
    e=Yzad(i)-Y(i);
    err = err + e^2;
    
    du=Ke*e-Ku*dup'; %reg
    
    
    if czyPomiar 
        
        du = du - Kz*dz';
        for n=Dz:-1:2
            dz(n)=dz(n-1);
        end
        dz(1)=Zp(i)-Zp(i-1);
        
    end
    
    for n=D-1:-1:2
        dup(n)=dup(n-1);
    end
    
    dup(1)=du;
    u(i)=u(i-1)+dup(1);
    
    U(i)=u(i)+Upp; %przesuniecie do punktu pracy
    
end

err

figure('Position',  [403 246 820 420]);
title('obiekt z regulatorem DMC');
subplot('Position', [0.1 0.12 0.8 0.15]);
stairs(U);
ylabel('u');
xlabel('k');

subplot('Position', [0.1 0.37 0.8 0.6]);
plot(Y);
ylabel('y');

hold on;
stairs(Yzad,':');
if wykresy
    if czyPomiar && czySzum
        nazwa = strcat('../wykresy/zadanie7_pomiar_DMC_Yzad_snr=',num2str(snr),'skok_z.txt');
        savePlot(1:1:2500,Yzad,nazwa);
        nazwa = strcat('../wykresy/zadanie7_pomiar_DMC_U_snr=',num2str(snr),'skok_z.txt');
        savePlot(1:1:2500,U,nazwa);
        nazwa = strcat('../wykresy/zadanie7_pomiar_DMC_Y_snr=',num2str(snr),'skok_z.txt');
        savePlot(1:1:2500,Y,nazwa);
        nazwa = strcat('../wykresy/zadanie7_pomiar_DMC_Z_snr=',num2str(snr),'skok_z.txt');
        savePlot(1:1:2500,Z,nazwa);
    end
end