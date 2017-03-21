
params
wykresy = 0;
%inicjalizacja
Uskok = 0.9;
Zskok = 0.9;

U=zeros(n,1);
Yu=zeros(n-12,1);
Yu(1:12)=Ypp;
Z(1:300)=0;
%skok jednostkowy z punktu pracy do wartosci maksymalnej w chwili 20
U(1:20)=Upp;
U(21:end)=Uskok;
for k = 8:n
    Yu(k)=symulacja_obiektu6y(U(k-6),U(k-7),Z(k-3),Z(k-4),Yu(k-1),Yu(k-2));
end

su=zeros(n-21,1); %odpowiedz skokowa
for k = 21:n
    su(k-20) = (Yu(k)-Ypp)/(Uskok-Upp);
end
if wykresy
    figure
    stairs(su)
    title('Odpowiedz skokowa dla U')
    hold off
    
    nazwa = strcat('../wykresy/zadanie3_odpSkok_U_schodki.txt');
    savePlot(1:1:130,su,nazwa);
end
U(1:n) = Upp;
Z(1:20) = Zpp;
Z(20:n) = Zskok;
Yz=zeros(n-12,1);
Yz(1:12)=Ypp;
for k = 8:n
    Yz(k)=symulacja_obiektu6y(U(k-6),U(k-7),Z(k-3),Z(k-4),Yz(k-1),Yz(k-2));
end

%plot(Yz)
sz=zeros(n-21,1);
for k = 21:n
    sz(k-20) = (Yz(k)-Ypp)/(Zskok-Zpp);
end

if wykresy
    figure
    stairs(sz)
    title('Odpowiedz skokowa dla Z')
    
    nazwa = strcat('../wykresy/zadanie3_odpSkok_Z_schodki.txt');
    savePlot(1:1:130,sz,nazwa);
end