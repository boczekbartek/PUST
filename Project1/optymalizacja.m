% clear all;
% lb = [0.01,1,0.01];
% ub = [Inf,Inf,Inf];
% [param,fval,exitflag] = ga(@funkcja_do_optymalizacji,3,[],[],[],[],lb,ub,[],[]);
% fprintf('PID: \nK=%f; Ti=%f; Td=%f; Ts=0.5;\n', param)

clear all;
lb = [1,1,0.01];
ub = [180,180,Inf];
zadanie3
[param,fval,exitflag] = ga(@dmcfun,3,[-1 1 0],[0],[],[],lb,ub,[],[1 2]);
fprintf('DMC: \nN=%f; Nu=%f; lambda=%f;\n', param)