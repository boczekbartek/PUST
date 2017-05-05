% clear all;
% lb = [0 0 0 0 0 0 ];
% % ub = [5 15 3 3 7 3];
% param = ga(@pidfun,6,[],[],[],[],lb,[],[],[])
% fprintf('PID: \nK1=%f; Ti1=%f; Td1=%f; Ts=0.5;\n K2=%f; Ti2=%f; Td2=%f; Ts=0.5;\n', param)
%  param = fmincon(@pidfun,[2 3 2 2 2 2],[],[],[],[],[0 0 0 0 0 0],[]);
%  fprintf('PID: \nK1=%f; Ti1=%f; Td1=%f; Ts=0.5;\n K2=%f; Ti2=%f; Td2=%f; Ts=0.5;\n', param)
% pidfun(param)

% clear all;
% lb = [1,1,0.01];
% ub = [130,130,Inf];
% [param,fval,exitflag] = ga(@dmcfun,3,[-1 1 0],[0],[],[],lb,ub,[],[1 2]);
% fprintf('DMC: \nN=%f; Nu=%f; lambda=%f;\n', param)

% options = gaoptimset('StallGenLimit', 100, 'PopulationSize', 300, 'StallTimeLimit', 80);
% 
% [X] = fmincon(@aproks,[0.1 0.2 0.1]);
[X] = ga(@aproks,3,[],[],[],[],[],[],[],[]);
fprintf('\nT1_G1Y1=%f; T2_G1Y1=%f; K_G1Y1=%f;\n', X)