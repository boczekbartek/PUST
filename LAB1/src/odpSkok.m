Td=10;
T1=17.099506;
T2=64.970974;
K=0.263644;
s(1:350)=0;
ua(1:350)=0;
u(1:340)=0;
u(2:350)=1;
close all
tmp = load('zmienne.mat');
Yskok = tmp.Yz;
Ypp=ones(1,350)*30.81;
OdpSkok = (Yskok-Ypp)/22;
% stairs(OdpSkok);
% hold on
% nazwa = strcat('odp_skokowa.txt');
% savePlot(1:1:350,OdpSkok,nazwa);
alpha1 = exp(-1/T1);
alpha2 = exp(-1/T2);
a1 = -alpha1-alpha2;
a2 = alpha1*alpha2;
b1 = K*(T1*(1- alpha1)-T2*(1-alpha2))/(T1-T2);
b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);

for k = Td+3:350
s(k) = b1*u(k - Td -1)+b2*u(k-Td-2)-a1*s(k-1)- a2*s(k-2);
end

% hold on

% stairs(s)
% hold off
% stairs(ua)
%  nazwa = strcat('funkcja_aproksymuj¹ca.txt');
% savePlot(1:1:350,y,nazwa);

