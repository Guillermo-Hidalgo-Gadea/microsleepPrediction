%---------------------------------------------------------
%Movisens Processing for
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
    
    %% Movisens HRV 
    fprintf('Reading Movisens Files...\n');
    PATH = 'F:\Recordings\HeartRate\forMatlab\';
    folders = dir(PATH);
    folders = strvcat(folders.name);
    x = size(folders);
    for i = 3:x(1) %first outputs . and .. so start with 3
        %start timer
        tic
        
        %look for XML in folders
        PATHi = strcat(PATH, folders(i,:), '\*.xml');
        files = dir(PATHi);
        files = strvcat(files.name);
        PATHi = strcat(PATH, folders(i,:), '\', files);
        
        %folder beeing alanyzed
        name = folders(i,:);
        fprintf('Filenumber: %d', i-2);
        fprintf('\n');
        fprintf('Filename: %s', name);
        fprintf('\n');
        
        %get ecg starttime and samplerate 
        fprintf('Creating Timeline...\n');
        CLOCK = unisens_get_timestampstart(PATHi);
        HOURS = CLOCK(4);
        MINUTES = CLOCK(5);
        SECONDS = CLOCK(6);
        STARTTIME = SECONDS + MINUTES*60 + HOURS*60*60;
        SAMPLERATE = unisens_get_samplerate(PATHi, 'ecg.bin');        
        
        %get start driving from MetaData
        SUBJECT = strcmp(name(end-9:end-5), SUBJECTS); %search subject name in MetaData
        SUBJECTROW = find(SUBJECT == 1);
        STARTDRIVINGTIME = METADATA{SUBJECTROW,3};
        ENDDRIVINGTIME  = METADATA{SUBJECTROW,4};
        
        %get ecg data
        DRIVINGTIME = ENDDRIVINGTIME - STARTDRIVINGTIME; %driving time in seconds
        POS = (STARTDRIVINGTIME - STARTTIME) * SAMPLERATE; %difference between recording start and start driving in seconds multiplied by samplerate equals measurement number
        LENGHT = DRIVINGTIME * SAMPLERATE; %number of measures equals driving time multiplied by measures/second
        RANGE = [POS, LENGHT];
        C = unisens_get_data(PATHi,'ecg.bin', RANGE);
        
        %create Timeline
        TIME = C;
        for j = 1:LENGHT
            TIME(j) = [STARTDRIVINGTIME + j/1024];
        end
        
        % create Matrix
        D = horzcat(TIME, C);
        DHEADER = 'TIME ecg';
        
        %write to csv
        fprintf('Writing file...\n');
        CSVfile = strcat('F:\Processed\Movisens\',name(end-9:end-5),'_ecg','.csv');%where to store the outputs...
        dlmwrite(CSVfile, D,'precision','%10.5f'); %missing header
        fprintf('Done!\n');
        
        %look for XLSX in folders
        PATHj = strcat(PATH, folders(i,:), '\*.xlsx');
        files = dir(PATHj);
        files = strvcat(files.name);
        PATHj = strcat(PATH, folders(i,:), '\', files);
        
        %folder beeing alanyzed
        name = folders(i,:);
        fprintf('Filenumber: %d', i-2);
        fprintf('\n');
        fprintf('Filename: %s', name);
        fprintf('\n');
        
        %get hrv data
        [num, txt, raw] = xlsread(PATHj);
        DATE = datestr(num(:,5));
        CLOCK = DATE(:,13:20);
        x = datetime(CLOCK);
        [h,m,s] = hms(x);
        TIME = s+m*60+h*60*60; %TIME is Timeline in seconds
        
        %extract relevant Parameters analyzed by movisens
        HR = num(:,10);
        HrvHf = num(:,11);
        HrvLf = num(:,12);
        HrvLfHf = num(:,13);
        HrvPnn50 = num(:,14);
        HrvRmssd = num(:,15);
        HrvSd1 = num(:,16);
        HrvSd2 = num(:,17);
        HrvSd2Sd1 = num(:,18);
        HrvSdnn = num(:,19);
        HrvSdsd = num(:,20);

        %create matrix
        HRV = horzcat(TIME, HR, HrvHf, HrvLf, HrvLfHf, HrvPnn50, HrvRmssd, HrvSd1, HrvSd2, HrvSd2Sd1, HrvSdnn, HrvSdsd);
        
        % get start driving from MetaData
        SUBJECT = strcmp(name(end-9:end-5), SUBJECTS); %search subject name in MetaData
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
        
        %cut matrix
        HRV = HRV(TIME1:TIME2,:); %Matrix contains NaN, use ~(isnan(HRV)) for later calculations
        
        %write to csv
        fprintf('Writing file...\n');
        CSVfile = strcat('F:\Processed\MovisensAnalyzer\',name(end-9:end-5),'_hrv','.csv');%where to store the outputs...
        dlmwrite(CSVfile, HRV,'precision','%10.5f'); %missing header
        fprintf('Done!\n');
        
        %elapsed time in loop
        toc
        
        %clear variables after loop
        clearvars -except i PATH folders x DELIMITER METADATA SUBJECTS
        
    end
    
    fprintf('Data Processing completed!');
