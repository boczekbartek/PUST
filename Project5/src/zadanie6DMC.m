function [ E ] = zadanie6DMC(D,N,Nu,lambda,mi)

D=round(D);
N=round(N);
Nu=round(Nu);

load('odp/odp_skokU1Y1.txt');
load('odp/odp_skokU1Y2.txt');
load('odp/odp_skokU1Y3.txt');
load('odp/odp_skokU2Y1.txt');
load('odp/odp_skokU2Y2.txt');
load('odp/odp_skokU2Y3.txt');
load('odp/odp_skokU3Y1.txt');
load('odp/odp_skokU3Y2.txt');
load('odp/odp_skokU3Y3.txt');
load('odp/odp_skokU4Y1.txt');
load('odp/odp_skokU4Y2.txt');
load('odp/odp_skokU4Y3.txt');

s11=odp_skokU1Y1(1:D,2);
s12=odp_skokU2Y1(1:D,2);
s13=odp_skokU3Y1(1:D,2);
s14=odp_skokU4Y1(1:D,2);
s21=odp_skokU1Y2(1:D,2);
s22=odp_skokU2Y2(1:D,2);
s23=odp_skokU3Y2(1:D,2);
s24=odp_skokU4Y2(1:D,2);
s31=odp_skokU1Y3(1:D,2);
s32=odp_skokU2Y3(1:D,2);
s33=odp_skokU3Y3(1:D,2);
s34=odp_skokU4Y3(1:D,2);

czas=900;

NY=3;
NU=4;

y=zeros(NY,czas);
yzad=zeros(NY,czas);

yzad(1,10:czas)=9;
yzad(1,310:czas)=11;
yzad(1,610:czas)=1;

yzad(2,110:czas)=10;
yzad(2,410:czas)=4;
yzad(2,710:czas)=8;

yzad(3,210:czas)=2;
yzad(3,510:czas)=5;
yzad(3,810:czas)=0;


u=zeros(NU,czas);
du=zeros(NU,czas);
dUP=zeros((D-1)*NU,1);

M=cell(N,Nu);

for i=1:N
   for j=1:Nu
      if (i>=j)
         M(i,j)={[s11(i-j+1) s12(i-j+1) s13(i-j+1) s14(i-j+1);...
             s21(i-j+1) s22(i-j+1) s23(i-j+1) s24(i-j+1);...
             s31(i-j+1) s32(i-j+1) s33(i-j+1) s34(i-j+1)]};
      else
          M(i,j)={zeros(NY,NU)};
      end% subplot(245)
% stairs(y(1,:));
% title({['błąd E= ',num2str(E)];['E1 = ',num2str(e1)];['mi = ', num2str(mi(1))]})
% hold on;
% stairs(yzad(1,:),'--')
% legend('Y1(k)','Y_z_a_d_1(k)');
% xlabel('k')
% ylabel('Y1(k)')
% 
% subplot(246)
% stairs(y(2,:));
% title({['błąd E= ',num2str(E)];['E2 = ',num2str(e2)];['mi = ', num2str(mi(2))]})
% hold on;
% stairs(yzad(2,:),'--')
% legend('Y2(k)','Y_z_a_d_2(k)');
% xlabel('k')
% ylabel('Y2(k)')
% 
% subplot(247)
% stairs(y(3,:));
% title({['błąd E= ',num2str(E)];['E3 = ',num2str(e3)];['mi = ', num2str(mi(3))]})
% hold on;
% stairs(yzad(3,:),'--')
% legend('Y3(k)','Y_z_a_d_3(k)');
% xlabel('k')
% ylabel('Y3(k)')
   end
end
M=cell2mat(M);
MP=cell(N,D-1);
for i=1:N
   for j=1:D-1
      if i+j<=D
         MP(i,j)={[s11(i+j)-s11(j) s12(i+j)-s12(j) s13(i+j)-s13(j) s14(i+j)-s14(j);...
             s21(i+j)-s21(j) s22(i+j)-s22(j) s23(i+j)-s23(j) s24(i+j)-s24(j);...
             s31(i+j)-s31(j) s32(i+j)-s32(j) s33(i+j)-s33(j) s34(i+j)-s34(j)]};
      else
         MP(i,j)={[s11(D)-s11(j) s12(D)-s12(j) s13(D)-s13(j) s14(D)-s14(j);...
             s21(D)-s21(j) s22(D)-s22(j) s23(D)-s23(j) s24(D)-s24(j);...
             s31(D)-s31(j) s32(D)-s32(j) s33(D)-s33(j) s34(D)-s34(j)]};
      end      
   end
end
MP=cell2mat(MP);
Lambda=cell(Nu,Nu);
for i=1:Nu
    for j=1:Nu
        if i==j
            Lambda(i,j)={diag(lambda)};
        else
            Lambda(i,j)={zeros(NU,NU)};
        end
    end
end
Lambda=cell2mat(Lambda);
MI=cell(N,N);
for i=1:N
    for j=1:N
        if i==j
            MI(i,j)={diag(mi)};
        else
            MI(i,j)={zeros(NY,NY)};
        end
    end
end

MI=cell2mat(MI);

K=(M'*MI*M+Lambda)^(-1)*M'*MI;

K1=K(1:NU,:);

ku=K1*MP;

ke=zeros(4,3);

ke(1,1)=sum(K(1,1:3:(N*NY)));
ke(1,2)=sum(K(1,2:3:(N*NY)));
ke(1,3)=sum(K(1,3:3:(N*NY)));
ke(2,1)=sum(K(2,1:3:(N*NY)));
ke(2,2)=sum(K(2,2:3:(N*NY)));
ke(2,3)=sum(K(2,3:3:(N*NY)));
ke(3,1)=sum(K(3,1:3:(N*NY)));
ke(3,2)=sum(K(3,2:3:(N*NY)));
ke(3,3)=sum(K(3,3:3:(N*NY)));
ke(4,1)=sum(K(4,1:3:(N*NY)));
ke(4,2)=sum(K(4,2:3:(N*NY)));
ke(4,3)=sum(K(4,3:3:(N*NY)));

for k=10:czas
    [y(1,k),y(2,k),y(3,k)]=symulacja_obiektu10...
        (u(1,k-1),u(1,k-2),u(1,k-3),u(1,k-4),...
        u(2,k-1),u(2,k-2),u(2,k-3),u(2,k-4),...
        u(3,k-1),u(3,k-2),u(3,k-3),u(3,k-4),...
        u(4,k-1),u(4,k-2),u(4,k-3),u(4,k-4),...
        y(1,k-1),y(1,k-2),y(1,k-3),y(1,k-4),...
        y(2,k-1),y(2,k-2),y(2,k-3),y(2,k-4),...
        y(3,k-1),y(3,k-2),y(3,k-3),y(3,k-4));
    
    du(:,k)=ke*(yzad(:,k)-y(:,k))-ku*dUP;
    
    for i=((D-1)*NU):-4:8
      dUP(i)=dUP(i-4);
      dUP(i-1)=dUP(i-5);
      dUP(i-2)=dUP(i-6);
      dUP(i-3)=dUP(i-7);
    
    end
    dUP(1:4)=du(:,k);
    u(:,k)=u(:,k-1)+du(:,k);
    
end

e=yzad-y;
e1=sum(e(1,:).^2);
e2=sum(e(2,:).^2);
e3=sum(e(3,:).^2);
E=e1+e2+e3;



savePlot(1:czas,u(1,:),'zad6dmc_U1.txt');
savePlot(1:czas,u(2,:),'zad6dmc_U2.txt');
savePlot(1:czas,u(3,:),'zad6dmc_U3.txt');
savePlot(1:czas,u(4,:),'zad6dmc_U4.txt');

savePlot(1:czas,y(1,:),'zad6_Y1.txt');
savePlot(1:czas,y(2,:),'zad6_Y2.txt');
savePlot(1:czas,y(3,:),'zad6_Y3.txt');

savePlot(1:czas,yzad(1,:),'zad6_Yzad1.txt');
savePlot(1:czas,yzad(2,:),'zad6_Yzad2.txt');
savePlot(1:czas,yzad(3,:),'zad6_Yzad3.txt');

savePlot(0,0,sprintf('zad6_blad_E_%f.txt',E));


%     
% subplot(241)
% stairs(u(1,:));
% title({'DMC ';['lambda = ', num2str(lambda(1))]});
% xlabel('k')
% ylabel(sprintf('u1(k)'))
% 
% subplot(242)
% stairs(u(2,:));
% title({'DMC ';['lambda = ', num2str(lambda(2))]});
% xlabel('k')
% ylabel(sprintf('u2(k)'))
% 
% subplot(243)
% stairs(u(3,:));
% title({'DMC ';['lambda = ', num2str(lambda(3))]});
% xlabel('k')
% ylabel(sprintf('u3(k)'))
% 
% subplot(244)
% plot(u(4,:));
% title({'DMC ';['lambda = ', num2str(lambda(4))]});
% xlabel('k')
% ylabel(sprintf('u4(k)'))
% 
% subplot(245)
% stairs(y(1,:));
% title({['błąd E= ',num2str(E)];['E1 = ',num2str(e1)];['mi = ', num2str(mi(1))]})
% hold on;
% stairs(yzad(1,:),'--')
% legend('Y1(k)','Y_z_a_d_1(k)');
% xlabel('k')
% ylabel('Y1(k)')
% 
% subplot(246)
% stairs(y(2,:));
% title({['błąd E= ',num2str(E)];['E2 = ',num2str(e2)];['mi = ', num2str(mi(2))]})
% hold on;
% stairs(yzad(2,:),'--')
% legend('Y2(k)','Y_z_a_d_2(k)');
% xlabel('k')
% ylabel('Y2(k)')
% 
% subplot(247)
% stairs(y(3,:));
% title({['błąd E= ',num2str(E)];['E3 = ',num2str(e3)];['mi = ', num2str(mi(3))]})
% hold on;
% stairs(yzad(3,:),'--')
% legend('Y3(k)','Y_z_a_d_3(k)');
% xlabel('k')
% ylabel('Y3(k)')

end