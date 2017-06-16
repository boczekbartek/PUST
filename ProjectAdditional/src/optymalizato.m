lb=[1 1 0 0 0 0 0 0];
ub=[100 100 Inf Inf Inf Inf Inf Inf];
lambda = ones(1,50) * 0.1;
n=50;
c = ones(1,49)*10;
x0=[nastawy(1) nastawy(2) nastawy(3:2+n) n nastawy(3+n) c];
Nu=80;
N=80;

[nastawy, min_error]=fmincon(@(x)(zad50dmc(x(1),x(2),x(3:2+n), n ,x(3+n) ,x(4+n:4+2*n-2),false)),x0,[],[],[],[],lb,ub);

E=zad50dmc(nastawy(1),nastawy(2),nastawy(3:2+n) , 50 ,nastawy(3+n) , nastawy(4+n:4+2*n-2),true);
