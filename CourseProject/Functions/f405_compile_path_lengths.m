function T = f405_compile_path_lengths(current_path, results_folder, compiled_folder, suffix)
% Compile node path length results from STRF analysis files
%
% Inputs
%   current_path    - base path
%   results_folder  - folder containing result .mat files
%   compiled_folder - folder to save compiled output
%   suffix          - appended to the csv name, e.g. "_ER_random"
%
% Output
%   T - compiled results table

arguments
    current_path (1,1) string = string(pwd)
    results_folder (1,1) string = "/data/analysis_results/results1/"
    compiled_folder (1,1) string = "/data/analysis_results/results1/path_length/"
    suffix (1,1) string = ""
end

resultFolder = fullfile(current_path, results_folder);
compiledPath = fullfile(current_path, compiled_folder);
addpath(resultFolder);
addpath(genpath(compiledPath));
if ~exist(compiledPath, 'dir')
    mkdir(compiledPath);
end


%% specify analysis type & density calculation method
analysis = "on_STRF";
calculator = @f305_calc_path_length;

%% create container
files = dir(fullfile(resultFolder, "*on_STRF_results.mat"));
nFiles = numel(files);
date_id = strings(nFiles,1);
monkey = strings(nFiles,1);
condition = strings(nFiles,1);
% one cell per file; each cell holds a vector with one value per node
STRF_self_results = cell(nFiles,1);
nSTRF_self_results = cell(nFiles,1);
all_neurons_results = cell(nFiles,1);

%% calculate & compile
for i = 1:nFiles
    fname = files(i).name
    fpath = fullfile(files(i).folder, fname);

    [~, baseName, ~] = fileparts(fname);
    parts = split(baseName, "_");

    % [monkey]_[date_id]_[....]_[condition]_[analysis]_results.mat
    monkey(i) = parts(1);
    date_id(i) = parts(2);
    condition(i) = parts(4);

    D = load(fpath);
    STRF_self = D.file_results.STRF_self;
    nSTRF_self = D.file_results.nSTRF_self;
    all_neurons = D.file_results.all_neurons;
    

    if isempty(STRF_self)
        STRF_self_results{i} = [];
    else
        STRF_self_Psi2 = STRF_self{1,1}.Psi2;
        STRF_self_results{i} = calculator(STRF_self_Psi2);
    end

    if isempty(nSTRF_self)
        nSTRF_self_results{i} = [];
    else
        nSTRF_self_Psi2 = nSTRF_self{1,1}.Psi2;
        nSTRF_self_results{i} = calculator(nSTRF_self_Psi2);
    end

    if isempty(all_neurons)
        all_neurons_results{i} = [];
    else
        all_neurons_Psi2 = all_neurons{1,1}.Psi2;
        all_neurons_results{i} = calculator(all_neurons_Psi2);
end

%% export: long format, one row per file x network x node
metric_name = "path_length";
networks = ["STRF_self", "nSTRF_self", "all_neurons"];
results = {STRF_self_results, nSTRF_self_results, all_neurons_results};
rows = {};
for w = 1:numel(networks)
    for i = 1:nFiles
        v = results{w}{i};
        n = numel(v);
        if n == 0
            continue;
        end
        rows{end+1,1} = table(repmat(date_id(i),n,1), repmat(monkey(i),n,1), ...
            repmat(condition(i),n,1), repmat(networks(w),n,1), (1:n)', ...
            repmat(metric_name,n,1), v(:), ...
            'VariableNames', ["date_id","monkey","condition","network","node","metric","value"]);
    end
end
T = vertcat(rows{:});

out_csv = fullfile(compiledPath, "compiled_" + metric_name + "_" + analysis + suffix + ".csv");
% out_mat = fullfile(compiledPath, "compiled_density_" + analysis + ".mat");

writetable(T, out_csv);
% save(out_mat, "T");
end