czas=210;

y=zeros(3,czas);


for i=1:4
    
    u=zeros(4,czas);    
    u(i,10:czas)=1;
    
    for k=11:czas
        [y(1,k),y(2,k),y(3,k)]=symulacja_obiektu10...
        (u(1,k-1),u(1,k-2),u(1,k-3),u(1,k-4),...
        u(2,k-1),u(2,k-2),u(2,k-3),u(2,k-4),...
        u(3,k-1),u(3,k-2),u(3,k-3),u(3,k-4),...
        u(4,k-1),u(4,k-2),u(4,k-3),u(4,k-4),...
        y(1,k-1),y(1,k-2),y(1,k-3),y(1,k-4),...
        y(2,k-1),y(2,k-2),y(2,k-3),y(2,k-4),...
        y(3,k-1),y(3,k-2),y(3,k-3),y(3,k-4));
    end
    
    savePlot(1:czas-10,y(1,11:czas),sprintf('odp_skokU%dY1.txt',i));
    savePlot(1:czas-10,y(2,11:czas),sprintf('odp_skokU%dY2.txt',i));
    savePlot(1:czas-10,y(3,11:czas),sprintf('odp_skokU%dY3.txt',i));
    
    
    subplot(2,2,i);
    
    hold on
    plot(y(1,11:czas));
    plot(y(2,11:czas));
    plot(y(3,11:czas));
    title(strcat('u',int2str(i)));
    xlabel('k');
    ylabel('y');
    legend('y1','y2','y3')
    
    savePlot(1:czas,y(1,:),sprintf('zad2u%dy1',i));
    savePlot(1:czas,y(2,:),sprintf('zad2u%dy2',i));
    savePlot(1:czas,y(3,:),sprintf('zad2u%dy3',i));
    
end