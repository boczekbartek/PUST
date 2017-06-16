
clear all

% Liczenie zakreów przedziałów
Us = ones(1,50);
Ue = ones(1,50);
Us(1) = -1;
Ue(1) = -0.98;
for m=0:47
  Us(m+2) = -0.98 + m*0.0408333333333333;
  Ue(m+2) = -0.98 + (m*0.0408333333333333) + 0.0408333333333333;
end
Us(50)=Ue(49);

for m=1:50
    Ustart = Us(m)
    Uend = Ue(m)
    tic; [ku(m,:),ke(m), e(m) ]=optymalizacja(Ustart,Uend);toc;
    e(m)
    save(sprintf("OptymalizacjaGa_3proba_iter=%d",m))
end