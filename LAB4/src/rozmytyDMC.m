close all;
clear all;

reg = 2;

addpath('C:\SerialCommunication'); % add a path to the functions
initSerialControl COM3 % initialise com port

%uznajemy ze D = N = Nu dla uproszczenia. mozna dodac recznie inne wartosci
%trapezoidalna funkcja przynależności bo najprostsza i nie jest powiedziane ze nie mozna jej uzyc
%jak czegoś nie rozumiesz to lepsze komentarze są w pidzie

Ypp = 35;
Upp= 35
if reg == 1
    trapu = [-1 -0.9 0.9 1];
    D = {50};
    lambda = {800}; 
elseif reg == 2
    trapu = [-1 -0.9 0.2 0.3;...
            0.2 0.3 0.9 1];
    D = {300, 300};
    lambda = {0.159035, 31.528399};
elseif reg == 3
    trapu = [-1 -0.9 0.1 0.2;...
            0.1 0.2 0.5 0.6;...
            0.5 0.6 0.9 1];
    D = {30, 40, 50};
    lambda = {150, 1800, 65};%dalsze lambdy uzyskane przy fmincon (ale nie widze skryptu generujacego te lambdy, mozna eksperymentalnie sprobowac)
elseif reg == 4
    trapu = [-1 -0.9 0 0.1;...
            0 0.1 0.2 0.3;...
            0.2 0.3 0.5 0.6;...
            0.5 0.6 0.9 1];
    D = {30, 30, 40, 50};
    lambda = {22.8, 327.5, 6, 20.7};
elseif reg == 5
    trapu = [-1 -0.9 0 0.1;...
            0 0.1 0.15 0.25;...
            0.15 0.25 0.35 0.45;...
            0.35 0.45 0.5 0.6;...
            0.5 0.6 0.9 1];
    D = {30, 30, 40, 40, 50};
    lambda = {0.16, 8100, 4.7, 551, 18.7};
end

N = D;
Nu = D;

trapy = arrayfun(@char_stat,trapu); %przypisanie konkretnych granic Y
trapy(1,1:2)=-inf; %rozszerzenie granic koncowych do nieskonczonosci
trapy(end,3:4)=inf;

s = cell(1, reg);

% for i = 1:reg
%     s{i} = get_step_resp(trapu(i,2),trapu(i,3)); %zastapic wczytaniem z
% end                                              %pliku na laboratorium
						%dodaj tu odpowiedzi skokowe z workspace
tmp = load('ostateczny.mat');
od = tmp.T1_zad2_skok_40_2;
s1 = (od(1:400)-Ypp)/(40-Upp);
s{1} =s1;
tmp = load('ostateczny.mat');
od = tmp.T1_zad2_skok_90_2;
s2 = (od(1:400)-Ypp)/(90-Upp);
s{2} = s2;
n = 1000;
Yzad(1:n) = Ypp;  
Yzad(10:n) = Ypp+15;
Yzad(500:n)= Ypp+5;  
Yzad(800:n)= Ypp+1; 
Yzad(601:n)=4.2; 
Yzad(801:n)=0.5;
U(1:n) = 0; 
Y(1:n) = 0;
err = 0;


% D=120; 
% %parametry regulatora dobrane eksperymentalnie
% N=120; Nu=120; lambda=2111; %err=15.6111



dup = cell(1,reg); %oddzielna komorka - oddzielny regulator. reszta
M = cell(1,reg);   %identycznie jak w normalnym dmc
Mp = cell(1,reg);
K = cell(1,reg);
Ku = cell(1,reg);
Ke = cell(1,reg);

for k = 1:reg
    dup{k}(1:D{k}-1) = 0;
    
    M{k}=zeros(N{k},Nu{k});
    for i=1:N{k}
       for j=1:Nu{k}
          if (i>=j)
             M{k}(i,j)=s{k}(i-j+1);
          end;
       end;
    end;
    
    Mp{k}=zeros(N{k},D{k}-1);
    for i=1:N{k}
       for j=1:D{k}-1
          if i+j<=D{k}
             Mp{k}(i,j)=s{k}(i+j)-s{k}(j);
          else
             Mp{k}(i,j)=s{k}(D{k})-s{k}(j);
          end;      
       end;
    end;
    
    K{k}=((M{k}'*M{k}+lambda{k}*eye(Nu{k}))^-1)*M{k}';
    Ku{k}=K{k}(1,:)*Mp{k};
    Ke{k}=sum(K{k}(1,:));
end

%generacja macierzy





%przeksztalcanie wyliczonych macierzy do potrzebnych nam parametrow



%glowna petla

du = cell(1,reg);

for k=21:n %podmien na komunikacje z obiektem
   k
   measurements = readMeasurements(1:7);
   Y(k) = measurements(1);
%    Y(k)=symulacja_obiektu4y(U(k-5), U(k-6), Y(k-1), Y(k-2)); 
   
   e=Yzad(k)-Y(k); %uchyb
   err = err + e^2;
   U(k)=U(k-1);
   for i = 1:reg
        du{i}=Ke{i}*e-Ku{i}*dup{i}'; %regulator
        for n=D{i}-1:-1:2
            dup{i}(n)=dup{i}(n-1);
        end
        dup{i}(1)=du{i};
        mi{i} = trapmf(Y(k),trapy(i,:)); %trapezowa funkcja przynaleznosci
        U(k) = U(k) + mi{i}*dup{i}(1);
   end
    disp([k, U(k), Y(k), Yzad(k), err]); % process measurements

    sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
    [50, 0, 0, 0, U(k), 0]);  % new corresponding control values

   
   
   
   if U(k)>100 %ograniczenia na min/max sygnalu sterowania
       U(k) = 100;
   end
   if U(k)<-100
       U(k) = -100;
   end
    waitForNewIteration();
end

err

% figure('Position',  [403 246 820 420]);
% title('obiekt z regulatorem PID');
% subplot('Position', [0.1 0.12 0.8 0.15]);
% stairs(U);
% ylabel('u'); 
% xlabel('k');
% decimal_comma(gca, 'XY');
% subplot('Position', [0.1 0.37 0.8 0.6]);
% plot(Y);
% ylabel('y'); 
% decimal_comma(gca, 'XY');
% hold on; 
% stairs(Yzad,':');

