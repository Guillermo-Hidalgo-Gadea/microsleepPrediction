%---------------------------------------------------------
%Splitting Files for 
%MultiModalBioSignalAnalysis MMBSA
%Bachelor Thesis Guillermo Hidalgo Gadea 
%Fatigue detection based on multimodal biosignal analysis
%---------------------------------------------------------

%% load Metadata for StartDriving and Microsleep
    clc;
    fprintf('Loading MetaData \n');
    FILENAME = 'F:\Recordings\MetaData\MetaData.xlsx';
    DELIMITER = '\t';
    [num, txt, raw] = xlsread(FILENAME);
    METADATA = raw;
    SUBJECTS = raw(:,1);
    
%% load merged Data 
    PATH = 'F:\Processed\Merged\';
    
    %search directory for subjects 
    files = dir('F:\Processed\Merged\*.csv');
    files = strvcat(files.name);
    x = size(files);
    for i = 1:x(1)
        %start timer
        tic
        
        %read .csv file
        FILE = [PATH files(i,:)];
        [a,name,b] = fileparts(FILE);
        fprintf('Loading File ...\n');
        fprintf('Filename: %s', name);
        fprintf('\n');
        J = dlmread(FILE);
        TIME = J(:,1);
        
        %find Microsleep from MetaData
        fprintf('Calculating Microsleep ...\n');
        SUBJECT = strcmp(name(1:5), SUBJECTS); %search subject name in MetaData
        SUBJECTROW = find(SUBJECT == 1); %find row number in binary logical array
        STARTMICROSLEEP = num(SUBJECTROW-1,3); % -1 shift in row and -2 shift in column between num and raw 
        ENDMICROSLEEP  = num(SUBJECTROW-1,4);
        START = max(find(TIME <= STARTMICROSLEEP)); %array index, not time
        END = max(find(TIME <= ENDMICROSLEEP));
        
        %Define Intervals
        INTERVAL = 10; %set Interval lenght in seconds
        INTERVALLENGHT = INTERVAL * 100; %100Hz Framerate
        MICROSLEEPTIME = END - START; %mean = 2, max = 6
        %Microsleep interval of lenght INTERVAL with equal add-ons befor STARTMICROSLEEP and after ENDMICROSLEEP
        ADDON = (INTERVALLENGHT - MICROSLEEPTIME)/2;
        START = START - ADDON;
        END = END + ADDON;
        fprintf('Splitting Intervals ...\n');
        %get Microsleep INterval
        K = J(START:END,:);
        
        %write to csv
        CSVfile = strcat('F:\Processed\Splitted\',name(1:5),'_splitted_MS','.csv');
        dlmwrite(CSVfile, K,'precision','%10.5f');%missing header
        
        %splitt file in non MS Intervals
        x = fix(START / INTERVALLENGHT); %integer amount of non MS intervals before MS interval; few first elements at very beginning of recording may be lost...
        set = 1;
        for i = 1:x
            K = J(START-INTERVALLENGHT:START,:);
            START = START - INTERVALLENGHT;
            set = num2str(set);
            CSVfile = strcat('F:\Processed\Splitted\',name(1:5),'_splitted_',set ,'_beforeMS','.csv');
            dlmwrite(CSVfile, K,'precision','%10.5f');%missing header
            set = str2num(set);
            set = set + 1;
        end
        
        fprintf('Done!\n');
        %elapsed time in loop
        toc
        
    end
    fprintf('Data Splitting completed!');
    