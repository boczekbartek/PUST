clear all
%Punkty pracy
U1pp=0;
U2pp=0;
Y1pp=0;
Y2pp=0;

szum(1:1600) = 0;
snr = 75;
szum1 = awgn(szum,snr);
szum2 = awgn(szum,snr);
K1=0.110346; Ti1=7.651625; Td1=1.748742; Ts=0.5;
K2=0.050791; Ti2=4.007075; Td2=2.908946; Ts=0.5;

%Nastawy dla 1 regulatora
% K1=params(1); Ti1=params(2); Td1=params(3); Ts=0.5; %wartoúÊ krytyczna
r12 = K1*Td1/Ts;
r11 = K1*(Ts/(2*Ti1)-2*Td1/Ts - 1);
r10 = K1*(1+Ts/(2*Ti1) + Td1/Ts);
 
%Nastawy dla 2 regulatora
% K2=params(4); Ti2=params(5); Td2=params(6); Ts=0.5; %wartoúÊ krytyczna
r22 = K2*Td2/Ts;
r21 = K2*(Ts/(2*Ti2)-2*Td2/Ts - 1);
r20 = K2*(1+Ts/(2*Ti2) + Td2/Ts);
 
n=1600; %Okres symulacji
U1(1:n)=U1pp;
U2(1:n)=U2pp;
Y1(1:n)=Y1pp;
Y2(1:n)=Y2pp;
Y1_zad(1:14)=Y1pp;
Y1_zad(15:n)=1;
Y1_zad(401:800)=3;
Y1_zad(801:1200)=1.5;
Y1_zad(1201:1600)=0.5;
 
 
Y2_zad(1:14)=Y2pp;
Y2_zad(15:n)=1;
Y2_zad(401:800)=0.5;
Y2_zad(801:1200)=1;
Y2_zad(1201:1600)=1.5;

u1=U1-U1pp;
u2=U1-U2pp;
y1_zad=Y1_zad-Y1pp;
y2_zad=Y2_zad-Y2pp;
y1(1:n)=0;
y2(1:n)=0;
e1(1:n)=0;
e2(1:n)=0;

for k=9:n    
    Y1(k)=symulacja_obiektu10y1(U1(k-7),U1(k-8),U2(k-3),U2(k-4),Y1(k-1),Y1(k-2))+szum1(k);
    Y2(k)=symulacja_obiektu10y2(U1(k-5),U1(k-6),U2(k-4),U2(k-5),Y2(k-1),Y2(k-2))+szum2(k);
    y1(k)=Y1(k)-Y1pp;
    y2(k)=Y2(k)-Y2pp;
    e1(k)=y1_zad(k)-y1(k); %Uchyb
    e2(k)=y2_zad(k)-y2(k); %Uchyb
    %wersja 1
%     du1=r12*e1(k-2)+r11*e1(k-1)+r10*e1(k); %1 regulator PID
%     du2=r22*e2(k-2)+r21*e2(k-1)+r20*e2(k); %2 regulator PID
    %wersja 2
    du1=r12*e2(k-2)+r11*e2(k-1)+r10*e2(k); %1 regulator PID
    du2=r22*e1(k-2)+r21*e1(k-1)+r20*e1(k); %2 regulator PID
    
    u1(k)=u1(k-1)+du1;
    u2(k)=u2(k-1)+du2;
    
  
    
    U1(k)=u1(k)+U1pp;
    U2(k)=u2(k)+U2pp;
    
    if U1(k)>100
        U1(k)=100;
    end
    if U2(k)>100
        U2(k)=100;
    end
end
 
E1=(norm(e1))^2; %Wskaünik jakoúci regulacji
E2=(norm(e2))^2; %Wskaünik jakoúci regulacji
E =E1+E2
E1;
E2;
nazwa = strcat('sprawozdanie/wykresy/zadanie6_PID_V2_E1_snr_75.txt');
savePlot(1:1:1600,e1,nazwa);
nazwa = strcat('sprawozdanie/wykresy/zadanie6_PID_V2_E2_snr_75.txt');
savePlot(1:1:1600,e2,nazwa);
nazwa = strcat('sprawozdanie/wykresy/zadanie6_PID_V2_U1_snr_75.txt');
savePlot(1:1:1600,U1,nazwa);
nazwa = strcat('sprawozdanie/wykresy/zadanie6_PID_V2_Y1_zad_snr_75.txt');
savePlot(1:1:1600,Y1_zad,nazwa);
nazwa = strcat('sprawozdanie/wykresy/zadanie6_PID_V2_Y1_snr_75.txt');
savePlot(1:1:1600,Y1,nazwa);
nazwa = strcat('sprawozdanie/wykresy/zadanie6_PID_V2_U2_snr_75.txt');
savePlot(1:1:1600,U2,nazwa);
nazwa = strcat('sprawozdanie/wykresy/zadanie6_PID_V2_Y2_zad_snr_75.txt');
savePlot(1:1:1600,Y2_zad,nazwa);
nazwa = strcat('sprawozdanie/wykresy/zadanie6_PID_V2_Y2_snr_75.txt');
savePlot(1:1:1600,Y2,nazwa);
nazwa = strcat('sprawozdanie/wykresy/zadanie6_PID_V2_zaszumienie_Y1_snr_75.txt');
savePlot(1:1:1600,szum1,nazwa);
nazwa = strcat('sprawozdanie/wykresy/zadanie6_PID_V2_zaszumienie_Y2_snr_75.txt');
savePlot(1:1:1600,szum2,nazwa);
figure;


subplot(3,2,1);
stairs(U1);
title('u1(k)');
xlabel('k');
ylabel('u1');
subplot(3,2,3);
stairs(Y1);
title('Y1(k) i Y1_z_a_d');
hold on;
stairs(Y1_zad, 'r');
xlabel('k');
legend('y1','y1_z_a_d','Location','southeast');
subplot(3,2,2);
stairs(U2);
title('u2(k)');
xlabel('k');
ylabel('u2');
subplot(3,2,4);
stairs(Y2);
title('Y2(k) i Y2_z_a_d');
hold on;
stairs(Y2_zad,'r');
xlabel('k');
legend('y2','y2_z_a_d','Location','southeast');
subplot(3,2,5);
stairs(e1);
title('e1(k)');
xlabel('k');
ylabel('e1');
subplot(3,2,6);
stairs(e2);
title('e2(k)');
xlabel('k');
ylabel('e2');
