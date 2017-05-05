function [T1] = MinimalWorkingExample()
    addpath('C:\SerialCommunication'); % add a path to the functions
    initSerialControl COM3 % initialise com port
    k=1;
    n = 400;
    Gpp = 35;    
    w1 = 50;
    g1(1:10) = Gpp;
    g1(11:n) = 35;
    T1(1:n) = 0;
    while(k<=n)
        %% obtaining measurements
        measurements = readMeasurements(1:7); % read measurements from 1 to 7
        k
        T1(k) = measurements(1);
       
        %% processing of the measurements and new control values calculation
        disp(measurements); % process measurements
        
        %% sending new values of control signals
        sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
                     [ w1,0, 0, 0, 0, 0]);  % new corresponding control values
        
        sendNonlinearControls(g1(k));
        %% synchronising with the control process
        waitForNewIteration(); % wait for new batch of measurements to be ready
        k=k+1;
    end
end