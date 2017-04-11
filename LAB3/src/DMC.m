clear all;
tmp = load('odp_skok.mat');

addpath('F:\SerialCommunication'); % add a path to the functions
initSerialControl COM17 % initialise com port

clear u;
clear U1;
clear U2;
clear Y1;
clear Y2;
D=200;
nu=2;
ny=2;
 
for i=1:400
    S(i)={[tmp.s11(i) tmp.s12(i); tmp.s31(i) tmp.s32(i)]};
end
   
N=80; Nu=30; lambda1=0.1; lambda2=1;
 
U1pp=31;
U2pp=36;
Y1pp=33.75;
Y2pp=36.62; 

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
            lambda{i,j}=[lambda1 0; 0 lambda2];
        else
            lambda{i,j}=[0 0; 0 0];
        end
    end
end

Mt=M';
Mt_tmp = cell2mat(Mt);
M_tmp = cell2mat(M);

for i=1:Nu
    size(i)=2;
end
Temp_M = mat2cell(Mt_tmp*M_tmp,size,size);
for i=1:Nu
    for j=1:Nu
        A{i,j}=Temp_M{i,j}+lambda{i,j}; 
    end
end

A_tmp = cell2mat(A);
A_odwrocone = mat2cell(A_tmp^(-1),size,size);
A_odwrocone_tmp = cell2mat(A_odwrocone);

for i=1:N
    size2(i)=2;
end
K = mat2cell(A_odwrocone_tmp*Mt_tmp,size,size2);
 
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
 
 
n=400;
U1(1:n)=U1pp;
U2(1:n)=U2pp;
Y1(1:n)=Y1pp;
Y2(1:n)=Y2pp;
Y1_zad(1:14)=Y1pp;
Y1_zad(15:400)=50;
% Y1_zad(401:800)=1;
% Y1_zad(801:1200)=1.5;
% Y1_zad(1201:1600)=0.5;
Y2_zad(1:14)=Y2pp;
Y2_zad(15:400)=50;
% Y2_zad(401:800)=0.5;
% Y2_zad(801:1200)=1;
% Y2_zad(1201:1600)=1.5;
u1=U1-U1pp;
u2=U2-U2pp;
y1_zad=Y1_zad-Y1pp;
y2_zad=Y2_zad-Y2pp;
y1(1:n)=0;
y2(1:n)=0;
Ey=zeros(2,n);
Eu=zeros(1,n);
 
for k=13:n
    k
    [Y1(k),Y2(k)]=MinimalWorkingExample(U1(k-1),U2(k-1));
    
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
   
   
    Mp_tmp = cell2mat(Mp);
    dUp_tmp = cell2mat(dUp_mimo);
    Temp_Y0 = mat2cell(Mp_tmp*dUp_tmp,size2,[1]);
    
    
    for i=1:N
        Y0{i,1}=Y_mimo{i,1}+Temp_Y0{i,1}; 
    end
 
    %Wyliczanie dU
    for i=1:N
        Temp_Y_zad{i,1}=Y_zad_mimo{i,1}-Y0{i,1}; 
    end
    
    K_tmp = cell2mat(K);
    Y_zad_tmp = cell2mat(Temp_Y_zad);
    dU_mimo = mat2cell(K_tmp *Y_zad_tmp,size,[1]);
   
 
    du=dU_mimo{1};
   
    for n=D-1:-1:2;
      dUp_mimo(n)=dUp_mimo(n-1);
    end
   
    u1(k)=u1(k-1)+du(1);
    u2(k)=u2(k-1)+du(2);
    dUp_mimo(1,1)={du};
   
    U1(k)=u1(k)+U1pp;  
    U2(k)=u2(k)+U2pp;
   
    if U1(k)>100
        U1(k)=100;
    end
    if U2(k)>100
        U2(k)=100;
    end
    if U1(k)<0
        U1(k)=0;
    end
    if U2(k)<0
        U2(k)=0;
    end
 
    Lambda_tmp = cell2mat(lambda);
    dU_tmp = cell2mat(dU_mimo);
    Eu(k) = dU_tmp'*Lambda_tmp*dU_tmp; 
    
end
