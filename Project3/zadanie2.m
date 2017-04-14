clear all;
n = 500;
jumps = [0.2, 0.5,0.9,1.3];
Y1pp=0;
Y2pp=0;
U1pp=0;
U2pp=0;
y1(1:500)=Y1pp;
y2(1:500)=Y2pp;

figure;
    u1(1:n)=1;
    u1(1)=U1pp;
    u2(1:n)=-1;
    u2(1)=U2pp;
    
    for k=9:1:n
        y1(k)=symulacja_obiektu10y1(u1(k-7),u1(k-8),u2(k-3),u2(k-4),y1(k-1),y1(k-2));
        y2(k)=symulacja_obiektu10y2(u1(k-5),u1(k-6),u2(k-4),u2(k-5),y2(k-1),y2(k-2));
    end
    
%     subplot(2,1,1)
%     stairs(y1)
%     subplot(2,1,2)
%     stairs(y2)
%     figure
%     subplot(2,1,1)
%     stairs(u1)
%     subplot(2,1,2)
%     stairs(u2)
    
% nazwa = strcat('sprawozdanie/wykresy/zadanie2_przypadek5=_y1.txt');
% savePlot(1:1:n,y1,nazwa);
% nazwa = strcat('sprawozdanie/wykresy/zadanie2_przypadek5=_y2.txt');
% savePlot(1:1:n,y2,nazwa);
% nazwa = strcat('sprawozdanie/wykresy/zadanie2_przypadek5=_u1.txt');
% savePlot(1:1:n,u1,nazwa);
% nazwa = strcat('sprawozdanie/wykresy/zadanie2_przypadek5=_u2.txt');
% savePlot(1:1:n,u2,nazwa);
% 
% 
% title('odpowiedzi skokowe dla Y')
% legend('skok U do 0,2','skok U do 0,5','skok U do 0,9','skok U do 1,3');
% hold off
% figure
% Y(1:n)=Ypp;
% U(1:n)=Upp;
% for j=jumps
%     Z(1:n)=j;
%     Z(1)=Zpp;
%     
%     for k=12:1:n
%         Y(k)=symulacja_obiektu6y(U(k-6),U(k-7),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
%     end
%     
%     plot(Y)
%     hold on;
%     stairs(Z(1:n))
%     
% %     nazwa = strcat('../wykresy/zadanie2_jump=', num2str(j),'_Z.txt');
% %     savePlot(1:1:n,Y,nazwa);
%     
% end
% 
% title('odpowiedzi skokowe dla Z')
% legend('skok Z do 0,2','skok Z do 0,5','skok Z do 0,9','skok Z do 1,3');
% hold off;
% 

U1s(1:41) = 0;
U2s(1:41) = 0;
Ys1(1:41,1:41) = 0;
Ys2(1:41,1:41) = 0;

for i = 1:41
    U1s(i) = 0 - 0.5 + (i-1)*(1/40);
    for j = 1:41
        U2s(j) = 0 - 0.5 + (j-1)*(1/40);
        u1(1:10) = 0;
        u1(10:n) = U1s(i);
        u2(10:n) = U2s(j);
        
        for k = 9:n
            y1(k)=symulacja_obiektu10y1(u1(k-7),u1(k-8),u2(k-3),u2(k-4),y1(k-1),y1(k-2));
            y2(k)=symulacja_obiektu10y2(u1(k-5),u1(k-6),u2(k-4),u2(k-5),y2(k-1),y2(k-2));
        end
        
        Ys1(i,j) = y1(n);
        Ys2(i,j) = y2(n);

    end
end

KstatY1_U1=(Ys1(41,1)-Ys1(40,1))/(U1s(41)-U1s(40))
KstatY1_U2=(Ys1(1,41)-Ys1(1,40))/(U2s(41)-U2s(40))
KstatY2_U1=(Ys2(1,41)-Ys2(1,40))/(U1s(41)-U1s(40))
KstatY2_U2=(Ys2(1,41)-Ys2(1,40))/(U2s(41)-U2s(40))

figure

surf(U1s,U2s,Ys1)
tab=zeros(41*41,4);
i = 1;
for x=1:size(U1s')
    for y =1:size(U2s')
        tab(i,:) = [U1s(x) U2s(y) Ys1(x,y) Ys1(x,y)];
        i = i+1;
    end
end

dane = fopen('sprawozdanie/wykresy/zadanie2_y1u1u2.txt','wt');

for i=1:41*41
    fprintf(dane,'%f\t%f\t%f\t%f\\\\ \n', tab(i,1),tab(i,2),tab(i,3),tab(i,4));
end
fclose(dane);
figure 
surf(U1s,U2s,Ys2)
% 
% 
% %eksport danych dla Latexa
tab=zeros(41*41,4);
i = 1;
for x=1:size(U1s')
    for y =1:size(U2s')
        tab(i,:) = [U1s(x) U2s(y) Ys2(x,y) Ys2(x,y)];
        i = i+1;
    end
end

dane = fopen('sprawozdanie/wykresy/zadanie2_y2u1u2.txt','wt');

for i=1:41*41
    fprintf(dane,'%f\t%f\t%f\t%f\\\\ \n', tab(i,1),tab(i,2),tab(i,3),tab(i,4));
end
fclose(dane);
% 
% %
% % %Wzmocnienie statyczne jako wspó³czynnik a - nachylenie prostej bêd¹cej
% % %charakterystyk¹ statyczn¹
% %
% 
% % hold off;
% % figure
% % plot(Us,Ys);
% % title(sprintf('Wzmocnienie statyczne U = %f',KstatU));
% % %
% % % nazwa = strcat('wykresy/zadanie2_wzmStat.txt');
% % % savePlot(Us,Ys,nazwa);
% % %
% %
