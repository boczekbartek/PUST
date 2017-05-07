clear all;
%trapezowa funkcja przynależności
reg = 1;
switch reg
    case 1
    fun_przyn_u = [-1 -0.9 0.9 1];
    K=[0.3436];
    Ti=[2.8505];
    Td=[1.4081];
    case 2
    fun_przyn_u = [-1 -0.8 -0.2 0;...
            -0.2 0 0.8 1];
    K=[0.236074346765094 2.119341053294471];
    Ti=[2.712423338747892 1.225434499466258];
    Td=[1.165267525969138 1.169255514047720];
    case 3
    fun_przyn_u = [-1 -0.9 -0.5 -0.4;...
            -0.5 -0.4 0.1 0.2;...
            0.1 0.2 0.9 1];
    K=[0.184191046206899 0.526945980614740 6.936702368074447];
    Ti=[3.019939621456754 1.690264806274904 1.682131608109330];
    Td=[1.102810865603896 1.401837006870894 0.731492676395807];
    case 4
    fun_przyn_u = [-1 -0.9 -0.7 -0.6;...
            -0.7 -0.6 -0.3 -0.2;...
            -0.3 -0.2 -0.1 0;...
            -0.1 0 0.9 1];
    K=[0.284805037600209 0.263399392871782 0.616535779398403 2.188495952296820];
    Ti=[7.153989310096324 2.339516970484602 1.785569364828090 1.190026936406923];
    Td=[0.860715082421421 1.230389746188475 1.038805140244123 1.178916386966221];
    case 5
    fun_przyn_u = [-1 -0.9 -0.6 -0.5;...
            -0.6 -0.5 -0.4 -0.35;...
            -0.4 -0.35 -0.2 -0.15;...
            -0.2 -0.15 0 0.1;...
            0 0.1 0.9 1];
    K=[0.186576169125857 0.261733642811459 0.396620532198911 0.898145623120098 4.150669447340058];
    Ti=[3.092188071652959 2.297931336434997 1.980069479944584 1.734460931166978 1.393564071620474];
    Td=[1.167918512492445 1.313379515549692 1.154836703669959 0.964582475205146 0.946642218471555];
end

fun_przyn_y = arrayfun(@char_stat_fun,fun_przyn_u); %map fun_przyn_u => charstatfun

n = 1000;
Yzad(1:n) = 0;
Yzad(21:n) = -1;
Yzad(201:n)= -0.2;
Yzad(401:n)= -2;
Yzad(601:n)=0.08;
Yzad(801:n)=-1.5;
U(1:n) = 0;
Y(1:n) = 0;
err = 0;
Ts(1:reg) = 0.5;

r2 = K.*Td./Ts; r1 = K.*(Ts./(2.*Ti)-2.*Td./Ts - 1); r0 = K.*(1+Ts./(2.*Ti) + Td./Ts);

mi = zeros(1,reg);

for k=21:n
    
     Y(k)=symulacja_obiektu10y(U(k-5), U(k-6), Y(k-1), Y(k-2));
     e(k)=Yzad(k)-Y(k);

     for i = 1:reg
        mi(i) = trapmf(Y(k),fun_przyn_y(i,:));
     end
     du = sum(mi.*(r2*e(k-2)+r1*e(k-1)+r0*e(k)));

     U(k)=du+U(k-1);

     if U(k)>1
         U(k) = 1;
     end
     if U(k)<-1
         U(k) = -1;
     end
end;

err = sum(e.^2)

figure('Position',  [403 246 820 420]);
subplot('Position', [0.1 0.12 0.8 0.15]);
stairs(U);
ylabel('u');
xlabel('k');
subplot('Position', [0.1 0.37 0.8 0.6]);
stairs(Y);
ylabel('y');
hold on;
stairs(Yzad,':');
% savePlot(1:n,U,'zad5_U_5_reg.txt');
% savePlot(1:n,Y,'zad5_Y_5_reg.txt');
