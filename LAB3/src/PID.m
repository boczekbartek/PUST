function [Y1,Y3] = PID(Y1_z,Y3_z,W1,W2,time)
    
addpath('F:\SerialCommunication'); % add a path to the functions
initSerialControl COM17 % initialise com port
Y1pp = 33.75;
Y3pp = 36.62;
U1pp=31;
U2pp=36;

Y1(1:time) = Y1pp;
Y3(1:time) = Y3pp;
k = 3;
    
%reg 1
K1 = 20; Ti1=40; Td1=15; Ts=2; 
r12 = K1*Td1/Ts;
r11 = K1*(Ts/(2*Ti1) - 2*Td1/Ts - 1);
r10 = K1*(1+Ts/(2*Ti1) + Td1/Ts);
 

%reg 2
K2 = 14.3; Ti2=38.32; Td2=6.67; Ts=0.3;
r22 = K2*Td2/Ts;
r21 = K2*(Ts/(2*Ti2)-2*Td2/Ts - 1);
r20 = K2*(1+Ts/(2*Ti2) + Td2/Ts);
    
Y1_zad(1:14)=Y1pp;
Y1_zad(15:time)=Y1_z;
Y3_zad(1:14)=Y3pp;
Y3_zad(15:time)=Y3_z;

U1(1:time)=U1pp;
U2(1:time)=U2pp;

u1=U1-U1pp;
u2=U1-U2pp;

y1_z=Y1_zad-Y1pp;
y3_z=Y3_zad-Y3pp;

y1(1:time)=0;
y3(1:time)=0;
e1(1:time)=0;
e3(1:time)=0;
    
while(k<time)
        
        
    %% obtaining measurements
    measurements = readMeasurements(1:7); % read measurements from 1 to 7
    Y1(k)= measurements(1);
    Y3(k)= measurements(3);

    %% processing of the measurements and new control values calculation
    disp(measurements); % process measurements
        
        
    y1(k)=Y1(k)-Y1pp;
    y3(k)=Y3(k)-Y3pp;
    
    e1(k)=y1_z(k)-y1(k); %uchyb1
    e3(k)=y3_z(k)-y3(k); %uchyb3
    
    du1=r12*e1(k-2)+r11*e1(k-1)+r10*e1(k); %regulator1
    du2=r22*e3(k-2)+r21*e3(k-1)+r20*e3(k); %regulator2
    
    u1(k)=u1(k-1)+du1;
    u2(k)=u2(k-1)+du2;
    
    U1(k)=u1(k)+U1pp;
    U2(k)=u2(k)+U2pp;
    
    if U1(k)>100
        U1(k)=100;
    end
    if U2(k)>100
        U2(k)=100;
    end
        
     
        
    %% sending new values of control signals
    sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
                 [ W1, W2, 0, 0, U1(k), U2(k)]);  % new corresponding control values
        
    %% synchronising with the control process
    waitForNewIteration(); % wait for new batch of measurements to be ready
    k=k+1

end
end