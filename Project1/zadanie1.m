clear all

%wpisanie do pamiêci parametrów symulacji
params

U(1:300)=Upp;
Y(1:300)=Ypp;
for k=12:1:300
Y(k)=symulacja_obiektu3Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
end
figure
subplot(2,1,1)
plot(Y)
subplot(2,1,2)
plot(U)
nazwa = strcat('wykresy/zadanie1Y.txt');
savePlot(1:1:300,Y,nazwa);

nazwa = strcat('wykresy/zadanie1U.txt');
savePlot(1:1:300,U,nazwa)