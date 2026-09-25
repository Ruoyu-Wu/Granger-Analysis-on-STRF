
function f001_MAIN_run_analysis(data_dir,granger_code_path,Functions_path)
% RUN_SUBSAMPLING_ANALYSIS Main function to run subsampling analysis across all files
% Inputs:
%   data_dir: Directory containing the .mat files
%   granger_code_path: Path to GrangerBox/GrangerCode folder - main
%   analysis code
%   Functions_path: Path to helper functions

arguments
 data_dir = "/data/by-user/Ruoyu/SPKbinaryMat/";
 granger_code_path = "/data/by-user/Ruoyu/Granger_Code/";
 Functions_path = "/data/by-user/Ruoyu/Functions/";
end

addpath(genpath(granger_code_path));
addpath(genpath(Functions_path));

%% make modifications here to specify what analysis to run

% 1. which stimuli conditions to include:
suffixes = ["A-hit", "AV-hit", "V-CR", "A-miss", "AV-miss"];
% suffixes = ["AV-hit","A-hit"];

% 2. which sample size adjustment method to use:
analysis_spec = @f102_STRF_SNR;
analysis_name = 'on_STRF_SNR';

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
    
    % Initialize container for this suffix
    results.(sprintf('suffix_%s', strrep(suffix, '-', '_'))) = struct();
    
    % Process each file
    for f = 1:length(files)
        results = struct();
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
        % file_results = analyze_file_data_withSNR(data, STRFsig, snr, files(f).name,rep);
        file_results = analysis_spec(data,STRFsig,snr,files(f).name,rep);
        
        % Store results
%         results.(sprintf('suffix_%s', strrep(suffix, '-', '_'))).(sprintf('file_%d', f)) = file_results;
%         results.(sprintf('suffix_%s', strrep(suffix, '-', '_'))).(sprintf('file_%d', f)).filename = files(f).name;
%         suffix_field = strrep(suffix, '-', '_');
%         results.(suffix_field).(sprintf('file_%d', f)).filepath = filepath;
        % Save final results
        results_path = sprintf('%s_%s_%s_results.mat',data_dir,files(f).name, analysis_name);
        genpath(results_path)
        save(results_path, 'file_results');
        fprintf('\nResults saved to: %s\n', fullfile(data_dir, results_path));
    end
end
end