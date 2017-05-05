a=linspace(1,100);
b(1:100)=0;
for i = 1:100
    b(i)=char_stat(i);
end

plot(a,b)