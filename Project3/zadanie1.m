clear all
n = 500;
u1(1:n) = 0;
u2(1:n) = 0;
y1(1:n) = 0;
y2(1:n) = 0;

for k=9:n
    y1(k)=symulacja_obiektu10y1(u1(k-7),u1(k-8),u2(k-3),u2(k-4),y1(k-1),y1(k-2));
    y2(k)=symulacja_obiektu10y2(u1(k-5),u1(k-6),u2(k-4),u2(k-5),y2(k-1),y2(k-2));
end

nazwa = strcat('sprawozdanie/wykresy/zadanie1_y2.txt');
savePlot(1:1:500,y2,nazwa);
nazwa = strcat('sprawozdanie/wykresy/zadanie1_y1.txt');
savePlot(1:1:500,y1,nazwa);
nazwa = strcat('sprawozdanie/wykresy/zadanie1_u2.txt');
savePlot(1:1:500,u2,nazwa);
nazwa = strcat('sprawozdanie/wykresy/zadanie1_u1.txt');
savePlot(1:1:500,u1,nazwa);
figure
subplot(2,1,1)
stairs(y1)
subplot(2,1,2)
stairs(y2)

