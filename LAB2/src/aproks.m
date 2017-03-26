function [a1,a2,b1,b2] = aproks(X)
wykresy = 0;
T1=X(1);
T2=X(2);
K=X(3);
Td=8;
y(1:320)=0;
u(1:320)=1;

tmp = load('zmienne.mat');
OdpSkok = tmp.s;
if wykresy == 1
figure
stairs(OdpSkok);
hold on
end
alpha1 = exp(-1/T1);
alpha2 = exp(-1/T2);
a1 = -alpha1-alpha2;
a2 = alpha1*alpha2;
b1 = K*(T1*(1- alpha1)-T2*(1-alpha2))/(T1-T2);
b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);

for k = Td+3:320
y(k) = b1*u(k - Td -1)+b2*u(k-Td-2)-a1*y(k-1)- a2*y(k-2);
end
if wykresy
stairs(y)
hold off
end
e = OdpSkok - y;
E=(norm(e))^2;
end