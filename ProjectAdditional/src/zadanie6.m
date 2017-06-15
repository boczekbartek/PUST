clear all;
%trapezowa funkcja przynale�no�ci
reg = 5;
switch reg
    case 1
    fun_przyn_u = [-1 -0.9 0.9 1];
    D = {50};
    lambda = {570}; 
    case 2
    fun_przyn_u = [-1 -0.8 -0.2 0;...
            -0.2 0 0.8 1];
    D = {40, 50};
    lambda = {500, 10};
    case 7
    fun_przyn_u = [-1 -0.9 -0.5 -0.4;...
            -0.5 -0.4 0.1 0.2;...
            0.1 0.2 0.9 1];
    D = {30, 40, 50};
    lambda = {800, 30, 10};
    case 4
    fun_przyn_u = [-1 -0.9 -0.7 -0.6;...
            -0.7 -0.6 -0.3 -0.2;...
            -0.3 -0.2 -0.1 0;...
            -0.1 0 0.9 1];
    D = {30, 30, 40, 50};
    lambda = {100, 50, 10, 10};
    case 5
    fun_przyn_u = [-1 -0.9 -0.6 -0.5;...
            -0.6 -0.5 -0.4 -0.35;...
            -0.4 -0.35 -0.2 -0.15;...
            -0.2 -0.15 0 0.1;...
            0 0.1 0.9 1];
    D = {30, 30, 40, 40, 50};
    lambda = {10, 10, 10, 500, 10};
end

fun_przyn_y = arrayfun(@char_stat_fun,fun_przyn_u);  %map fun_przyn_u => charstatfun

s = cell(1,reg);
for i = 1:reg
    s{i} = odpowiedzi_skokowe(fun_przyn_u(i,2),fun_przyn_u(i,3)); 
end 


n = 1000;
Yzad(1:n)=0;
Yzad(21:n)=-1;
Yzad(201:n)=-0.2;
Yzad(401:n)=-2;
Yzad(601:n)=0.08;
Yzad(801:n)=-1.5;
U(1:n)=0;
Y(1:n)=0;
err = 0;

N = D; Nu = D;


dup=cell(1,reg);
M=cell(1,reg);
Mp=cell(1,reg);
K=cell(1,reg);
Ku=cell(1,reg);
Ke=cell(1,reg);

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

du = cell(1,reg);



for k=21:n 
    
    Y(k)=symulacja_obiektu10y(U(k-5), U(k-6), Y(k-1), Y(k-2)); 
    e=Yzad(k)-Y(k);
    
    
    U(k)=U(k-1);
    for i=1:reg
        
        du{i}=Ke{i}*e-Ku{i}*dup{i}';
        
        for n=D{i}-1:-1:2
            dup{i}(n)=dup{i}(n-1);
        end
        
        dup{i}(1)=du{i};
        mi{i}=trapmf(Y(k),fun_przyn_y(i,:));
        U(k)=U(k) + mi{i}*dup{i}(1);
    end
   
    if U(k)>1
        U(k) = 1;
    end
    if U(k)<-1
        U(k) = -1;
    end
    
    err = err + e^2;

end

err


figure('Position',  [403 246 820 420]);
subplot('Position', [0.1 0.12 0.8 0.15]);
stairs(U);
ylabel('u'); 
xlabel('k');
subplot('Position', [0.1 0.37 0.8 0.6]);
stairs(Y);
ylabel('y'); 
hold on; 
stairs(Yzad,':');
% savePlot(1:1000,U,'zad7_U_5_reg.txt');
% savePlot(1:1000,Y,'zad7_Y_5_reg.txt');
