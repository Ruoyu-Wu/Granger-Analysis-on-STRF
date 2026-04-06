function run_granger(spt,savepath,da,label)
    disp(size(spt))
    
    X=permute(spt,[2,3,1]);
    disp(size(X))
    Psi2=demo_real(X);
    save([savepath,'/causal_map_alux',da,'_',label,'.mat'],'Psi2')  
    %clear all;
end
