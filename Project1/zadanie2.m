clear all;
jumps = [1.3,1.2,1.0,0.9];
 
Upp=1.1;
%Ypp=2;
 
for k=jumps
 
    for i=1:150
        U(i)=k;
        Y(i)=0;
    end
 
    U(1)=Upp;
 
    for k=12:1:150
        Y(k)=symulacja_obiektu3Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
    end
 
    %fclose(dane)
    plot(Y)
    hold on;
end
title('odpowiedzi skokowe')
legend('skok U do 1.3','skok U do 1,2','skok U do 1.0','skok U do 0.9');
% dane = fopen('dane2.txt','wt');
%  
% for i =1:150
%     fprintf(dane,'%f %f\n',U(i),Y(i));
% end
% fclose(dane);
savePlot(U,Y,'dane.txt'); 
n=200;
for i = 1:101
    Us(i) = 0.9 + 0.4*(i-1)*(1/100);
    U(1:20) = 1.1;
    U(20:n) = Us(i);
    for k = 12:n
        Y(k) = symulacja_obiektu3Y(U(k-10), U(k-11), Y(k-1), Y(k-2));
    end
    Ys(i) = Y(n);
end
Kstat=(Ys(100)-Ys(1))/(Us(100)-Us(1));
 
hold off;
figure
plot(Us,Ys);
title(Kstat);
%statyczne s¹, dynamiczne nie, bo jest inercja z opóŸnieniem chyba xD