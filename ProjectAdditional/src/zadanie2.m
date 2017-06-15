clear all;

n = 100;
U(1:n) = 0;
Y(1:n) = 0;
%Ypp=Upp=0

%charstat 
for i = 1:n+1
    Us(i) = (i-1)*(2/100)-1;
    U(20:n) = Us(i);
    for k = 12:n
        Y(k) = symulacja_obiektu10y(U(k-5), U(k-6), Y(k-1), Y(k-2));
    end
    Ys(i) = Y(n);
end
figure;
plot(Us, Ys);
xlabel('u');
ylabel('y');


%odpowiedzi
figure;
for i = 0:4
    jumps = 1 - i*0.5;
    U(20:n) = jumps;
    for k = 12:n
        Y(k) = symulacja_obiektu10y(U(k-5), U(k-6), Y(k-1), Y(k-2));
    end
    subplot('Position', [0.1 0.12 0.8 0.15]);
%     savePlot(1:n,U,strcat('zad2odpowiedz_skokowa_U_',num2str(jumps),'.txt'));
    stairs(U);
    xlabel('k');
    ylabel('u');
    hold on;
    subplot('Position', [0.1 0.37 0.8 0.6]);
    plot(Y);
%     savePlot(1:n,Y,strcat('zad2odpowiedz_skokowa_Y_',num2str(jumps),'.txt'));
    ylabel('y');
    hold on;
end
legend({'U=1','U=0,5','U=0','U=-0,5','U=-1'});
