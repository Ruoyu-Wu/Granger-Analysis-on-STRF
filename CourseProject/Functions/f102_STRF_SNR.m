function file_results = f102_STRF_SNR(data, STRFsig, snr, filename,rep)
%(data,STRFsig,snr,files(f).name,rep)
% ANALYZE_FILE_DATA Perform subsampling analysis on a single file
% Returns structured results for the file

% Identify STRF and nSTRF neurons
STRF_idx = find(STRFsig == 1);
nSTRF_idx = find(STRFsig == 0);

% Identify Hard and Easy trials
Hard_idx = find(snr == -20 | snr == -15 | snr == -10 | snr == -5);
Easy_idx = find(snr == 20 | snr == 15 | snr == 10 | snr == 5 | snr == 0);

% Extract data subsets
HardSTRF = data(STRF_idx, :, Hard_idx);
EasySTRF = data(STRF_idx, :, Easy_idx);
HardnSTRF = data(nSTRF_idx, :, Hard_idx);
EasynSTRF = data(nSTRF_idx, :, Easy_idx);


% Initialize results structure for this file
file_results = struct();
file_results.n_STRF = length(STRF_idx);
file_results.n_nSTRF = length(nSTRF_idx);
file_results.n_Hard_trials = length(Hard_idx);
file_results.n_Easy_trials = length(Easy_idx);

% Run analyses for each condition (Hard and Easy)
conditions = {'Hard', 'Easy'};
condition_data = {HardSTRF, EasySTRF};
condition_n_data = {HardnSTRF, EasynSTRF};

for c = 1:length(conditions)
    cond_name = conditions{c};
    X_STRF = condition_data{c};
    X_nSTRF = condition_n_data{c};
    
    fprintf('    Analyzing %s condition\n', cond_name);
    
    % 1. STRF self-analysis
    if ~isempty(STRF_idx) && length(STRF_idx) >= 2
        file_results.(cond_name).STRF_self = f002_run_causal_analysis(X_STRF, rep); % 5 repetitions
    else
        file_results.(cond_name).STRF_self = [];
    end
    
    % 2. nSTRF self-analysis
    if ~isempty(nSTRF_idx) && length(nSTRF_idx) >= 2
        file_results.(cond_name).nSTRF_self = f002_run_causal_analysis(X_nSTRF, rep);
    else
        file_results.(cond_name).nSTRF_self = [];
    end
    
    % 3. STRF vs nSTRF subsampled analysis
    if ~isempty(STRF_idx) && ~isempty(nSTRF_idx) && length(STRF_idx) >= 2 && length(nSTRF_idx) >= 2
        % Determine which group has more neurons
        if length(STRF_idx) > length(nSTRF_idx)
            larger_group = 'STRF';
            n_subsample = length(nSTRF_idx); % Subsample to match smaller group
            larger_data = X_STRF;
            smaller_data = X_nSTRF;
            larger_indices = STRF_idx;
        else
            larger_group = 'nSTRF';
            n_subsample = length(STRF_idx);
            larger_data = X_nSTRF;
            smaller_data = X_STRF;
            larger_indices = nSTRF_idx;
        end
        
        % Run subsampling analysis for all possible combinations
        fprintf('      Running subsampling analysis (%s larger, subsampling to %d neurons)\n', ...
            larger_group, n_subsample);
        
        % Get all possible combinations
        n_total = size(larger_data, 1);
        all_combinations = nchoosek(1:n_total, n_subsample);
        n_combinations = size(all_combinations, 1);
        
        % Limit combinations if too many (optional)
        max_combinations = 100;
        if n_combinations > max_combinations
            fprintf('        Too many combinations (%d), randomly sampling %d\n', ...
                n_combinations, max_combinations);
            % Randomly select combinations
            rand_indices = randperm(n_combinations, max_combinations);
            all_combinations = all_combinations(rand_indices, :);
            n_combinations = max_combinations;
        end
        
        % Initialize results storage
        subsample_results = cell(n_combinations, 1);
        
        % Run for each subsample combination
        for combo = 1:n_combinations
            if mod(combo, 10) == 0
                fprintf('        Processing combination %d/%d\n', combo, n_combinations);
            end
            
            % Subsample the larger group
            subsampled_data = larger_data(all_combinations(combo, :), :, :);
            
            % Combine with smaller group
            combined_data = cat(1, subsampled_data, smaller_data);
            
            % Create group labels (1 for larger group subsample, 2 for smaller group)
            group_labels = [ones(n_subsample, 1); 2 * ones(size(smaller_data, 1), 1)];
            
            % Run causal analysis on combined data
            combo_result = f002_run_causal_analysis(combined_data, 1); % Single run for each combo
            combo_result.group_labels = group_labels;
            combo_result.subsample_indices = all_combinations(combo, :);
            
            subsample_results{combo} = combo_result;
        end
        
        file_results.(cond_name).STRF_vs_nSTRF_subsampled = subsample_results;
        file_results.(cond_name).subsampling_info = struct(...
            'larger_group', larger_group, ...
            'n_subsample', n_subsample, ...
            'n_combinations_tested', n_combinations, ...
            'n_total_combinations', nchoosek(n_total, n_subsample));
    else
        file_results.(cond_name).STRF_vs_nSTRF_subsampled = [];
    end
end

end
