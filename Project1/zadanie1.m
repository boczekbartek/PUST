Upp=1.1;
%Ypp=2;
for i=1:300
    U(i)=Upp;
    Y(i)=0;
end
for k=12:1:300
Y(k)=symulacja_obiektu3Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
end

plot(Y)

%no i Y w kt�rej� pr�bce musi Ci osi�gn�� punkt pracy Ypp
%fclose(dane);

dane = fopen('dane2.txt','wt');

for i=1:300
    fprintf(dane,'%f %f\n',U(i),Y(i))
end

fclose(dane);