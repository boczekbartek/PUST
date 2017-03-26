Td=8
u(1:320)=1;
T1=T1s
T2=T2s
K=Ks
alpha1 = exp(-1/T1);
alpha2 = exp(-1/T2);
a1 = -alpha1-alpha2;
a2 = alpha1*alpha2;
b1 = K*(T1*(1- alpha1)-T2*(1-alpha2))/(T1-T2);
b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);
yaproks=zeros(1,320);
for k = Td+3:320
yaproks(k) = b1*u(k - Td -1)+b2*u(k-Td-2)-a1*yaproks(k-1)- a2*yaproks(k-2);
end
