clear all;
jumps = [1.2,1.0,0.9,1.3];

params
Y(1:n)=Ypp;
for j=jumps
    U(1:n)=j;
    U(1)=Upp;
    
    for k=12:1:n
        Y(k)=symulacja_obiektu3Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
    end
    
    plot(Y)
    hold on;
    
    nazwa = strcat('wykresy/zadanie2_jump=', num2str(j),'.txt');
    savePlot(1:1:n,Y,nazwa);
    
end

title('odpowiedzi skokowe')
legend('skok U do 1.3','skok U do 1,2','skok U do 1.0','skok U do 0.9');

for i = 1:101
    Us(i) = 1.1 + 0.2*(i-1)*(1/100);
    U(1:20) = 1.1;
    U(20:n) = Us(i);
    for k = 12:n
        Y(k) = symulacja_obiektu3Y(U(k-10), U(k-11), Y(k-1), Y(k-2));
    end
    Ys(i) = Y(n);
    
end

%Wzmocnienie statyczne jako wspó³czynnik a - nachylenie prostej bêd¹cej
%charakterystyk¹ statyczn¹

Kstat=(Ys(50)-Ys(49))/(Us(50)-Us(49));


hold off;
figure
plot(Us,Ys);
title(sprintf('Wzmocnienie statyczne = %f',Kstat));

nazwa = strcat('wykresy/zadanie2_wzmStat.txt');
savePlot(Us,Ys,nazwa);


%statyczne s¹, dynamiczne nie, bo jest inercja z opóŸnieniem chyba xD