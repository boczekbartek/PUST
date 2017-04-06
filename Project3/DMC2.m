clear all;
odpowiedz_skokowa_DMC;
clear u;
clear U1;
clear U2;
clear Y1;
clear Y2;
D=135;
nu=2;
ny=2;

%Macierz odopowiedzi skokowych
for i=1:900
    S(i)={[s11(i) s12(i); s21(i) s22(i)]};
end
    
%Parametry dobrane eksperymentalnie
N=80; Nu=6; lambda1=0.2; lambda2=0; 

%Punkty pracy
U1pp=0;
U2pp=0;
Y1pp=0;
Y2pp=0;

%Inicjalizacja macierzy i wektorów

for i=1:Nu
    M(i:N,i)=S(1:N-i+1);
    M(1:i-1,i)={[0 0;0 0]};
end

for i=1:(D-1)
    for j=1:N
        Mp{j,i}=S{j+i}-S{i};
    end
end

for i=1:Nu
    for j=1:Nu
        if i==j
            Lambda{i,j}=[lambda1 0; 0 lambda2];
        else
            Lambda{i,j}=[0 0; 0 0];
        end
    end
end

Mt=M';
aa = cell2mat(Mt);
bb = cell2mat(M);
for i=1:Nu
    size(i)=2;
end
Temp_M = mat2cell(aa*bb,size,size);

for i=1:Nu
    for j=1:Nu
        A{i,j}=Temp_M{i,j}+Lambda{i,j};
    end
end
K=((permute(M,[1,2,4,3])*M+lambda*I)^(-1))*M';

dUp=zeros(D-1,1);
dZ=zeros(Dz,1);
Y0=zeros(N,1);
dU=zeros(Nu,1);
Y_zad_dmc=zeros(N,1);
Y_dmc=zeros(N,1);

n=150; %Okres symulacji
U(1:n)=Upp;
Y(1:n)=Ypp;
Y_zad(1:9)=Ypp;
Y_zad(10:n)=1;
u=U-Upp;
y_zad=Y_zad-Ypp;
y(1:n)=0;
e(1:n)=0;


    
for k=10:n
    Y(k)=symulacja_obiektu10y(U(k-6),U(k-7),Z(k-1),Z(k-2),Y(k-1),Y(k-2));
    y(k)=Y(k)-Ypp;
    e(k)=y_zad(k)-y(k); %Uchyb
    
    Y_dmc(1:N,1)=y(k);
    Y_zad_dmc(1:N,1)=y_zad(k);
    
    Y0=Y_dmc+Mp*dUp+Mz*dZ;
    dU=K*(Y_zad_dmc-Y0);
    du=dU(1);
    
    for n=D-1:-1:2;
      dUp(n)=dUp(n-1);
    end
   
    u(k)=u(k-1)+du;
    dUp(1)=u(k)-u(k-1);
    
    U(k)=u(k)+Upp;  
    
    dz=Zpom(k)-Zpom(k-1);
    for n=Dz:-1:2;
      dZ(n)=dZ(n-1);
    end
    dZ(1)=dz;
end
 
E=(norm(e))^2; %WskaŸnik jakoœci regulacji

subplot(3,1,1);
stairs(U);
title('u(k)');
xlabel('k');
ylabel('u');
subplot(3,1,2);
stairs(Z);
title('Z(k)');
xlabel('k');
ylabel('Z');
subplot(3,1,3);
stairs(Y);
title('Y(k) i Y_z_a_d');
hold on;
stairs(Y_zad);
xlabel('k');
legend('y','y_z_a_d','Location','southeast');

figure
stairs(Zpom);
title('Pomiar zak³óceñ');
xlabel('k');
ylabel('Zpom');