
clear all
Us15 = ones(1,15);
Ue15= ones(1,15);
Us15(1) = -1
Ue15(1) = -0.6;
Ue15(end)=1
for m=0:12
  Us15(m+2) = -0.6+ m*0.0538461538461538;
  Ue15(m+2) = -0.6 + (m*0.0538461538461538) + 0.0538461538461538;
end
Us15(end)=0.1;
Ue15(end-1)=0.1;

for m=1:50
    m
    Ustart = Us15(m)
    Uend = Ue15(m)
    tic; [ku(m,:),ke(m), e(m) ]=optymalizacja(Ustart,Uend);toc;
    e(m)
    save(sprintf('OptymalizacjaGa_15reg_iter=%d',m))
end
