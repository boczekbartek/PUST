U1=ans.U1/2.8;
U2=ans.U2/2.8;


for k=1:400
    if U1(k)>100
        U1(k)=100;
    end
    if U1(k)<0
        U1(k)=0;
    end
end
       
stairs(U1)


for k=1:400
    if U2(k)>100
        U2(k)=100;
    end
    if U2(k)<0
        U2(k)=0;
    end
end
figure      
stairs(U2)
