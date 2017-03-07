
params

%inicjalizacja
U=zeros(n,1);
Y=zeros(n-12,1);
Y(1:12)=Ypp;
%skok jednostkowy z punktu pracy do wartosci maksymalnej w chwili 20
U(1:20)=Upp; 
U(21:end)=Umax;
 for k = 12:n
    Y(k) = symulacja_obiektu3Y(U(k-10), U(k-11), Y(k-1), Y(k-2));
 end
 
 figure
 plot(Y)
 
 s=zeros(n-21,1); %odpowiedz skokowa
 for k = 21:n
    s(k-20) = (Y(k)-Ypp)/(Umax-Upp);
 end
 figure
 stairs(s)