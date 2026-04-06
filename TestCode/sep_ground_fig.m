clear all;



stim_ons=load('./alux_220422/stim_onsets_alux0422.mat');
ons=stim_ons.stim_onset;
spike_trial_list=load('./alux_220422/spike_time_list_alux0422.mat')
spt_tr_list=spike_trial_list.FrameStack;
disp(size(spt_tr_list))




dt=1/1000

sil={}
ground={}
fig={}

for i=1:size(spt_tr_list,2)
    disp(i)
    sil{end+1}=spt_tr_list{i}(:,1:min(int64((1.0/dt)*ons(i)),size(spt_tr_list{i},2)));
    if int64((1.0/dt)*ons(i))<=size(spt_tr_list{i},2)
        ground{end+1}=spt_tr_list{i}(:,int64((1.0/dt)*ons(i)+1):min(int64((1.0/dt)*ons(i))+200,size(spt_tr_list{i},2)));
    end
    if int64((1.0/dt)*ons(i))+200<=size(spt_tr_list{i},2)
        fig{end+1}=spt_tr_list{i}(:,int64((1.0/dt)*ons(i))+200+1:min(int64((1.0/dt)*ons(i))+400,size(spt_tr_list{i},2)));
    end
end


