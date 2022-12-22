%---------------------------------------------------------
%SmartEye Processing for
%MultiModalBioSignalAnalysis MMBSA
%Bachelor Thesis Guillermo Hidalgo Gadea 
%Fatigue detection based on multimodal biosignal analysis
%---------------------------------------------------------
    
    %% load Metadata for StartDriving and Microsleep
    clc;
    FILENAME = 'F:\Recordings\MetaData\MetaData.xlsx';
    DELIMITER = '\t';
    [num, txt, raw] = xlsread(FILENAME);
    METADATA = raw;
    SUBJECTS = raw(:,1);
   
    %% SmartEye
    fprintf('Reading SmartEye Files... \n');
    PATH = 'F:\Recordings\SmartEyePro\forMatlab\';%changed for testing
    files = dir('F:\Recordings\SmartEyePro\forMatlab\*.log');%changed for testing
    files = strvcat(files.name);
    x = size(files);
    for i = 1:x(1)
        %start timer
        tic
        
        %read .log file
        FILE = [PATH files(i,:)];
        [a,name,b] = fileparts(FILE);
        fprintf('Filenumber: %d', i);
        fprintf('\n'); 
        fprintf('Filename: %s', name);
        fprintf('\n');      
        A = dlmread(FILE, DELIMITER, 1,0);
        
        %separate colums
        fprintf('Seperating Data...\n');
        FRAMENUMBER = A(:,1);
        TIMESTAMP = A(:,2);
        FRAMERATE = A(:,4);
        EYELIDOPENING = A(:,6);
        EYELIDOPENINGQ = A(:,7);
        PUPILDIAMETER = A(:,23);
        PUPILDIAMETERQ  = A(:,24);
        FILTEREDPUPILDIAMETER = A(:,29);
        FILTEREDPUPILDIAMETERQ = A(:,30);
        
        %calculate time vector with seconds since start
        fprintf('Creating Timeline...\n');
        SECONDSSINCESTART = zeros(size(TIMESTAMP)); %generates placeholder array
        for j = 2:size(TIMESTAMP,1)
            SECONDSSINCESTART(j)= [(TIMESTAMP(j)-TIMESTAMP(1))*10^-7]; %replaces elements in array with differences from Timestamp
        end
        
        %take StartTime from filename
        fprintf('Adjusting Timeline...\n');
        STARTTIME = sscanf(name(10:15),'%s'); %get starting Time from filename
        STARTTIME = num2str(STARTTIME);
        HOURS  = str2num(sscanf(STARTTIME(1:2), '%s')); %extract HOURS from Filename
        MINUTES = str2num(sscanf(STARTTIME(3:4), '%s')); %extract MINUTES from Filename
        SECONDS = str2num(sscanf(STARTTIME(5:6), '%s')); %extract SECONDS from Filename
        STARTTIME = HOURS*60*60+MINUTES*60+SECONDS; %create STARTTIME scalar in seconds
        
        %create Timeline 
        TIME = STARTTIME + SECONDSSINCESTART; %add scalar to vector SECONDSSINCESTART
        
        % create Matrix
        fprintf('Creating Matrix...\n');
        B = horzcat(TIME, TIMESTAMP, FRAMENUMBER, FRAMERATE, EYELIDOPENING, EYELIDOPENINGQ, PUPILDIAMETER, PUPILDIAMETERQ, FILTEREDPUPILDIAMETER, FILTEREDPUPILDIAMETERQ);
        BHEADER = 'TIME TIMESTAMP FRAMENUMBER FRAMERATE EYELIDOPENING EYELIDOPENINGQ PUPILDIAMETER PUPILDIAMETERQ FILTEREDPUPILDIAMETER FILTEREDPUPILDIAMETERQ';
        
        %get start driving from MetaData
        SUBJECT = strcmp(name(end-4:end), SUBJECTS); %search subject name in MetaData
        SUBJECTROW = find(SUBJECT == 1);
        STARTDRIVINGTIME = METADATA{SUBJECTROW,3};
        ENDDRIVINGTIME  = METADATA{SUBJECTROW,4};

        %find STARTDRIVINGTIME and ENDDRIVINGTIME in Timeline
        TIME1 = find(TIME <= STARTDRIVINGTIME); %if no direct match, find next best measurement
        TIME1 = max(TIME1); % find element directly before STARTDRIVINGTIME
        if STARTDRIVINGTIME < TIME(1) %in cases recording starts after STARTDRIVING or stops bejore ENDDRIVING
           TIME1 = TIME(1); 
        end
        TIME2 = find(TIME >= ENDDRIVINGTIME); %if no direct match, find next best measurement
        TIME2= min(TIME2); % find element directly after ENDDRIVINGTIME      
        if ENDDRIVINGTIME > TIME(end) %in cases recording starts after STARTDRIVING or stops bejore ENDDRIVING
           TIME2 = TIME(end); 
        end
        
        %cut Matrix
        B  = B(TIME1:TIME2,:);

        %write to csv
        fprintf('Writing file...\n');
        CSVfile = strcat('F:\Processed\Test\',name(end-4:end),'_pupil_eyelid','.csv');%where to store the outputs...
        dlmwrite(CSVfile, B,'precision','%10.5f');%missing header
        fprintf('Done! ');
        
        %elapsed time in loop
        toc
        
        %clear variables after loop
        clearvars -except i PATH files x DELIMITER METADATA SUBJECTS
        
    end  
    
    fprintf('Data Processing completed!');
