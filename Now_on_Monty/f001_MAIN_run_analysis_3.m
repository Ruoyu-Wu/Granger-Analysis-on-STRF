
function f001_MAIN_run_analysis_3(data_dir,results_dir,granger_code_path,Functions_path)
% RUN_SUBSAMPLING_ANALYSIS Main function to run subsampling analysis across all files
% Inputs:
%   data_dir: Directory containing the .mat files
%   granger_code_path: Path to GrangerBox/GrangerCode folder - main
%   analysis code
%   Functions_path: Path to helper functions

arguments
 data_dir = "/Users/wuruoyu/Documents/Granger_MSThesis/data/SPKbinaryMat";
 results_dir = "/Users/wuruoyu/Documents/Granger_MSThesis/data/unverified/analysis_temporary";
 granger_code_path = "TestCode";
 Functions_path = "Now_on_Monty";
end

addpath(genpath(granger_code_path));
addpath(genpath(results_dir));
addpath(genpath(Functions_path));

%% make modifications here to specify what analysis to run

% 1. which stimuli conditions to include:
suffixes = ["AV-hit","A-hit", "A-miss", "AV-miss"];%,"V-CR"

% 2. which sample size adjustment method to use:
analysis_spec = @f101_STRF;
analysis_name = 'on_STRF';

% 3. specify how many repetitions
rep = 1;

%% main body (no need to change)

for s = 1:length(suffixes)
    suffix = suffixes{s};
    fprintf('\nProcessing suffix: %s\n', suffix);
    
    % Find all files with current suffix
    pattern = sprintf("*%s*.mat", suffix);
    files = dir(fullfile(data_dir, pattern));
    
    if isempty(files)
        fprintf('No files found for suffix: %s\n', suffix);
        continue;
    end
    
    
    % Process each file
    for f = 1:length(files)
        filepath = fullfile(files(f).folder, files(f).name);
        fprintf('  Processing file %d/%d: %s\n', f, length(files), files(f).name);
        loaded_data = load(filepath);
        
        % Extract relevant fields (adjust field names based on your data structure)
        if isfield(loaded_data, 'data')
            data = loaded_data.data;
        else
            % Try common variable names
            vars = fieldnames(loaded_data);
            data = loaded_data.(vars{1}); % Assume first variable is the data
        end
        
        % Get STRFsig and snr (adjust field names as needed)
        if isfield(loaded_data, 'STRFsig')
            STRFsig = loaded_data.STRFsig;
        else
            error('STRFsig not found in file: %s', files(f).name);
        end
        
        if isfield(loaded_data, 'snr')
            snr = loaded_data.snr;
        else
            error('snr not found in file: %s', files(f).name);
        end
        
        % Run analysis for this file
          file_results = analysis_spec(data,STRFsig,snr,files(f).name,rep);

        % Save final results
        results_name = sprintf("%s_%s_results.mat",extractBefore(files(f).name,'.mat'), analysis_name);
        save(fullfile(results_dir,results_name), 'file_results');
        fprintf('\nResults saved to: %s\n', fullfile(results_dir, results_name));
    end
end
end