clear all;
lb = [0.01,1,0.01];
ub = [Inf,Inf,Inf];
[param,fval,exitflag] = ga(@funkcja_do_optymalizacji,3,[],[],[],[],lb,ub,[],[]);
fprintf('PID: \nK=%f; Ti=%f; Td=%f; Ts=0.5;\n', param)