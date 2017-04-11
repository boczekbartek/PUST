function y = aproks(X)
T1=X(1);
T2=X(2);
K=X(3);
Td=10;
wykresy=1;
y(1:350)=0;
% ua(1:350)=0;
u(1:3)=0;
u(4:400)=1;
close all
tmp = load('6.mat');
Yskok = tmp.Y3_G2_70;
Ypp=ones(1,400)*tmp.Y3pp;
OdpSkok = (Yskok(1:400)-Ypp)/(70-tmp.U2pp);

% nazwa = strcat('odp_skokowa.txt');
% savePlot(1:1:350,OdpSkok,nazwa);
alpha1 = exp(-1/T1);
alpha2 = exp(-1/T2);
a1 = -alpha1-alpha2;
a2 = alpha1*alpha2;
b1 = K*(T1*(1- alpha1)-T2*(1-alpha2))/(T1-T2);
b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);

for k = Td+3:400
y(k) = b1*u(k - Td -1)+b2*u(k-Td-2)-a1*y(k-1)- a2*y(k-2);
% ua(k) = aproksymacjaObiektu(1,28,y(k-1),y(k-2));
end
if wykresy
    stairs(OdpSkok);
    hold on
    stairs(y)
end
    % hold on
% stairs(Yskok)
%  nazwa = strcat('funkcja_aproksymuj¹ca.txt');
% savePlot(1:1:350,y,nazwa);
e = OdpSkok - y;
E=(norm(e))^2;
end