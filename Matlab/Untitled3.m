  

PATH = 'F:\Processed\Splitted\';
    
% search directory for subjects 
  files = dir('F:\Processed\Splitted\*.csv');
  files = strvcat(files.name);

  newfiles = files(:,3:5);
  
  for i = 1:size(newfiles)
  newfiles(i) = newfiles(i+1)
  continue
  newfiles(i) =
  end
  
  