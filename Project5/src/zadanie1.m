czas=200;

y=zeros(3,czas);
u=zeros(4,czas);

% cztery u trzy y

for i=5:czas
        [y(1,i),y(2,i),y(3,i)]=symulacja_obiektu10...
        (u(1,i-1),u(1,i-2),u(1,i-3),u(1,i-4),...
        u(2,i-1),u(2,i-2),u(2,i-3),u(2,i-4),...
        u(3,i-1),u(3,i-2),u(3,i-3),u(3,i-4),...
        u(4,i-1),u(4,i-2),u(4,i-3),u(4,i-4),...
        y(1,i-1),y(1,i-2),y(1,i-3),y(1,i-4),...
        y(2,i-1),y(2,i-2),y(2,i-3),y(2,i-4),...
        y(3,i-1),y(3,i-2),y(3,i-3),y(3,i-4));
end

figure
hold on
plot(y(1,:))
plot(y(2,:))
plot(y(2,:))
legend('y1','y2','y3')
hold off

savePlot(1:czas,y(1,:),'zad1y1.txt');
savePlot(1:czas,y(2,:),'zad1y2.txt');
savePlot(1:czas,y(3,:),'zad1y3.txt');