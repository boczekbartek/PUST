function E = aproks(X)
T1=X(1);
T2=X(2);
K=X(3);
Td=10;
y(1:350)=0;
u(1:350)=1;

tmp = load('zmienne.mat');
Yskok = tmp.Yz;
Ypp=ones(1,350)*30.81;
OdpSkok = (Yskok-Ypp)/22;
stairs(OdpSkok);
nazwa = strcat('odp_skokowa.txt');
savePlot(1:1:350,OdpSkok,nazwa);
alpha1 = exp(-1/T1);
alpha2 = exp(-1/T2);
a1 = -alpha1-alpha2;
a2 = alpha1*alpha2;
b1 = K*(T1*(1- alpha1)-T2*(1-alpha2))/(T1-T2);
b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);

for k = Td+3:350
y(k) = b1*u(k - Td -1)+b2*u(k-Td-2)-a1*y(k-1)- a2*y(k-2);
end
hold on

 stairs(y)
 nazwa = strcat('funkcja_aproksymujaca.txt');
savePlot(1:1:350,y,nazwa);
e = OdpSkok' - y;
E=(norm(e))^2;
end