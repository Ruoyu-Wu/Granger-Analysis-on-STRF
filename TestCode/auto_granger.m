clear all;
topLevelSort ='/data/by-user/jean/Alux/ks_sorted/ks_up';
files = dir(topLevelSort);
dirFlags = [files.isdir];
subFolders = files(dirFlags);
subFolderNames = {subFolders(3:end).name}; 

c=0;
for d=subFolderNames
    fold=['/data/by-user/jean/Alux/Granger/',d{1}];
    if ~exist(fold, 'dir')
        mkdir(fold);
    end
    if c>=4
        try
        spt_back=load(['/data/by-user/jean/Alux/ks_sorted/ks_up/',d{1},'/spt_back_alux',d{1}(6:11),'.mat']);
        spt_fig=load(['/data/by-user/jean/Alux/ks_sorted/ks_up/',d{1},'/spt_fig_alux',d{1}(6:11),'.mat']);
        spt_back_cdts=load(['/data/by-user/jean/Alux/ks_sorted/ks_up/',d{1},'/spt_back_cdts_alux',d{1}(6:11),'.mat']);
        spt_fig_cdts=load(['/data/by-user/jean/Alux/ks_sorted/ks_up/',d{1},'/spt_fig_cdts_alux',d{1}(6:11),'.mat']);
        run_granger(spt_back.spt,fold,d{1}(6:11),'back')
        run_granger(spt_fig.spt,fold,d{1}(6:11),'fig')
        if length(spt_back_cdts.spt)>0
            for i=1:4
                run_granger(spt_back_cdts.spt{i},fold,d{1}(6:11),['back_cdts_',num2str(i)])
                run_granger(spt_fig_cdts.spt{i},fold,d{1}(6:11),['fig_cdts_',num2str(i)])  
            end
        end
        catch
            disp('failed')
        end
    end
    c=c+1;
end