clear all

%wpisanie do pami�ci parametr�w symulacji
params
Z(1:300)=Zpp;
U(1:300)=Upp;
Y(1:300)=Ypp;
for k=8:1:300
Y(k)=symulacja_obiektu6y(U(k-6),U(k-7),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
end
figure
subplot(2,1,1)
plot(Y)
subplot(2,1,2)
plot(U)
nazwa = strcat('../wykresy/zadanie1Y.txt');
savePlot(1:1:300,Y,nazwa);

nazwa = strcat('../wykresy/zadanie1U.txt');
savePlot(1:1:300,U,nazwa)