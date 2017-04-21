function [Y]= MinimalWorkingExample(u,z)
%     addpath('F:\SerialCommunication'); % add a path to the functions
%     initSerialControl COM4 % initialise com port
%     n=350;
%     Y=zeros(n,1);
%     i =1;
%     
  
%     while(i<=n)
        %% obtaining measurements
        measurements = readMeasurements(1:7); % read measurements from 1 to 7
        Y=measurements(1);
        %% processing of the measurements and new control values calculation
        disp(measurements); % process measurements
        
        
        %% sending new values of control signals
        sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
                      [50, 0, 0, 0, 0, 0]);  % new corresponding control values
        u
        z
        sendControlsToG1AndDisturbance(u,z);
        %% synchronising with the control process
        waitForNewIteration(); % wait for new batch of measurements to be ready
%         i=i+1
       
%     end
end