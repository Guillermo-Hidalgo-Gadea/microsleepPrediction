%---------------------------------------------------------
%Feature extraction for 
%MultiModalBioSignalAnalysis MMBSA
%Bachelor Thesis Guillermo Hidalgo Gadea 
%Fatigue detection based on multimodal biosignal analysis
%---------------------------------------------------------

%% load Data for Microsleep interval
    fprintf('Loading Microsleep data...\n');
    PATH = 'F:\Processed\Splitted\';
    
    % search directory for subjects 
    files = dir('F:\Processed\Splitted\*_MS.csv');
    files = strvcat(files.name);
    x = size(files);
    
    % placeholder feature Table
    FeatureTableMS = ones(x(1),96);
    
    for i = 1:x(1)
       
        %read .csv file
        FILE = [PATH files(i,:)];
        [a,name,b] = fileparts(FILE);
        fprintf('loading File ...\n');
        fprintf('Filename: %s', name);
        fprintf('\n');
        J = dlmread(FILE);
        
        %calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        FeatureTableMS(i,1) = mean(J(:,2)); %ECG
        FeatureTableMS(i,2) = mean(J(:,3)); %HR
        FeatureTableMS(i,3) = mean(J(:,4)); %HrvHf
        FeatureTableMS(i,4) = mean(J(:,5)); %HrvLf
        FeatureTableMS(i,5) = mean(J(:,6)); %HrvLfHf
        FeatureTableMS(i,6) = mean(J(:,7)); %HrvPnn50
        FeatureTableMS(i,7) = mean(J(:,8)); %HrvRmssd
        FeatureTableMS(i,8) = mean(J(:,9)); %HrvSd1
        FeatureTableMS(i,9) = mean(J(:,10)); %HrvSd2
        FeatureTableMS(i,10) = mean(J(:,11)); %HrvSd2Sd1
        FeatureTableMS(i,11) = mean(J(:,12)); %HrvSdnn
        FeatureTableMS(i,12) = mean(J(:,13)); %HrvSdsd
        FeatureTableMS(i,13) = mean(J(:,17)); %EYELIDOPENING
        FeatureTableMS(i,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        FeatureTableMS(i,15) = var(J(:,2)); %ECG
        FeatureTableMS(i,16) = var(J(:,17)); %EYELIDOPENING
        FeatureTableMS(i,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER
        
        % brute force feature extraction
            % means of derivates
            FeatureTableMS(i,18) = mean(diff(J(:,2))); % dECG
            FeatureTableMS(i,19) = mean(diff(J(:,2),2)); % d2ECG
            FeatureTableMS(i,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            FeatureTableMS(i,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            FeatureTableMS(i,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            FeatureTableMS(i,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            FeatureTableMS(i,24) = skewness(diff(J(:,2))); % dECG
            FeatureTableMS(i,25) = skewness(diff(J(:,2),2)); % d2ECG
            FeatureTableMS(i,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            FeatureTableMS(i,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            FeatureTableMS(i,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            FeatureTableMS(i,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            FeatureTableMS(i,30) = kurtosis(diff(J(:,2))); % dECG
            FeatureTableMS(i,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            FeatureTableMS(i,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            FeatureTableMS(i,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            FeatureTableMS(i,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            FeatureTableMS(i,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            FeatureTableMS(i,36) = min(diff(J(:,2))); % dECG
            FeatureTableMS(i,37) = min(diff(J(:,2),2)); % d2ECG
            FeatureTableMS(i,38) = min(diff(J(:,17))); % dEYELIDOPENING
            FeatureTableMS(i,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            FeatureTableMS(i,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            FeatureTableMS(i,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            FeatureTableMS(i,42) = max(diff(J(:,2))); % dECG
            FeatureTableMS(i,43) = max(diff(J(:,2),2)); % d2ECG
            FeatureTableMS(i,44) = max(diff(J(:,17))); % dEYELIDOPENING
            FeatureTableMS(i,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            FeatureTableMS(i,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            FeatureTableMS(i,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            FeatureTableMS(i,48) = mean(periodogram(diff(J(:,2)))); % dECG
            FeatureTableMS(i,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            FeatureTableMS(i,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            FeatureTableMS(i,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            FeatureTableMS(i,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            FeatureTableMS(i,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            FeatureTableMS(i,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            FeatureTableMS(i,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            FeatureTableMS(i,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            FeatureTableMS(i,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            FeatureTableMS(i,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            FeatureTableMS(i,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            FeatureTableMS(i,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            FeatureTableMS(i,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            FeatureTableMS(i,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            FeatureTableMS(i,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            FeatureTableMS(i,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            FeatureTableMS(i,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            FeatureTableMS(i,66) = min(periodogram(diff(J(:,2)))); % dECG
            FeatureTableMS(i,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            FeatureTableMS(i,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            FeatureTableMS(i,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            FeatureTableMS(i,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            FeatureTableMS(i,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            FeatureTableMS(i,72) = max(periodogram(diff(J(:,2)))); % dECG
            FeatureTableMS(i,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            FeatureTableMS(i,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            FeatureTableMS(i,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            FeatureTableMS(i,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            FeatureTableMS(i,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            FeatureTableMS(i,78) = prctile(diff(J(:,2)),5); % dECG
            FeatureTableMS(i,79) = prctile(diff(J(:,2),2),5); % d2ECG
            FeatureTableMS(i,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            FeatureTableMS(i,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            FeatureTableMS(i,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            FeatureTableMS(i,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            FeatureTableMS(i,84) = prctile(diff(J(:,2)),25); % dECG
            FeatureTableMS(i,85) = prctile(diff(J(:,2),2),25); % d2ECG
            FeatureTableMS(i,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            FeatureTableMS(i,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            FeatureTableMS(i,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            FeatureTableMS(i,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            FeatureTableMS(i,90) = prctile(diff(J(:,2)),75); % dECG
            FeatureTableMS(i,91) = prctile(diff(J(:,2),2),75); % d2ECG
            FeatureTableMS(i,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            FeatureTableMS(i,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            FeatureTableMS(i,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            FeatureTableMS(i,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            FeatureTableMS(i,96) = prctile(diff(J(:,2)),95); % dECG
            FeatureTableMS(i,97) = prctile(diff(J(:,2),2),95); % d2ECG
            FeatureTableMS(i,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            FeatureTableMS(i,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            FeatureTableMS(i,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            FeatureTableMS(i,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER

        % label
        FeatureTableMS(i,102) = 1;
        
    end
    
    FeatureTable = FeatureTableMS;
    
%% load Data for non Microsleep interval
    fprintf('Loading non Microsleep data...\n');  
    PATH = 'F:\Processed\Splitted\';
    
    % subjects had different time to microsleep and therefore different
    % driving times, resulting in different amount of intervals before MS.
    % To standarize the reference non microsleep intervals, the smallest
    % needs to be considered (vp029 with 48 intervals)
    % Two intervals per subject are selected after 5min driving = mex - 30
    % and max - 31. The maximal intervals are listed below
   
  %  'vp003_splitted_264_beforeMS.csv' --> 234, 233
  %  'vp008_splitted_435_beforeMS.csv' --> 405, 404
  %  'vp017_splitted_256_beforeMS.csv' --> 226, 225
  %  'vp020_splitted_333_beforeMS.csv' --> 303, 302
  %  'vp023_splitted_331_beforeMS.csv' --> 301, 300
  %  'vp024_splitted_484_beforeMS.csv' --> 454, 453
  %  'vp028_splitted_762_beforeMS.csv' --> 732, 731
  %  'vp029_splitted_48_beforeMS.csv' --> 18, 17
  %  'vp030_splitted_314_beforeMS.csv' --> 286, 285
  %  'vp031_splitted_123_beforeMS.csv' --> 93, 92
  %  'vp032_splitted_237_beforeMS.csv' --> 207, 206

    
    % vp003_234
        file = 'F:\Processed\Splitted\vp003_splitted_234_beforeMS.csv';
    
        F = ones(1,102); %adapt size to number of features + label
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F);
   
        
    % vp003_233
        file = 'F:\Processed\Splitted\vp003_splitted_233_beforeMS.csv';
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F);        
        
      
  % vp008_405
        file = 'F:\Processed\Splitted\vp008_splitted_405_beforeMS.csv';
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F); 
               
 
  % vp008_404
        file = 'F:\Processed\Splitted\vp008_splitted_404_beforeMS.csv';
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F);  
  
  
  % vp017_226
        file = 'F:\Processed\Splitted\vp017_splitted_226_beforeMS.csv';
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F); 

        
  % vp017_225
        file = 'F:\Processed\Splitted\vp017_splitted_225_beforeMS.csv';
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F);
        

  % vp020_303
        file = 'F:\Processed\Splitted\vp020_splitted_303_beforeMS.csv';
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F);  
  

  % vp020_302
        file = 'F:\Processed\Splitted\vp020_splitted_302_beforeMS.csv';
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F); 
        

  % vp023_301
        file = 'F:\Processed\Splitted\vp023_splitted_301_beforeMS.csv';
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F);  
  

  % vp023_300
        file = 'F:\Processed\Splitted\vp023_splitted_300_beforeMS.csv';
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F);   
  

  % vp024_454
        file = 'F:\Processed\Splitted\vp024_splitted_454_beforeMS.csv';
     
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F);  
  

  % vp024_453
        file = 'F:\Processed\Splitted\vp024_splitted_453_beforeMS.csv';
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F);   
  
 
  % vp028_732
        file = 'F:\Processed\Splitted\vp028_splitted_732_beforeMS.csv';
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F);  
  

  % vp028_731
        file = 'F:\Processed\Splitted\vp028_splitted_731_beforeMS.csv';
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F);   
  
  
  % vp029_18
        file = 'F:\Processed\Splitted\vp029_splitted_18_beforeMS.csv';
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F);  
  

  % vp029_17
        file = 'F:\Processed\Splitted\vp029_splitted_17_beforeMS.csv';
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F);   
  

  % vp030_286
        file = 'F:\Processed\Splitted\vp030_splitted_286_beforeMS.csv';
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F); 
  

  % vp030_285
        file = 'F:\Processed\Splitted\vp030_splitted_285_beforeMS.csv';
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F);  
  
 
  % vp031_93
        file = 'F:\Processed\Splitted\vp031_splitted_93_beforeMS.csv';
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F);  
  

  % vp031_92
        file = 'F:\Processed\Splitted\vp031_splitted_92_beforeMS.csv';

        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F); 
  
        
  % vp032_207
        file = 'F:\Processed\Splitted\vp032_splitted_207_beforeMS.csv';
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F);  
  

  % vp032_206
        file = 'F:\Processed\Splitted\vp032_splitted_206_beforeMS.csv';
    
        % read .csv file
        fprintf('loading File ...\n');
        fprintf('Filename: %s', file(23:40));
        fprintf('\n');
        J = dlmread(file);
            
        % calculate features
        % HEADER(TIMELINE, ECG, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        
        % average
        F(1,1) = mean(J(:,2)); %ECG
        F(1,2) = mean(J(:,3)); %HR
        F(1,3) = mean(J(:,4)); %HrvHf
        F(1,4) = mean(J(:,5)); %HrvLf
        F(1,5) = mean(J(:,6)); %HrvLfHf
        F(1,6) = mean(J(:,7)); %HrvPnn50
        F(1,7) = mean(J(:,8)); %HrvRmssd
        F(1,8) = mean(J(:,9)); %HrvSd1
        F(1,9) = mean(J(:,10)); %HrvSd2
        F(1,10) = mean(J(:,11)); %HrvSd2Sd1
        F(1,11) = mean(J(:,12)); %HrvSdnn
        F(1,12) = mean(J(:,13)); %HrvSdsd
        F(1,13) = mean(J(:,17)); %EYELIDOPENING
        F(1,14) = mean(J(:,21)); %FILTEREDPUPILDIAMETER      
        
        % variance 
        F(1,15) = var(J(:,2)); %ECG
        F(1,16) = var(J(:,17)); %EYELIDOPENING
        F(1,17) = var(J(:,21)); %FILTEREDPUPILDIAMETER

        % brute force feature extraction
            % means of derivates
            F(1,18) = mean(diff(J(:,2))); % dECG
            F(1,19) = mean(diff(J(:,2),2)); % d2ECG
            F(1,20) = mean(diff(J(:,17))); % dEYELIDOPENING
            F(1,21) = mean(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,22) = mean(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,23) = mean(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % skewness of derivates
            F(1,24) = skewness(diff(J(:,2))); % dECG
            F(1,25) = skewness(diff(J(:,2),2)); % d2ECG
            F(1,26) = skewness(diff(J(:,17))); % dEYELIDOPENING
            F(1,27) = skewness(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,28) = skewness(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,29) = skewness(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of derivates
            F(1,30) = kurtosis(diff(J(:,2))); % dECG
            F(1,31) = kurtosis(diff(J(:,2),2)); % d2ECG
            F(1,32) = kurtosis(diff(J(:,17))); % dEYELIDOPENING
            F(1,33) = kurtosis(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,34) = kurtosis(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,35) = kurtosis(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % min of derivates
            F(1,36) = min(diff(J(:,2))); % dECG
            F(1,37) = min(diff(J(:,2),2)); % d2ECG
            F(1,38) = min(diff(J(:,17))); % dEYELIDOPENING
            F(1,39) = min(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,40) = min(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,41) = min(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % max of derivates
            F(1,42) = max(diff(J(:,2))); % dECG
            F(1,43) = max(diff(J(:,2),2)); % d2ECG
            F(1,44) = max(diff(J(:,17))); % dEYELIDOPENING
            F(1,45) = max(diff(J(:,17),2)); % d2EYELIDOPENING
            F(1,46) = max(diff(J(:,21))); % dFILTEREDPUPILDIAMETER
            F(1,47) = max(diff(J(:,21),2)); % d2FILTEREDPUPILDIAMETER
            
            % means of periodogram power spectral density
            F(1,48) = mean(periodogram(diff(J(:,2)))); % dECG
            F(1,49) = mean(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,50) = mean(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,51) = mean(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,52) = mean(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,53) = mean(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % skewness of periodogram power spectral density
            F(1,54) = skewness(periodogram(diff(J(:,2)))); % dECG
            F(1,55) = skewness(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,56) = skewness(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,57) = skewness(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,58) = skewness(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,59) = skewness(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER 
            
            % kurtosis of periodogram power spectral density
            F(1,60) = kurtosis(periodogram(diff(J(:,2)))); % dECG
            F(1,61) = kurtosis(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,62) = kurtosis(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,63) = kurtosis(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,64) = kurtosis(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,65) = kurtosis(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % min of periodogram power spectral density
            F(1,66) = min(periodogram(diff(J(:,2)))); % dECG
            F(1,67) = min(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,68) = min(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,69) = min(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,70) = min(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,71) = min(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % max of periodogram power spectral density
            F(1,72) = max(periodogram(diff(J(:,2)))); % dECG
            F(1,73) = max(periodogram(diff(J(:,2),2))); % d2ECG
            F(1,74) = max(periodogram(diff(J(:,17)))); % dEYELIDOPENING
            F(1,75) = max(periodogram(diff(J(:,17),2))); % d2EYELIDOPENING
            F(1,76) = max(periodogram(diff(J(:,21)))); % dFILTEREDPUPILDIAMETER
            F(1,77) = max(periodogram(diff(J(:,21),2))); % d2FILTEREDPUPILDIAMETER
            
            % 5 percentile of derivates
            F(1,78) = prctile(diff(J(:,2)),5); % dECG
            F(1,79) = prctile(diff(J(:,2),2),5); % d2ECG
            F(1,80) = prctile(diff(J(:,17)),5); % dEYELIDOPENING
            F(1,81) = prctile(diff(J(:,17),2),5); % d2EYELIDOPENING
            F(1,82) = prctile(diff(J(:,21)),5); % dFILTEREDPUPILDIAMETER
            F(1,83) = prctile(diff(J(:,21),2),5); % d2FILTEREDPUPILDIAMETER
            
            % 25 percentile of derivates
            F(1,84) = prctile(diff(J(:,2)),25); % dECG
            F(1,85) = prctile(diff(J(:,2),2),25); % d2ECG
            F(1,86) = prctile(diff(J(:,17)),25); % dEYELIDOPENING
            F(1,87) = prctile(diff(J(:,17),2),25); % d2EYELIDOPENING
            F(1,88) = prctile(diff(J(:,21)),25); % dFILTEREDPUPILDIAMETER
            F(1,89) = prctile(diff(J(:,21),2),25); % d2FILTEREDPUPILDIAMETER
            
            % 75 percentile of derivates
            F(1,90) = prctile(diff(J(:,2)),75); % dECG
            F(1,91) = prctile(diff(J(:,2),2),75); % d2ECG
            F(1,92) = prctile(diff(J(:,17)),75); % dEYELIDOPENING
            F(1,93) = prctile(diff(J(:,17),2),75); % d2EYELIDOPENING
            F(1,94) = prctile(diff(J(:,21)),75); % dFILTEREDPUPILDIAMETER
            F(1,95) = prctile(diff(J(:,21),2),75); % d2FILTEREDPUPILDIAMETER
            
            % 95 percentile of derivates
            F(1,96) = prctile(diff(J(:,2)),95); % dECG
            F(1,97) = prctile(diff(J(:,2),2),95); % d2ECG
            F(1,98) = prctile(diff(J(:,17)),95); % dEYELIDOPENING
            F(1,99) = prctile(diff(J(:,17),2),95); % d2EYELIDOPENING
            F(1,100) = prctile(diff(J(:,21)),95); % dFILTEREDPUPILDIAMETER
            F(1,101) = prctile(diff(J(:,21),2),95); % d2FILTEREDPUPILDIAMETER
            
        
        % label
        F(1,102) = 0;

        FeatureTable = vertcat(FeatureTable, F);         
        
        % write to csv
        fprintf('Writing file...\n');
        CSVfile = strcat('F:\Processed\','feature array','.csv');%where to store the outputs...
        dlmwrite(CSVfile, FeatureTable,'precision','%10.5f');%missing header
        fprintf('Done! ');
        
%% generate feature Table

FeatureTable  = array2table(FeatureTable);       
FeatureTable.Properties.VariableNames = {'meanECG' 'HR' 'HrvHf' 'HrvLf' 'HrvLfHf' 'HrvPnn50' 'HrvRmssd' 'HrvSd1' 'HrvSd2' 'HrvSd2Sd1' 'HrvSdnn' 'HrvSdsd' 'meanEYELIDOPENING' 'meanFILTEREDPUPILDIAMETER' 'varECG' 'varEYELIDOPENING' 'varFILTEREDPUPILDIAMETER' 'meandECG' 'meand2ECG' 'meandEYELIDOPENING' 'meand2EYELIDOPENING' 'meandFILTEREDPUPILDIAMETER' 'meand2FILTEREDPUPILDIAMETER' 'skwdECG' 'skwd2ECG' 'skwdEYELIDOPENING' 'skwd2EYELIDOPENING' 'skwdFILTEREDPUPILDIAMETER' 'skwd2FILTEREDPUPILDIAMETER' 'kurtdECG' 'kurtd2ECG' 'kurtdEYELIDOPENING' 'kurtd2EYELIDOPENING' 'kurtdFILTEREDPUPILDIAMETER' 'kurtd2FILTEREDPUPILDIAMETER' 'mindECG' 'mind2ECG' 'mindEYELIDOPENING' 'mind2EYELIDOPENING' 'mindFILTEREDPUPILDIAMETER' 'mind2FILTEREDPUPILDIAMETER' 'maxdECG' 'maxd2ECG' 'maxdEYELIDOPENING' 'maxd2EYELIDOPENING' 'maxdFILTEREDPUPILDIAMETER' 'maxd2FILTEREDPUPILDIAMETER'  'meanPSDdECG' 'meanPSDd2ECG' 'meanPSDdEYELIDOPENING' 'meanPSDd2EYELIDOPENING' 'meanPSDdFILTEREDPUPILDIAMETER' 'meanPSDd2FILTEREDPUPILDIAMETER' 'skwPSDdECG' 'skwPSDd2ECG' 'skwPSDdEYELIDOPENING' 'skwPSDd2EYELIDOPENING' 'skwPSDdFILTEREDPUPILDIAMETER' 'skwPSDd2FILTEREDPUPILDIAMETER' 'kurtPSDdECG' 'kurtPSDd2ECG' 'kurtPSDdEYELIDOPENING' 'kurtPSDd2EYELIDOPENING' 'kurtPSDdFILTEREDPUPILDIAMETER' 'kurtPSDd2FILTEREDPUPILDIAMETER' 'minPSDdECG' 'minPSDd2ECG' 'minPSDdEYELIDOPENING' 'minPSDd2EYELIDOPENING' 'minPSDdFILTEREDPUPILDIAMETER' 'minPSDd2FILTEREDPUPILDIAMETER' 'maxPSDdECG' 'maxPSDd2ECG' 'maxPSDdEYELIDOPENING' 'maxPSDd2EYELIDOPENING' 'maxPSDdFILTEREDPUPILDIAMETER' 'maxPSDd2FILTEREDPUPILDIAMETER' 'prct5dECG' 'prct5d2ECG' 'prct5dEYELIDOPENING' 'prct5d2EYELIDOPENING' 'prct5dFILTEREDPUPILDIAMETER' 'prct5d2FILTEREDPUPILDIAMETER' 'prct25dECG' 'prct25d2ECG' 'prct25dEYELIDOPENING' 'prct25d2EYELIDOPENING' 'prct25dFILTEREDPUPILDIAMETER' 'prct25d2FILTEREDPUPILDIAMETER' 'prct75dECG' 'prct75d2ECG' 'prct75dEYELIDOPENING' 'prct75d2EYELIDOPENING' 'prct75dFILTEREDPUPILDIAMETER' 'prct75d2FILTEREDPUPILDIAMETER' 'prct95dECG' 'prct95d2ECG' 'prct95dEYELIDOPENING' 'prct95d2EYELIDOPENING' 'prct95dFILTEREDPUPILDIAMETER' 'prct95d2FILTEREDPUPILDIAMETER' 'Microsleep'};
writetable(FeatureTable,'F:\Processed\FeatureTable.csv');


