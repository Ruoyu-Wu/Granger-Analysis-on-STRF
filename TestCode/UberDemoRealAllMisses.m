
%uber demo_real
clear all

addpath '/Users/yalecohen/Library/CloudStorage/Dropbox/yec/DataAnalysis/Granger/SPKbinaryMat/Misses'
fn=dir('SpkBinaryMat/Misses');
for(i=1:length(fn))
  currfile=fn(i).name;
  if ~isempty(findstr('Wu', currfile)) ||  ~isempty(findstr('Elay', currfile))
  % only do MISS files at coo onset...
  disp(['running ' currfile])
  eval(['load ' currfile])
  demo_real(data,snr,currfile);
  end %if
end

