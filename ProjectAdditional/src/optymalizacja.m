function [nastawy] = optymalizacja(Ustart,Uend,odpSkok)

% clear all;
% lb = [0.01,1,0.01];
% ub = [Inf,Inf,Inf];
% [param,fval,exitflag] = ga(@PIDfun,3,[],[],[],[],lb,ub,[],[]);
% fprintf('PID: \nK=%f; Ti=%f; Td=%f; Ts=0.5;\n', param)
% 
% clear all;
% lb = [1,1,0.01];
% ub = [130,130,Inf];
% [param,fval,exitflag] = ga(@dmcfun,3,[-1 1 0],[0],[],[],lb,ub,[],[1 2]);
% fprintf('DMC: \nN=%f; Nu=%f; lambda=%f;\n', param)





x0 = [1 1 1];
lb = [1, 1, 0.0001];
ub = [80,80,1000];
% [nastawy, min_error, exitfalg] = ga(@(x)(dmcfun(x,Ustart,Uend,odpSkok,false)),3,[], [], [],[],lb,ub,[],[]);
[nastawy, min_error]=fmincon(@(x)(dmcfun(x,Ustart,Uend,odpSkok,false)),x0,[],[],[],[],lb,ub);
min_error;
N = nastawy(1)
Nu = nastawy(2)
Lambda = nastawy(3)