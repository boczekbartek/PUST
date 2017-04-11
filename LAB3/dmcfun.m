function [ E ] = dmcfun( param )
tmp = load('odp_skok.mat');
clear u;
clear U1;
clear U2;
clear Y1;
clear Y2;
D=200;
nu=2;
ny=2;
 
%Macierz odopowiedzi skokowych
for i=1:400
    S(i)={[tmp.s11(i) tmp.s12(i); tmp.s31(i) tmp.s32(i)]};
end
   
%Parametry dobrane eksperymentalnie
N=param(1); Nu=param(2); lambda1=param(3); lambda2=1;
 
%Punkty pracy
U1pp=0;
U2pp=0;
Y1pp=0;
Y2pp=0;
 
%Inicjalizacja macierzy i wektorów
 
%Macierz M
for i=1:Nu
    M(i:N,i)=S(1:N-i+1);
    M(1:i-1,i)={[0 0;0 0]};
end
 
%Macierz Mp
for i=1:(D-1)
    for j=1:N
        Mp{j,i}=S{j+i}-S{i};
    end
end
 
%Macierz Lambd
for i=1:Nu
    for j=1:Nu
        if i==j
            Lambda{i,j}=[lambda1 0; 0 lambda2];
        else
            Lambda{i,j}=[0 0; 0 0];
        end
    end
end
 
%Macierz K
Mt=M';
Mt_tmp = cell2mat(Mt);
M_tmp = cell2mat(M);
for i=1:Nu
    size(i)=2;
end
Temp_M = mat2cell(Mt_tmp*M_tmp,size,size); %Mno¿emie M'*M
for i=1:Nu
    for j=1:Nu
        A{i,j}=Temp_M{i,j}+Lambda{i,j}; %Dodanie Lambdy
    end
end
A_tmp = cell2mat(A);
A_odwrocone = mat2cell(A_tmp^(-1),size,size);%Odwrócenie macierzy
A_odwrocone_tmp = cell2mat(A_odwrocone);
for i=1:N
    size2(i)=2;
end
K = mat2cell(A_odwrocone_tmp*Mt_tmp,size,size2);%Przemno¿enie przez M'
 
 
dup=zeros(2,1);
for i=1:D-1
    dUp_mimo(i,1)={dup};
end
 
Y_zad_dmc=zeros(2,1);
for i=1:N
    Y_zad_mimo(i,1)={Y_zad_dmc};
end
 
Y_dmc=zeros(2,1);
for i=1:N
    Y_mimo(i,1)={Y_dmc};
end
 
for i=1:N
    Y0(i,1)={[0;0]};
end
 
du=zeros(2,1);
for i=1:Nu
    dU_mimo(i,1)={du};
end
 
 
n=1600; %Okres symulacji
U1(1:n)=U1pp;
U2(1:n)=U2pp;
Y1(1:n)=Y1pp;
Y2(1:n)=Y2pp;
Y1_zad(1:14)=Y1pp;
Y1_zad(15:400)=1;
Y1_zad(401:800)=1;
Y1_zad(801:1200)=1.5;
Y1_zad(1201:1600)=0.5;
Y2_zad(1:14)=Y2pp;
Y2_zad(15:400)=1;
Y2_zad(401:800)=0.5;
Y2_zad(801:1200)=1;
Y2_zad(1201:1600)=1.5;
u1=U1-U1pp;
u2=U2-U2pp;
y1_zad=Y1_zad-Y1pp;
y2_zad=Y2_zad-Y2pp;
y1(1:n)=0;
y2(1:n)=0;
Ey=zeros(2,n);
Eu=zeros(1,n);
 
for k=13:n
    Y1(k)=symulacja_Y1(Y1(k-1),Y1(k-2),U1(k-11),U1(k-12),U2(k-11),U2(k-12));
    Y2(k)=symulacja_Y3(Y2(k-1),Y2(k-2),U1(k-11),U1(k-12),U2(k-11),U2(k-12));
    y1(k)=Y1(k)-Y1pp;
    y2(k)=Y2(k)-Y2pp;
    Ey(1,k)=y1_zad(k)-y1(k);
    Ey(2,k)=y2_zad(k)-y2(k);
   
   
    Y_dmc(1)=y1(k);
    Y_dmc(2)=y2(k);
    for i=1:N
        Y_mimo(i,1)={Y_dmc};
    end
   
   
    Y_zad_dmc(1)=y1_zad(k);
    Y_zad_dmc(2)=y2_zad(k);
    for i=1:N
        Y_zad_mimo(i,1)={Y_zad_dmc};
    end
   
   
    %Wyliczanie Y0
    Mp_tmp = cell2mat(Mp);
    dUp_tmp = cell2mat(dUp_mimo);
    Temp_Y0 = mat2cell(Mp_tmp*dUp_tmp,size2,[1]); %Mno¿enie Mp*dUp
    for i=1:N
        Y0{i,1}=Y_mimo{i,1}+Temp_Y0{i,1}; %Dodawanie wyniku mno¿enia i Y
    end
 
   
    %Wyliczanie dU
    for i=1:N
        Temp_Y_zad{i,1}=Y_zad_mimo{i,1}-Y0{i,1}; %Odemowanie Y0 od Y zadanego
    end
    K_tmp = cell2mat(K);
    Y_zad_tmp = cell2mat(Temp_Y_zad);
    dU_mimo = mat2cell(K_tmp *Y_zad_tmp,size,[1]); %Mno¿enie Mp*dUp
   
 
    du=dU_mimo{1};
   
    for n=D-1:-1:2;
      dUp_mimo(n)=dUp_mimo(n-1);
    end
   
    u1(k)=u1(k-1)+du(1);
    u2(k)=u2(k-1)+du(2);
    dUp_mimo(1,1)={du};
   
    U1(k)=u1(k)+U1pp;  
    U2(k)=u2(k)+U2pp;
   
 
    Lambda_tmp = cell2mat(Lambda);
    dU_tmp = cell2mat(dU_mimo);
    Eu(k) = dU_tmp'*Lambda_tmp*dU_tmp; %Mno¿enie Mp*dUp
end
 
 
EY=norm(Ey)^2
EU=norm(Eu)^2
E=EY+EU;
 
figure;
subplot(2,2,1);
stairs(U1);
title('u(k)');
xlabel('k');
ylabel('u');
subplot(2,2,3);
stairs(Y1);
title('Y(k) i Y_z_a_d');
hold on;
stairs(Y1_zad, 'r');
xlabel('k');
legend('y','y_z_a_d','Location','southeast');
subplot(2,2,2);
stairs(U2);
title('u(k)');
xlabel('k');
ylabel('u');
subplot(2,2,4);
stairs(Y2);
title('Y(k) i Y_z_a_d');
hold on;
stairs(Y2_zad,'r');
xlabel('k');
legend('y','y_z_a_d','Location','southeast');
end

