function [ E ] = zadanie3PID( K,Ti,Td,regs)
Tp=0.5;
czas=900;


r0=zeros(1,3);
r1=zeros(1,3);
r2=zeros(1,3);

for i=1:3
    r0(i)=K(i)*(1+Tp/(2*Ti(i))+Td(i)/Tp);
    r1(i)=K(i)*(Tp/(2*Ti(i))-2*Td(i)/Tp-1);
    r2(i)=K(i)*Td(i)/Tp;
end

u=zeros(4,czas);
y=zeros(3,czas);

e=zeros(3,czas);

yzad=y;

yzad(1,10:czas)=9;
yzad(1,310:czas)=11;
yzad(1,610:czas)=1;

yzad(2,110:czas)=10;
yzad(2,410:czas)=4;
yzad(2,710:czas)=8;

yzad(3,210:czas)=2;
yzad(3,510:czas)=5;
yzad(3,810:czas)=0;

for k=5:czas
    [y(1,k),y(2,k),y(3,k)]=symulacja_obiektu10...
        (u(1,k-1),u(1,k-2),u(1,k-3),u(1,k-4),...
        u(2,k-1),u(2,k-2),u(2,k-3),u(2,k-4),...
        u(3,k-1),u(3,k-2),u(3,k-3),u(3,k-4),...
        u(4,k-1),u(4,k-2),u(4,k-3),u(4,k-4),...
        y(1,k-1),y(1,k-2),y(1,k-3),y(1,k-4),...
        y(2,k-1),y(2,k-2),y(2,k-3),y(2,k-4),...
        y(3,k-1),y(3,k-2),y(3,k-3),y(3,k-4));
    
    e(:,k)=yzad(:,k)-y(:,k);
    
    u(regs(1),k)=r2(1)*e(2,k-2)+r1(1)*e(2,k-1)+r0(1)*e(2,k)+u(regs(1),k-1);
    u(regs(2),k)=r2(2)*e(3,k-2)+r1(2)*e(3,k-1)+r0(2)*e(3,k)+u(regs(2),k-1);
    u(regs(3),k)=r2(3)*e(1,k-2)+r1(3)*e(1,k-1)+r0(3)*e(1,k)+u(regs(3),k-1);
end

e1=sum(e(1,:).^2);
e2=sum(e(2,:).^2);
e3=sum(e(3,:).^2);

E=e1+e2+e3;

savePlot(1:czas,u(regs(1),:),'zad4_U1_e1_na_u3_e3_na_u2_e2_na_u1.txt');
savePlot(1:czas,u(regs(2),:),'zad4_U2_e1_na_u3_e3_na_u2_e2_na_u1.txt');
savePlot(1:czas,u(regs(3),:),'zad4_U3_e1_na_u3_e3_na_u2_e2_na_u1.txt');

savePlot(1:czas,y(1,:),'zad4_Y1_e1_na_u3_e3_na_u2_e2_na_u1.txt');
savePlot(1:czas,y(2,:),'zad4_Y2_e1_na_u3_e3_na_u2_e2_na_u1.txt');
savePlot(1:czas,y(3,:),'zad4_Y3_e1_na_u3_e3_na_u2_e2_na_u1.txt');
    
savePlot(1:czas,yzad(1,:),'zad4_Yzad1_e1_na_u3_e3_na_u2_e2_na_u1.txt');
savePlot(1:czas,yzad(2,:),'zad4_Yzad2_e1_na_u3_e3_na_u2_e2_na_u1.txt');
savePlot(1:czas,yzad(3,:),'zad4_Yzad3_e1_na_u3_e3_na_u2_e2_na_u1.txt');
    
savePlot(0,0,sprintf('zad4_blad_E_%f_e1_na_u3_e3_na_u2_e2_na_u1.txt',E));
% 
% 
% subplot(231)
% plot(u(regs(1),:));
% title({['Nastawy PID:K = ', num2str(K(1)), ', Ti = ', num2str(Ti(1)),', Td = ',num2str(Td(1))]});
% xlabel('k')
% ylabel(sprintf('u%d(k)',regs(1)))
%    
% subplot(232)
% plot(u(regs(2),:));
% title({['Nastawy PID:K = ', num2str(K(2)), ', Ti = ', num2str(Ti(2)),', Td = ',num2str(Td(2))]});
% xlabel('k')
% ylabel(sprintf('u%d(k)',regs(2)))
%     
% subplot(233)
% plot(u(regs(3),:));
% title({['Nastawy PID:K = ', num2str(K(3)), ', Ti = ', num2str(Ti(3)),', Td = ',num2str(Td(3))]});
% xlabel('k')
% ylabel(sprintf('u%d(k)',regs(3)))
%     
% subplot(234)
% plot(y(1,:));
% title({['bląd ',num2str(E)];['E1 = ',num2str(e1)]})
% hold on;
% stairs(yzad(1,:),'--')
% legend('Y1(k)','Y_z_a_d_1(k)');
% xlabel('k')
% ylabel('Y1(k)')
%     
% subplot(235)
% plot(y(2,:));
% title({['bląd E= ',num2str(E)];['E2 = ',num2str(e2)]})
% hold on;
% stairs(yzad(2,:),'--')
% legend('Y2(k)','Y_z_a_d_2(k)');
% xlabel('k')
% ylabel('Y2(k)')
%     
% subplot(236)
% plot(y(3,:));
% title({['bląd ',num2str(E)];['E3 = ',num2str(e3)]})
% hold on;
% stairs(yzad(3,:),'--')
% legend('Y3(k)','Y_z_a_d_3(k)');
% xlabel('k')
% ylabel('Y3(k)')



end