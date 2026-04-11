function file_results = f101_STRF(data, STRFsig,snr,filename,rep)
%(data,STRFsig,snr,files(f).name,rep)
% Perform subsampling analysis on a single file, considering only
% STRF/nSTRF grouping, SNR conditions ignored

% Input:
%   data: data matrix [neurons x time x trials]
%   STRFsig: binary vector indicating STRF-significant neurons (1) and non-STRF neurons (0)
%   filename: name of the file being analyzed
%   rep: number of repetitions for causal analysis (completed rep = 2 and verified that results are deterministic)


% Output:
% Returns struct with following fields

% results = 

%   struct with fields:

%              n_STRF: 10
%             n_nSTRF: 0
%      n_total_trials: 230
%     n_neurons_total: 10
%           STRF_self: {[1x1 struct]}
%          nSTRF_self: []
%         all_neurons: {[1x1 struct]}

% >> results.STRF_self

% ans =

%   1x1 cell array

%     {1x1 struct}

% >> results.STRF_self{1}

% ans = 

%   struct with fields:

%      Phi: [10x10 double]
%     Psi2: [10x10 double]

% >> results.STRF_self{1}.Psi2

% ans =

%      1     1     1     0     0     0     0     1     1     0
%      1     1     1     1     0     1     0     1     0     0
%      1     1     1     1     0    -1     0     1     1     1
%      1     1     1     1     1     1     0     0     0     1
%      0     1     1     1     1     1     0     0     0     0
%      0     1     1     1     1     1     0     0     0     0
%      0     0     0     0     0     0     0     0     0     0
%      1     0     1     0     0     0     0     1     0     0
%      1     0     0     0     0     0     0     0     0     0
%      0     0     1     1    -1     0     0     0     0    -1



% Identify STRF and nSTRF neurons
STRF_idx = find(STRFsig == 1);
nSTRF_idx = find(STRFsig == 0);

% % Identify Hard and Easy trials
% Hard_idx = find(snr == -20 | snr == -15 | snr == -10 | snr == -5);
% Easy_idx = find(snr == 20 | snr == 15 | snr == 10 | snr == 5 | snr == 0);

% Extract data subsets (all trials combined)
X_STRF = data(STRF_idx, :, :);
X_nSTRF = data(nSTRF_idx, :, :);
X_all = data; % All neurons together

% Initialize results structure for this file
file_results = struct();
file_results.n_STRF = length(STRF_idx);
file_results.n_nSTRF = length(nSTRF_idx);
file_results.n_total_trials = size(data, 3);
file_results.n_neurons_total = size(data, 1);

fprintf('  Analyzing file: %s\n', filename);
fprintf('    STRF neurons: %d, nSTRF neurons: %d\n', length(STRF_idx), length(nSTRF_idx));

% 1. STRF self-analysis (all trials combined)
if ~isempty(STRF_idx) && length(STRF_idx) >= 2
    fprintf('    Running STRF self-analysis\n');
    file_results.STRF_self = f002_run_causal_analysis(X_STRF, rep); % 2 repetitions
else
    file_results.STRF_self = [];
    fprintf('    SKIP STRF self-analysis: insufficient neurons (%d)\n', length(STRF_idx));
end

% 2. nSTRF self-analysis (all trials combined)
if ~isempty(nSTRF_idx) && length(nSTRF_idx) >= 2
    fprintf('    Running nSTRF self-analysis\n');
    file_results.nSTRF_self = f002_run_causal_analysis(X_nSTRF, rep);
else
    file_results.nSTRF_self = [];
    fprintf('    SKIP nSTRF self-analysis: insufficient neurons (%d)\n', length(nSTRF_idx));
end

% 3. All neurons together (combined STRF + nSTRF)
if size(X_all, 1) >= 2
    fprintf('    Running analysis on all neurons combined\n');
    file_results.all_neurons = f002_run_causal_analysis(X_all, rep);
else
    file_results.all_neurons = [];
end

% % 4. STRF vs nSTRF subsampled analysis (all trials combined)
% if ~isempty(STRF_idx) && ~isempty(nSTRF_idx) && length(STRF_idx) >= 2 && length(nSTRF_idx) >= 2
%     fprintf('    Running STRF vs nSTRF subsampling analysis\n');
%     
%     % Determine which group has more neurons
%     if length(STRF_idx) > length(nSTRF_idx)
%         larger_group = 'STRF';
%         n_subsample = length(nSTRF_idx); % Subsample to match smaller group
%         larger_data = X_STRF;
%         smaller_data = X_nSTRF;
%         larger_indices = STRF_idx;
%     else
%         larger_group = 'nSTRF';
%         n_subsample = length(STRF_idx);
%         larger_data = X_nSTRF;
%         smaller_data = X_STRF;
%         larger_indices = nSTRF_idx;
%     end
%     
%     fprintf('      %s larger, subsampling to %d neurons\n', larger_group, n_subsample);
%     
%     % Get all possible combinations
%     n_total = size(larger_data, 1);
%     all_combinations = nchoosek(1:n_total, n_subsample);
%     n_combinations = size(all_combinations, 1);
%     
%     % Limit combinations if too many (optional)
%     max_combinations = 100;
%     if n_combinations > max_combinations
%         fprintf('        Too many combinations (%d), randomly sampling %d\n', ...
%             n_combinations, max_combinations);
%         % Randomly select combinations
%         rand_indices = randperm(n_combinations, max_combinations);
%         all_combinations = all_combinations(rand_indices, :);
%         n_combinations = max_combinations;
%     end
%     
%     % Initialize results storage
%     subsample_results = cell(n_combinations, 1);
%     
%     % Run for each subsample combination
%     for combo = 1:n_combinations
%         if mod(combo, 10) == 0 || combo == 1 || combo == n_combinations
%             fprintf('        Processing combination %d/%d\n', combo, n_combinations);
%         end
%         
%         % Subsample the larger group
%         subsampled_data = larger_data(all_combinations(combo, :), :, :);
%         
%         % Combine with smaller group
%         combined_data = cat(1, subsampled_data, smaller_data);
%         
%         % Create group labels (1 for larger group subsample, 2 for smaller group)
%         group_labels = [ones(n_subsample, 1); 2 * ones(size(smaller_data, 1), 1)];
%         
%         % Run causal analysis on combined data
%         combo_result = f002_run_causal_analysis(combined_data, 1); % Single run for each combo
%         combo_result.group_labels = group_labels;
%         combo_result.subsample_indices = all_combinations(combo, :);
%         
%         subsample_results{combo} = combo_result;
%     end
%     
%     file_results.STRF_vs_nSTRF_subsampled = subsample_results;
%     file_results.subsampling_info = struct(...
%         'larger_group', larger_group, ...
%         'n_subsample', n_subsample, ...
%         'n_combinations_tested', n_combinations, ...
%         'n_total_combinations', nchoosek(n_total, n_subsample));
%     
%     fprintf('      Completed subsampling analysis (%d combinations)\n', n_combinations);
%     
% else
%     file_results.STRF_vs_nSTRF_subsampled = [];
%     if isempty(STRF_idx)
%         fprintf('    SKIP subsampling: no STRF neurons\n');
%     elseif isempty(nSTRF_idx)
%         fprintf('    SKIP subsampling: no nSTRF neurons\n');
%     elseif length(STRF_idx) < 2
%         fprintf('    SKIP subsampling: insufficient STRF neurons (%d < 2)\n', length(STRF_idx));
%     elseif length(nSTRF_idx) < 2
%         fprintf('    SKIP subsampling: insufficient nSTRF neurons (%d < 2)\n', length(nSTRF_idx));
%     end
% end

fprintf('  Completed analysis for %s\n\n', filename);

end
