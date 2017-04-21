options = gaoptimset('StallGenLimit', 100, 'PopulationSize', 300, 'StallTimeLimit', 30);
[X] = ga(@aproks,3,[],[],[],[],[],[],[],[],options);
fprintf('\nT1=%f; T2=%f; K=%f;\n', X)
