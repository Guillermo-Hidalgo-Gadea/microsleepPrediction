%---------------------------------------------------------
%Cleaning Files for 
%MultiModalBioSignalAnalysis MMBSA
%Bachelor Thesis Guillermo Hidalgo Gadea 
%Fatigue detection based on multimodal biosignal analysis
%---------------------------------------------------------

            
    %% load Data 
    clear all
    clc
    fprintf('cleaning data...\n');
    PATH = 'E:\Processed\mergedData\';
    
    %search directory for subjects 
    files = dir('E:\Processed\mergedData\*.csv');
    files = strvcat(files.name);
    x = size(files);
    for i = 1:x(1)
        %start timer
        tic
        
        %read .csv file
        FILE = [PATH files(i,:)];
        [a,name,b] = fileparts(FILE);
        fprintf('loading File ...');
        fprintf('\n'); 
        fprintf('Filename: %s', name);
        fprintf('\n');
        J = dlmread(FILE);
        
        %Cleaning: what needs to be removed?? 
        fprintf('Removing Invalid Data...\n');
        [r,c] = size(J);
        for i = 1:c
            B(find(B(:,i) == 0),:) = [];
        end       
     

        %write to csv
        fprintf('Writing to file...\n');
        dlmwrite('condensed.csv',B,'precision','%10.5f',1,0);%missing header, check deliminator, filepath...
        fprintf('Done!\n');
        
        %elapsed time in loop
        toc
        
    end
    
    %clear variables after block
    
%% Exploratory Parameter Analysis
    %(1)split up in analysis intervals
    %(2)classify intervals (Database)
    %(3)calculate X parameters
    %(4)get significant parameters in T-tests
    
%% brute force feature extraction
    %OpenSmile LLD
    %OpenXbow BoW
    
%% classified Database for machine learning
    %get classified intervals
    %calculate all stated parameters
    %training set // test set
    
%% moving time window analysis
    %(1)get interval
    %(2)calculate parameters
    %(3)classify
    %(4)move time window
    %(5)go to (1)
    
%% GUI, want to have it fancy
    %(1)choose file to be analyzed?
    %(2)choose parameters?
    %...
    
    %Output
        %(1)live analysis
        %(2)MS found in hh:mm:ss.ms
    
    
    