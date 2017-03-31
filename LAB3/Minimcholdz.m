function [Y1,Y3] = Minimcholdz(W1,W2,U1,U2,time)
    addpath('F:\SerialCommunication'); % add a path to the functions
    initSerialControl COM4 % initialise com port
    Y1pp = 34.18;
    Y3pp = 35.31;
    
    Y3(1:time)= Y3pp;
    Y1(1:time)= Y1pp;
    k=1;
    
    while(k<time)
        %% obtaining measurements
        measurements = readMeasurements(1:7); % read measurements from 1 to 7
        Y1(k)= measurements(1);
        Y3(k)= measurements(3);
        if Y1(k)<Y1pp
            W1 = 50;
        end
        if Y3(k)<Y3pp
            W2 = 50;
        end
        %% processing of the measurements and new control values calculation
        disp(measurements); % process measurements
        
        %% sending new values of control signals
        sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
                     [ W1, W2, 0, 0, U1(k), U2(k)]);  % new corresponding control values
        
        %% synchronising with the control process
        waitForNewIteration(); % wait for new batch of measurements to be ready
        k=k+1;
    end
end