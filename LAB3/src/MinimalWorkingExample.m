function [Y1,Y3] = MinimalWorkingExample(U1,U2)

    
        %% obtaining measurements
        measurements = readMeasurements(1:7); % read measurements from 1 to 7
        Y1= measurements(1);
         Y3= measurements(3);
        %% processing of the measurements and new control values calculation
        disp(measurements); % process measurements
        
        %% sending new values of control signals
        sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
                     [ 50, 50, 0, 0, U1, U2]);  % new corresponding control values
        
        %% synchronising with the control process
        waitForNewIteration(); % wait for new batch of measurements to be ready
    
end