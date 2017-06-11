% K=[0.1 0.1 0.1];
% Ti=[1000 1000 1000];
% Td=[0 0 0];

K=[0.540533050840108 -3.93533097394258 -0.401112728951613];
Ti=[2.52943070390993 16.9552270428315 2.01049506267861];
Td=[0.609413583637298 3.30122276050988 -0.00822846142602021];


regs=[3 1 2];


start=[K,Ti,Td];


d = @(x)(zadanie3PID([x(1) x(2) x(3)],[x(4) x(5) x(6)],[x(7) x(8) x(9)],regs));
y=fmincon(d,start,[],[],[],[]);
d(y)