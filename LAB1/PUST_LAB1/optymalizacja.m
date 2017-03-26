options = gaoptimset('StallGenLimit', 50, 'PopulationSize', 200, 'StallTimeLimit', 10);
[X] = ga(@aproks,3,[],[],[],[],[],[],[],[],options);
fprintf('\nT1=%f; T2=%f; K=%f;\n', X)
