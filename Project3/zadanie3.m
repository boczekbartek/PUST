
n =500
%inicjalizacja
u1(1:5)=0;
u1(6:500)=1;
u2(1:5)=0;
u2(6:500)=0;
y1(1:500)=0;
y2(1:500)=0;
%skok jednostkowy z punktu pracy do wartosci maksymalnej w chwili 20
 for k = 9:n
    y1(k)=symulacja_obiektu10y1(u1(k-7),u1(k-8),u2(k-3),u2(k-4),y1(k-1),y1(k-2));
    y2(k)=symulacja_obiektu10y2(u1(k-5),u1(k-6),u2(k-4),u2(k-5),y2(k-1),y2(k-2));
 end
 
%  figure
%  plot(Y)
 
 s_y1_u1=zeros(n-6,1); %odpowiedz skokowa
 s_y2_u1=zeros(n-6,1);
 for k = 6:n
    s_y1_u1(k-5) = y1(k);
    s_y2_u1(k-5) = y2(k);
 end
%  nazwa = strcat('sprawozdanie/wykresy/zadanie3_odpSkok_s_y1_u1.txt');
%  savePlot(1:1:n-5,s_y1_u1,nazwa);
%   nazwa = strcat('sprawozdanie/wykresy/zadanie3_odpSkok_s_y2_u1.txt');
%  savePlot(1:1:n-5,s_y2_u1,nazwa);
%  nazwa = strcat('sprawozdanie/wykresy/zadanie3_u1_skok_na_u1.txt');
%  savePlot(1:1:n-5,u1,nazwa);
%  nazwa = strcat('sprawozdanie/wykresy/zadanie3_u2_skok_na_u1.txt');
%  savePlot(1:1:n-5,u2,nazwa);
 figure
 stairs(s_y1_u1)
 hold on
 stairs(s_y2_u1)
 
 u1(6:500)=0;
 u2(6:500)=1;
 y1(1:500)=0;
y2(1:500)=0;
 for k = 9:n
    y1(k)=symulacja_obiektu10y1(u1(k-7),u1(k-8),u2(k-3),u2(k-4),y1(k-1),y1(k-2));
    y2(k)=symulacja_obiektu10y2(u1(k-5),u1(k-6),u2(k-4),u2(k-5),y2(k-1),y2(k-2));
 end
 
 s_y1_u2=zeros(n-6,1); %odpowiedz skokowa
 s_y2_u2=zeros(n-6,1);
 
  for k = 6:n
    s_y1_u2(k-5) = y1(k);
    s_y2_u2(k-5) = y2(k);
  end
%     nazwa = strcat('sprawozdanie/wykresy/zadanie3_u1_skok_na_u2.txt');
%  savePlot(1:1:n-5,u1,nazwa);
%  nazwa = strcat('sprawozdanie/wykresy/zadanie3_u2_skok_na_u2.txt');
%  savePlot(1:1:n-5,u2,nazwa);
%   nazwa = strcat('sprawozdanie/wykresy/zadanie3_odpSkok_s_y1_u2.txt');
%  savePlot(1:1:n-5,s_y1_u2,nazwa);
%   nazwa = strcat('sprawozdanie/wykresy/zadanie3_odpSkok_s_y2_u2.txt');
%  savePlot(1:1:n-5,s_y2_u2,nazwa);
  
 figure
 stairs(s_y1_u2)
 hold on
 stairs(s_y2_u2)
 
