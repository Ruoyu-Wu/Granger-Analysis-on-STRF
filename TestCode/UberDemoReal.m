
%uber demo_real
clear all

addpath '/Users/yalecohen/Library/CloudStorage/Dropbox/yec/DataAnalysis/Granger/SPKbinaryMat2'
fn=dir('SpkBinaryMat2');
for(i=1:length(fn))
  currfile=fn(i).name;
  if ~isempty(findstr('Elay', currfile)) && ~isempty(findstr('hit',currfile)) && ~isempty(findstr(['cooOnset'],currfile))
  % only do Elay files at coo onset...
  disp(['running ' currfile])
  eval(['load ' currfile])
  demo_real(data,snr,STRFsig,currfile);
  end %if
end

