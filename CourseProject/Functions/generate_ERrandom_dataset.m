function generate_ERrandom_dataset(current_path,data_dir,generated_data_dir,suffix)
% generate a 1:1 dataset with #edge & #node matching adjacency matrices to
% the results1 of causality tests

% reads full list of the causality results
% returns (stores) files of exact format as original files, with 
%   struct with fields:

%              n_STRF: 10
%             n_nSTRF: 0
%      n_total_trials: 230
%     n_neurons_total: 10
%           STRF_self: {[1x1 struct]}
%          nSTRF_self: []
%         all_neurons: {[1x1 struct]}
%   
arguments
    current_path (1,1) string = string(pwd)
    data_dir (1,1) string = "/data/analysis_results/results1/";
    generated_data_dir (1,1) string = "/data/analysis_results/results1/benchmarks/ERrandom";
    suffix (1,1) string = "ERrandom"; %remember to specify for each benchmark type
end

dataFolder = fullfile(current_path,data_dir);
generatedFolder = fullfile(current_path, generated_data_dir);

addpath(dataFolder);
addpath(genpath(generatedFolder));
if ~exist(generatedFolder, 'dir')
    mkdir(generatedFolder);
end



%% specify analysis type & generator type
analysis = "on_STRF";
generator = @makerandCIJ_dir;
rng(0); % reproducible generated dataset

%% generate & store
files = dir(fullfile(dataFolder, "*" + analysis + "_results.mat"));
nFiles = numel(files);
networks = ["STRF_self", "nSTRF_self", "all_neurons"];

for i = 1:nFiles
    fname = files(i).name
    D = load(fullfile(files(i).folder, fname));

    % keep the same fields (n_STRF, n_nSTRF, ...) as the original file
    file_results = D.file_results;

    for w = 1:numel(networks)
        net = networks(w);
        if isempty(file_results.(net))
            continue; % no network (<2 neurons) -> stays []
        end

        % 1. #node & #edge of the original network
        % (sign & self connections ignored)
        Psi2 = file_results.(net){1,1}.Psi2;
        n = size(Psi2, 1);
        A = abs(Psi2) ~= 0;
        A(1:n+1:end) = 0;
        k = nnz(A);

        % 2. generate matched network
        % generator output is BCT format A(i,j) = i -> j,
        % transpose to Psi2 format Psi2(target, trigger)
        G = generator(n, k);
        file_results.(net) = {struct('Phi', [], 'Psi2', G.')};
    end

    % [monkey]_[date_id]_[....]_[condition]_[suffix]_[analysis]_results.mat
    % (still matches "*on_STRF_results.mat" in the f40x compile functions)
    out_name = extractBefore(fname, "_" + analysis) + "_" + suffix + "_" + analysis + "_results.mat";
    save(fullfile(generatedFolder, out_name), 'file_results');
end

end