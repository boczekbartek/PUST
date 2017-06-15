clear all;

n = 100;      
U(1:n) = 0;   
Y(1:n) = 0;  

for k = 7:n
    Y(k) = symulacja_obiektu10y(U(k-5), U(k-6), Y(k-1), Y(k-2));
end

figure;
subplot('Position', [0.1 0.12 0.8 0.15]);
stairs(U);
ylim([0 1]);
xlabel('k');
ylabel('u');
subplot('Position', [0.1 0.37 0.8 0.6]);
stairs(Y);
ylabel('y');
savePlot(1:n,U,strcat('zad1.txt'));
savePlot(1:n,Y,strcat('zad1.txt'));
