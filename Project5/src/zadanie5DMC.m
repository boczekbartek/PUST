D=200;
N=200;
NU=200;

lambda=[809756633.229638 4368.69435554494 1201371.16173047 512033.480105263];
mi=[28729993.8373922 1543438461.32905 13758389.8059698];

start=[lambda mi];


% d = @(x)(zadanie3DMC(D,N,NU,[x(1) x(2) x(3) x(4)],[x(5) x(6) x(7)]));
% y=fmincon(d,start,[],[],[],[]);
% d(y)

d = @(x)(zadanie6DMC(D,N,NU,[x(1) x(2) x(3) x(4)],[x(5) x(6) x(7)]));
y=fmincon(d,start,[],[],[],[]);
d(y)