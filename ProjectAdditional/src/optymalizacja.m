function [ku, ke, e] = optymalizacja(Ustart,Uend)
odpSkok = odpowiedzi_skokowe(Ustart, Uend);


lb = [1, 1, 0.0001];
ub = [80,90,1000];

[nastawy, min_error, exitfalg] = ga(@(x)(dmcfun(x,Ustart,Uend,odpSkok,false)),3,[], [], [],[],lb,ub,[],[]);
% [nastawy, min_error]=fmincon(@(x)(dmcfun(x,Ustart,Uend,odpSkok,false)),x0,[],[],[],[],lb,ub);
N = nastawy(1);
Nu = nastawy(2);
Lambda = nastawy(3);
[e, ku, ke] = dmcfun(nastawy, Ustart,Uend,odpSkok, true);
