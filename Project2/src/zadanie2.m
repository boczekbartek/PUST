clear all;

jumps = [0.2, 0.5,0.9,1.3];

params
Z(1:300)=Zpp;
Y(1:n)=Ypp;
figure;
for j=jumps
    U(1:n)=j;
    U(1)=Upp;
    
    for k=8:1:n
        Y(k)=symulacja_obiektu6y(U(k-6),U(k-7),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
    end
    
    plot(Y)
    hold on;
    
    nazwa = strcat('../wykresy/zadanie2_jump=', num2str(j),'_U.txt');
    savePlot(1:1:n,Y,nazwa);
    %
end

title('odpowiedzi skokowe dla Y')
legend('skok U do 0,2','skok U do 0,5','skok U do 0,9','skok U do 1,3');
hold off
figure
Y(1:n)=Ypp;
U(1:n)=Upp;
for j=jumps
    Z(10:n)=j;
    Z(1:9)=Zpp;
    
    for k=12:1:n
        Y(k)=symulacja_obiektu6y(U(k-6),U(k-7),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
    end
    
    plot(Y)
    hold on;
    stairs(Z(1:n))
    
    nazwa = strcat('../wykresy/zadanie2_jump=', num2str(j),'_Z.txt');
    savePlot(1:1:n,Y,nazwa);
    
end

title('odpowiedzi skokowe dla Z')
legend('skok Z do 0,2','skok Z do 0,5','skok Z do 0,9','skok Z do 1,3');
hold off;

Us(1:41) = 0;
Zs(1:41) = 0;
Ys(1:41,1:41) = 0;
for i = 1:41
    Us(i) = 0 - 0.5 + (i-1)*(1/40);
    for j = 1:41
        Zs(j) = 0 - 0.5 + (j-1)*(1/40);
        U(1:10) = 0;
        U(10:n) = Us(i);
        Z(10:n) = Zs(j);
        for k = 8:n
            Y(k)=symulacja_obiektu6y(U(k-6),U(k-7),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
        end
        Ys(i,j) = Y(n);
    end
end

surf(Us,Zs,Ys)

%eksport danych dla Latexa
tab=zeros(41*41,4);
i = 1;
for x=1:size(Us')
    for y =1:size(Zs')
        tab(i,:) = [Us(x) Zs(y) Ys(x,y) Ys(x,y)];
        i = i+1;
    end
end

dane = fopen('../wykresy/surf.txt','wt');

for i=1:41*41
    fprintf(dane,'%f\t%f\t%f\t%f\\\\ \n', tab(i,1),tab(i,2),tab(i,3),tab(i,4));
end
fclose(dane);



%
% %Wzmocnienie statyczne jako wspó³czynnik a - nachylenie prostej bêd¹cej
% %charakterystyk¹ statyczn¹
%
% KstatU=(Ys(50)-Ys(49))/(Us(50)-Us(49));
%
% hold off;
% figure
% plot(Us,Ys);
% title(sprintf('Wzmocnienie statyczne U = %f',KstatU));
% %
% % nazwa = strcat('wykresy/zadanie2_wzmStat.txt');
% % savePlot(Us,Ys,nazwa);
% %
%
