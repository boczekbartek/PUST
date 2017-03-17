clear all;
jumps = [0.2, 0.5,0.9,1.3];

params
Z(1:300)=Zpp;
Y(1:n)=Ypp;
figure;
for j=jumps
    U(1:n)=j;
    U(1)=Upp;
    
    for k=12:1:n
        Y(k)=symulacja_obiektu6y(U(k-6),U(k-7),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
    end
    
    plot(Y)
    hold on;
    
%     nazwa = strcat('wykresy/zadanie2_jump=', num2str(j),'.txt');
%     savePlot(1:1:n,Y,nazwa);
%     
end

title('odpowiedzi skokowe dla Y')
legend('skok U do 0,2','skok U do 0,5','skok U do 0,9','skok U do 1,3');
hold off
figure
Y(1:n)=Ypp;
U(1:n)=Upp;
for j=jumps
    Z(1:n)=j;
    Z(1)=Zpp;
    
    for k=12:1:n
        Y(k)=symulacja_obiektu6y(U(k-6),U(k-7),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
    end
    
    plot(Y)
    hold on;
    
%     nazwa = strcat('wykresy/zadanie2_jump=', num2str(j),'.txt');
%     savePlot(1:1:n,Y,nazwa);
%     
end

title('odpowiedzi skokowe dla Z')
legend('skok Z do 0,2','skok Z do 0,5','skok Z do 0,9','skok Z do 1,3');
hold off;
for i = 1:101
    Us(i) = 1.1 + 0.2*(i-1)*(1/100);
    U(1:20) = 1.1;
    U(20:n) = Us(i);
    for k = 12:n
        Y(k)=symulacja_obiektu6y(U(k-6),U(k-7),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
    end
    Ys(i) = Y(n);
    
end

%Wzmocnienie statyczne jako wspó³czynnik a - nachylenie prostej bêd¹cej
%charakterystyk¹ statyczn¹

KstatU=(Ys(50)-Ys(49))/(Us(50)-Us(49));

hold off;
figure
plot(Us,Ys);
title(sprintf('Wzmocnienie statyczne U = %f',KstatU));
% 
% nazwa = strcat('wykresy/zadanie2_wzmStat.txt');
% savePlot(Us,Ys,nazwa);
% 

for i = 1:101
    Zs(i) = 1.1 + 0.2*(i-1)*(1/100);
    Z(1:20) = 1.1;
    Z(20:n) = Zs(i);
    for k = 12:n
        Y(k)=symulacja_obiektu6y(U(k-6),U(k-7),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
    end
    Ys(i) = Y(n);
    
end


KstatZ=(Ys(50)-Ys(49))/(Zs(50)-Zs(49));

hold off;
figure
plot(Zs,Ys);
title(sprintf('Wzmocnienie statyczne Z = %f',KstatZ));
% 

%statyczne s¹, dynamiczne nie, bo jest inercja z opóŸnieniem chyba xD