clear all

n = 1000;
U(1:n) = 0;
Y(1:n) = 0;

U(20:n) = 1;
for k = 7:n
    Y(k) = symulacja_obiektu10y(U(k-5), U(k-6), Y(k-1), Y(k-2));
end
for k = 21:n
    s(k-20) = Y(k);
end

Yzad(1:n) = 0;
Yzad(21:n) = -1;
Yzad(201:n)= -2;
Yzad(401:n)= -1;
Yzad(601:n)=-2;
Yzad(801:n)=-1;
U(1:n) = 0;
Y(1:n) = 0;
err = 0;

D=50; N=50; Nu=50; lambda=250;

for i=1:D-1
   dup(i)=0;
end

M=zeros(N,Nu);
for i=1:N
   for j=1:Nu
      if (i>=j)
         M(i,j)=s(i-j+1);
      end;
   end;
end;

Mp=zeros(N,D-1);
for i=1:N
   for j=1:D-1
      if i+j<=D
         Mp(i,j)=s(i+j)-s(j);
      else
         Mp(i,j)=s(D)-s(j);
      end;      
   end;
end;

K=((M'*M+lambda*eye(Nu))^-1)*M';
Ku=K(1,:)*Mp;
Ke=sum(K(1,:));


 
for k=21:n
    
     Y(k)=symulacja_obiektu10y(U(k-5), U(k-6), Y(k-1), Y(k-2));
     e(k)=Yzad(k)-Y(k);
     
     du=Ke*e(k) - Ku*dup';  
     
     for n=D-1:-1:2
        dup(n)=dup(n-1);
     end
     dup(1)=du;
     U(k)=U(k-1)+dup(1);
     
     
     if U(k)>1
         U(k) = 1;
     end
     if U(k)<-1
         U(k) = -1;
     end
end;
 
err = sum(e.^2)
 
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
