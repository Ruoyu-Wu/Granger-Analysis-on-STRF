function rep_results = f002_run_causal_analysis(X, n_repetitions)
% RUN_CAUSAL_ANALYSIS Run causal analysis with multiple repetitions
% Input:
%   X: data matrix [neurons x time x trials]
%   n_repetitions: number of times to repeat the analysis
arguments
    X 
    n_repetitions = 1
end

rep_results = cell(n_repetitions, 1);

for rep = 1:n_repetitions
    [CHN, SMP, TRL] = size(X);
    w = 3; % window size
    
    % Fit GLM models with different history orders
    bhat = cell(60, CHN);%Cell array of GLM parameters for each history length and neuron
    for neuron = 1:CHN
        for ht = 3:w:60
            [bhat{ht, neuron}] = glmtrial(X, neuron, ht, w);
        end
    end
    
    % Calculate AIC for model selection
    hts = 3:3:60; %w = 3
    LLK = zeros(60, CHN);
    aic = zeros(60, CHN);
    ht_min_criterion = zeros(1, CHN);
    
    for neuron = 1:CHN
        for ht = 3:w:60
            if ~isempty(bhat{ht, neuron})
                LLK(ht, neuron) = log_likelihood_trial(bhat{ht, neuron}, X, ht, neuron);
                aic(ht, neuron) = -2 * LLK(ht, neuron) + 2 * (CHN * ht / 3 + 1); 
                % -2*loglikelihood (goodness of fit) + 2*k(penalty term for
                % model complexity
            else
                LLK(ht, neuron) = NaN;
                aic(ht, neuron) = NaN;
            end
        end
        [min_val, ind] = min(aic(hts, neuron));
        if ~isempty(ind) && ~isnan(min_val)
            ht_min_criterion(neuron) = ind;
        else
            ht_min_criterion(neuron) = 1; % Default to first if all NaN
        end
    end
    
    % Identify Granger causality
    try
        [Phi, Psi2] = CausalTest(X, bhat, aic, LLK, ht_min_criterion);
        rep_results{rep} = struct('Phi', Phi, 'Psi2', Psi2);
    catch ME
        warning('CausalTest failed: %s', ME.message);
        rep_results{rep} = struct('Phi', [], 'Psi2', [], 'error', ME.message);
    end
end

end