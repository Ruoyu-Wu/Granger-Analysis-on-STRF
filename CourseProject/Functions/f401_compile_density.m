function T = f401_compile_density(current_path, results_folder, compiled_folder)
% Compile connectivity density results from STRF analysis files
%
% Inputs
%   current_path    - base path
%   results_folder  - folder containing result .mat files
%   compiled_folder - folder to save compiled output
%
% Output
%   T - compiled results table

arguments
    current_path (1,1) string = string(pwd)
    results_folder (1,1) string = "/data/analysis_results/results1/"
    compiled_folder (1,1) string = "/data/analysis_results/results1/compiled/"
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
density_calculator = @f301_calc_connectivity_density;

%% create container
files = dir(fullfile(resultFolder, "*on_STRF_results.mat"));
nFiles = numel(files);
date_id = strings(nFiles,1);
monkey = strings(nFiles,1);
condition = strings(nFiles,1);
STRF_self_density = nan(nFiles,1);
nSTRF_self_density = nan(nFiles,1);
all_neurons_density = nan(nFiles,1);

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
        STRF_self_density(i) = nan;
    else
        STRF_self_Psi2 = STRF_self{1,1}.Psi2;
        STRF_self_density(i) = density_calculator(STRF_self_Psi2);
    end

    if isempty(nSTRF_self)
        nSTRF_self_density(i) = nan;
    else
        nSTRF_self_Psi2 = nSTRF_self{1,1}.Psi2;
        nSTRF_self_density(i) = density_calculator(nSTRF_self_Psi2);
    end

    if isempty(all_neurons)
        all_neurons_density(i) = nan;
    else
        all_neurons_Psi2 = all_neurons{1,1}.Psi2;
        all_neurons_density(i) = density_calculator(all_neurons_Psi2);
end

T = table(date_id, monkey, condition, STRF_self_density, ...
          nSTRF_self_density, all_neurons_density);

out_csv = fullfile(compiledPath, "compiled_density_" + analysis + ".csv");
% out_mat = fullfile(compiledPath, "compiled_density_" + analysis + ".mat");

writetable(T, out_csv);
% save(out_mat, "T");
end