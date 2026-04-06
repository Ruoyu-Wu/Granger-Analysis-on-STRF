function [Phi Psi2]=demo_real(data,snr,STRFsig,DataFile)

STRF = find(STRFsig == 1);
nSTRF = find(STRFsig == 0);

Hard = find(snr == -20 | snr == -15 | snr == -10 | snr == -5);
Easy = find(snr == 20 | snr == 15 | snr == 10 | snr ==  5 | snr == 0);

HardSTRF=data(STRF,:,Hard);
EasySTRF=data(STRF,:,Easy);

HardnSTRF=data(nSTRF,:,Hard);
EasynSTRF=data(nSTRF,:,Easy);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%           STRF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~isempty(STRF) & length(STRF)>=2
%Hard STRF trials
X=HardSTRF;
[CHN SMP TRL] = size(X);
w=3;
% To fit GLM models with different history orders
for neuron = 1:CHN
    for ht = 3:w:60                            % history, W=3ms
        [bhat{ht,neuron}] = glmtrial(X,neuron,ht,w);
    end
end
ht_min_criterion=zeros(1,CHN)
% To select a model order, calculate AIC
hts=3:3:60
for neuron = 1:CHN
    for ht = 3:w:60
        LLK(ht,neuron) = log_likelihood_trial(bhat{ht,neuron},X,ht,neuron);
        aic(ht,neuron) = -2*LLK(ht,neuron) + 2*(CHN*ht/3 + 1);
    end
    [min_val,ind]=min(aic(hts,neuron));
    ht_min_criterion(neuron)=ind;
end

% Identify Granger causality
[Phi Psi2]=CausalTest(X,bhat,aic,LLK,ht_min_criterion);
Output.Phi=Phi;
Output.Psi2=Psi2;
eval(['save GrangerHardSTRF' DataFile ' Output'])


%Easy STRF trials
X=EasySTRF;
[CHN SMP TRL] = size(X);
w=3;
% To fit GLM models with different history orders
for neuron = 1:CHN
    for ht = 3:w:60                            % history, W=3ms
        [bhat{ht,neuron}] = glmtrial(X,neuron,ht,w);
    end
end
ht_min_criterion=zeros(1,CHN)
% To select a model order, calculate AIC
hts=3:3:60
for neuron = 1:CHN
    for ht = 3:w:60
        LLK(ht,neuron) = log_likelihood_trial(bhat{ht,neuron},X,ht,neuron);
        aic(ht,neuron) = -2*LLK(ht,neuron) + 2*(CHN*ht/3 + 1);
    end
    [min_val,ind]=min(aic(hts,neuron));
    ht_min_criterion(neuron)=ind;
end

% Identify Granger causality
[Phi Psi2]=CausalTest(X,bhat,aic,LLK,ht_min_criterion);
Output.Phi=Phi;
Output.Psi2=Psi2;
eval(['save GrangerEasySTRF' DataFile ' Output'])
else
  Output =[];
  eval(['save GrangerHardSTRF' DataFile ' Output'])
  eval(['save GrangerEasySTRF' DataFile ' Output'])
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%           nSTRF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~isempty(nSTRF) & length (nSTRF)>=2
%Hard nSTRF trials
X=HardnSTRF;
[CHN SMP TRL] = size(X);
w=3;
% To fit GLM models with different history orders
for neuron = 1:CHN
    for ht = 3:w:60                            % history, W=3ms
        [bhat{ht,neuron}] = glmtrial(X,neuron,ht,w);
    end
end
ht_min_criterion=zeros(1,CHN)
% To select a model order, calculate AIC
hts=3:3:60
for neuron = 1:CHN
    for ht = 3:w:60
        LLK(ht,neuron) = log_likelihood_trial(bhat{ht,neuron},X,ht,neuron);
        aic(ht,neuron) = -2*LLK(ht,neuron) + 2*(CHN*ht/3 + 1);
    end
    [min_val,ind]=min(aic(hts,neuron));
    ht_min_criterion(neuron)=ind;
end

% Identify Granger causality
[Phi Psi2]=CausalTest(X,bhat,aic,LLK,ht_min_criterion);
Output.Phi=Phi;
Output.Psi2=Psi2;
eval(['save GrangerHardnSTRF' DataFile ' Output'])


%Easy STRF trials
X=EasynSTRF;
[CHN SMP TRL] = size(X);
w=3;
% To fit GLM models with different history orders
for neuron = 1:CHN
    for ht = 3:w:60                            % history, W=3ms
        [bhat{ht,neuron}] = glmtrial(X,neuron,ht,w);
    end
end
ht_min_criterion=zeros(1,CHN)
% To select a model order, calculate AIC
hts=3:3:60
for neuron = 1:CHN
    for ht = 3:w:60
        LLK(ht,neuron) = log_likelihood_trial(bhat{ht,neuron},X,ht,neuron);
        aic(ht,neuron) = -2*LLK(ht,neuron) + 2*(CHN*ht/3 + 1);
    end
    [min_val,ind]=min(aic(hts,neuron));
    ht_min_criterion(neuron)=ind;
end

% Identify Granger causality
[Phi Psi2]=CausalTest(X,bhat,aic,LLK,ht_min_criterion);
Output.Phi=Phi;
Output.Psi2=Psi2;
eval(['save GrangerEasynSTRF' DataFile ' Output'])
else
  Output =[];
  eval(['save GrangerHardnSTRF' DataFile ' Output'])
  eval(['save GrangerEasynSTRF' DataFile ' Output'])
end


end %function
