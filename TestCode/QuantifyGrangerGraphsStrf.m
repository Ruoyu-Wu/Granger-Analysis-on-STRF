%QuantifyGrangerGraphs(X)
close all;

EasyAStrf=[];EasyAVStrf=[];HardAStrf=[];HardAVStrf=[];
EasyAnStrf=[];EasyAVnStrf=[];HardAnStrf=[];HardAVnStrf=[];

subname=[];
fn=dir();
for i=1:length(fn)
  if ~isempty(findstr('Granger',fn(i).name)) &&  ~isempty(findstr('Elay',fn(i).name)) ...
       &&   ~isempty(findstr('hit',fn(i).name)) && ~isempty(findstr('STRF',fn(i).name)) && isempty(findstr('nSTRF',fn(i).name)) 
    str2=findstr('_',fn(i).name);
    cf=char(fn(i).name);
    cf=cf(str2(1)+1:str2(2)-1);
    subname=[ subname str2num(cf)];
  end
end
subname=unique(subname);
[EasyAStrf,EasyAVStrf,HardAStrf,HardAVStrf] = GutsGrangerQuantStrf(subname,'Elay','Strf',0,length(subname));

subname2=[];
for i=1:length(fn)
  if ~isempty(findstr('Granger',fn(i).name)) &&  ~isempty(findstr('Elay',fn(i).name)) ...
       &&   ~isempty(findstr('hit',fn(i).name)) && ~isempty(findstr('nSTRF',fn(i).name))
    str2=findstr('_',fn(i).name);
    cf=char(fn(i).name);
    cf=cf(str2(1)+1:str2(2)-1);
    subname2=[ subname2 str2num(cf)];
  end
end
subname2=unique(subname2);
[EasyAnStrf,EasyAVnStrf,HardAnStrf,HardAVnStrf] = GutsGrangerQuantStrf(subname2,'Elay','nSTRF',0,length(subname2));

save EEasyAStrf.mat EasyAStrf;
save EEasyAVStrf.mat EasyAVStrf;
save EHardAStrf.mat HardAStrf;
save EHardAVStrf.mat HardAVStrf;

save EEasyAnStrf.mat EasyAnStrf;
save EEasyAVnStrf.mat EasyAVnStrf;
save EHardAnStrf.mat HardAnStrf;
save EHardAVnStrf.mat HardAVnStrf;
save Elaysubname.mat subname subname2; %save these so get datums for MISSes in correct order

subname3=[];
for i=1:length(fn)
  if ~isempty(findstr('Granger',fn(i).name)) &&  ~isempty(findstr('Wu',fn(i).name)) ... 
       &&   ~isempty(findstr('hit',fn(i).name)) && ~isempty(findstr('STRF',fn(i).name)) && isempty(findstr('nSTRF',fn(i).name))
    str2=findstr('_',fn(i).name);
    cf=char(fn(i).name);
    cf=cf(str2(1)+1:str2(2)-1);
    subname3=[ subname3 str2num(cf)];
  end
end
subname3=unique(subname3);
[EasyAStrf,EasyAVStrf,HardAStrf,HardAVStrf] = GutsGrangerQuantStrf(subname3,'Wu','Strf',length(subname)+1,length(subname3));

subname4=[];
for i=1:length(fn)
  if ~isempty(findstr('Granger',fn(i).name)) &&  ~isempty(findstr('Wu',fn(i).name)) ... 
       &&   ~isempty(findstr('hit',fn(i).name)) && ~isempty(findstr('STRF',fn(i).name))
    str2=findstr('_',fn(i).name);
    cf=char(fn(i).name);
    cf=cf(str2(1)+1:str2(2)-1);
    subname4=[ subname4 str2num(cf)];
  end
end
subname4=unique(subname4);
[EasyAnStrf,EasyAVnStrf,HardAnStrf,HardAVnStrf] = GutsGrangerQuantStrf(subname4,'Wu','nStrf',length(subname2)+1,length(subname4));


save WEasyAStrf.mat EasyAStrf;
save WEasyAVStrf.mat EasyAVStrf;
save WHardAStrf.mat HardAStrf;
save WHardAVStrf.mat HardAVStrf;

save WEasyAnStrf.mat EasyAnStrf;
save WEasyAVnStrf.mat EasyAVnStrf;
save WHardAnStrf.mat HardAnStrf;
save WHardAVnStrf.mat HardAVnStrf;
save Wusubname.mat subname3 subname4; %same as above


h=figure(1); sgtitle('PercentExcitatory');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on; 
scatter(EasyAStrf.PercentExcitatory(:),EasyAVStrf.PercentExcitatory(:));MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim);
subplot(2,2,2);hold on; 
scatter(HardAStrf(:).PercentExcitatory,HardAVStrf(:).PercentExcitatory);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim);
subplot(2,2,3);hold on; 
scatter(EasyAStrf(:).PercentExcitatory,HardAStrf(:).PercentExcitatory);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim);
subplot(2,2,4);hold on; 
scatter(EasyAVStrf(:).PercentExcitatory,HardAVStrf(:).PercentExcitatory);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim);

h=figure(21); sgtitle('PercentExcitatory');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on; 
histogram(EasyAStrf.PercentExcitatory(:)); histogram(EasyAVStrf.PercentExcitatory(:));title('EasyA v EasyAV');
subplot(2,2,2);hold on; 
histogram(HardAStrf(:).PercentExcitatory); histogram(HardAVStrf(:).PercentExcitatory);title('HardA v HardAV');
subplot(2,2,3);hold on; 
histogram(EasyAStrf(:).PercentExcitatory); histogram(HardAStrf(:).PercentExcitatory);title('EasyA v HardA');
subplot(2,2,4);hold on; 
histogram(EasyAVStrf(:).PercentExcitatory);histogram(HardAVStrf(:).PercentExcitatory);title('EasyAV v HardAV');
legend


h=figure(2); sgtitle('PercentInhibitory');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(EasyAStrf(:).PercentInhibitory,EasyAVStrf(:).PercentInhibitory);MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(HardAStrf(:).PercentInhibitory,HardAVStrf(:).PercentInhibitory);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(EasyAStrf(:).PercentInhibitory,HardAStrf(:).PercentInhibitory);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(EasyAVStrf(:).PercentInhibitory,HardAVStrf(:).PercentInhibitory);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(22); sgtitle('PercentInhibitory');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on; 
histogram(EasyAStrf.PercentInhibitory(:)); histogram(EasyAVStrf.PercentInhibitory(:));title('EasyA v EasyAV');
subplot(2,2,2);hold on; 
histogram(HardAStrf(:).PercentInhibitory); histogram(HardAVStrf(:).PercentInhibitory);title('HardA v HardAV');
subplot(2,2,3);hold on; 
histogram(EasyAStrf(:).PercentInhibitory); histogram(HardAStrf(:).PercentInhibitory);title('EasyA v HardA');
subplot(2,2,4);hold on; 
histogram(EasyAVStrf(:).PercentInhibitory);histogram(HardAVStrf(:).PercentInhibitory);title('EasyAV v HardAV');
legend

h=figure(3); sgtitle('PercentSubNetworkSize');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(EasyAStrf(:).PercentSubNetworkSize,EasyAVStrf(:).PercentSubNetworkSize);MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(HardAStrf(:).PercentSubNetworkSize,HardAVStrf(:).PercentSubNetworkSize);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(EasyAStrf(:).PercentSubNetworkSize,HardAStrf(:).PercentSubNetworkSize);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(EasyAVStrf(:).PercentSubNetworkSize,HardAVStrf(:).PercentSubNetworkSize);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(4); sgtitle('CausalDensity');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(EasyAStrf(:).CausalDensity,EasyAVStrf(:).CausalDensity);MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(HardAStrf(:).CausalDensity,HardAVStrf(:).CausalDensity);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(EasyAStrf(:).CausalDensity,HardAStrf(:).CausalDensity);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(EasyAVStrf(:).CausalDensity,HardAVStrf(:).CausalDensity);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(5); sgtitle('Efficiency');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(EasyAStrf(:).Efficiency,EasyAVStrf(:).Efficiency);MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(HardAStrf(:).Efficiency,HardAVStrf(:).Efficiency);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(EasyAStrf(:).Efficiency,HardAStrf(:).Efficiency);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(EasyAVStrf(:).Efficiency,HardAVStrf(:).Efficiency);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(6); sgtitle('SigGranger');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(EasyAStrf(:).SigGranger,EasyAVStrf(:).SigGranger);MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(HardAStrf(:).SigGranger,HardAVStrf(:).SigGranger);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(EasyAStrf(:).SigGranger,HardAStrf(:).SigGranger);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(EasyAVStrf(:).SigGranger,HardAVStrf(:).SigGranger);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(7); sgtitle('Connectedness');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on
scatter(EasyAStrf(:).Connectedness,EasyAVStrf(:).Connectedness);MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,2); hold on
scatter(HardAStrf(:).Connectedness,HardAVStrf(:).Connectedness);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3); hold on
scatter(EasyAStrf(:).Connectedness,HardAStrf(:).Connectedness);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,4); hold on
scatter(EasyAVStrf(:).Connectedness,HardAVStrf(:).Connectedness);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(8); sgtitle('Betweenness');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on
scatter(EasyAStrf(:).Betweenness,EasyAVStrf(:).Betweenness);MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,2); hold on
scatter(HardAStrf(:).Betweenness,HardAVStrf(:).Betweenness);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3); hold on
scatter(EasyAStrf(:).Betweenness,HardAStrf(:).Betweenness);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,4); hold on
scatter(EasyAVStrf(:).Betweenness,HardAVStrf(:).Betweenness);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(9); sgtitle('Network entropy');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on
scatter(EasyAStrf(:).NetworkEntropy,EasyAVStrf(:).NetworkEntropy);MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,2); hold on
scatter(HardAStrf(:).NetworkEntropy,HardAVStrf(:).NetworkEntropy);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3); hold on
scatter(EasyAStrf(:).NetworkEntropy,HardAStrf(:).NetworkEntropy);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,4); hold on
scatter(EasyAVStrf(:).NetworkEntropy,HardAVStrf(:).NetworkEntropy);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(10); sgtitle('Network Heterogeneity');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on
scatter(EasyAStrf(:).NetworkHeterogeneity,EasyAVStrf(:).NetworkHeterogeneity);MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,2); hold on
scatter(HardAStrf(:).NetworkHeterogeneity,HardAVStrf(:).NetworkHeterogeneity);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3); hold on
scatter(EasyAStrf(:).NetworkHeterogeneity,HardAStrf(:).NetworkHeterogeneity);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,4); hold on
scatter(EasyAVStrf(:).NetworkHeterogeneity,HardAVStrf(:).NetworkHeterogeneity);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h=figure(101); sgtitle('PercentExcitatory');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on; 
scatter(EasyAStrf.PercentExcitatory(:),EasyAnStrf.PercentExcitatory(:));MetaTitle(gca,'EasyA v EasynA');MakeXEqualY(xlim,ylim);
subplot(2,2,2);hold on; 
scatter(HardAStrf(:).PercentExcitatory,HardAnStrf(:).PercentExcitatory);MetaTitle(gca,'HardA v HardnAV');MakeXEqualY(xlim,ylim);
subplot(2,2,3);hold on; 
scatter(EasyAVStrf(:).PercentExcitatory,EasyAVnStrf(:).PercentExcitatory);MetaTitle(gca,'EasyAV v EasynAV');MakeXEqualY(xlim,ylim);
subplot(2,2,4);hold on; 
scatter(HardAVStrf(:).PercentExcitatory,HardAVnStrf(:).PercentExcitatory);MetaTitle(gca,'HardAV v HardnAV');MakeXEqualY(xlim,ylim);

h=figure(201); sgtitle('PercentExcitatory');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on; 
histogram(EasyAStrf.PercentExcitatory(:)); histogram(EasyAnStrf.PercentExcitatory(:));title('EasyA v EasynA');
subplot(2,2,2);hold on; 
histogram(HardAStrf(:).PercentExcitatory); histogram(HardAnStrf(:).PercentExcitatory);title('HardA v HardnAV');
subplot(2,2,3);hold on; 
histogram(EasyAVStrf(:).PercentExcitatory); histogram(EasyAVnStrf(:).PercentExcitatory);title('EasyAV v EasynAV');
subplot(2,2,4);hold on; 
histogram(HardAVStrf(:).PercentExcitatory); histogram(HardAVnStrf(:).PercentExcitatory);title('HardAV v HardnAV');
legend

h=figure(102); sgtitle('PercentInhibitory');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(EasyAStrf(:).PercentInhibitory,EasyAnStrf(:).PercentInhibitory);MetaTitle(gca,'EasyA v EasynA');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(HardAStrf(:).PercentInhibitory,HardAnStrf(:).PercentInhibitory);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(EasyAVStrf(:).PercentInhibitory,EasyAVnStrf(:).PercentInhibitory);MetaTitle(gca,'EasyAV v EasynAV');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(HardAVStrf(:).PercentInhibitory,HardAVnStrf(:).PercentInhibitory);MetaTitle(gca,'HardAV v HardnAV');MakeXEqualY(xlim,ylim)

h=figure(202); sgtitle('PercentInhibitory');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on; 
histogram(EasyAStrf.PercentInhibitory(:)); histogram(EasyAnStrf.PercentInhibitory(:));title('EasyA v EasynA');
subplot(2,2,2);hold on; 
histogram(HardAStrf(:).PercentInhibitory); histogram(HardAnStrf(:).PercentInhibitory);title('HardA v HardnAV');
subplot(2,2,3);hold on; 
histogram(EasyAVStrf(:).PercentInhibitory); histogram(EasyAVnStrf(:).PercentInhibitory);title('EasyAV v EasynAV');
subplot(2,2,4);hold on; 
histogram(HardAVStrf(:).PercentInhibitory); histogram(HardAVnStrf(:).PercentInhibitory);title('HardAV v HardnAV');

h=figure(103); sgtitle('PercentSubNetworkSize');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(EasyAStrf(:).PercentSubNetworkSize,EasyAnStrf(:).PercentSubNetworkSize);MetaTitle(gca,'EasyA v EasynA');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(HardAStrf(:).PercentSubNetworkSize,HardAnStrf(:).PercentSubNetworkSize);MetaTitle(gca,'HardA v HardAn');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(EasyAVStrf(:).PercentSubNetworkSize,EasyAVnStrf(:).PercentSubNetworkSize);MetaTitle(gca,'EasyAV v EasynAV');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(HardAVStrf(:).PercentSubNetworkSize,HardAVnStrf(:).PercentSubNetworkSize);MetaTitle(gca,'HardAV v HardnAV');MakeXEqualY(xlim,ylim)

h=figure(104); sgtitle('CausalDensity');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(EasyAStrf(:).CausalDensity,EasyAnStrf(:).CausalDensity);MetaTitle(gca,'EasyA v EasyAn');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(HardAStrf(:).CausalDensity,HardAnStrf(:).CausalDensity);MetaTitle(gca,'HardA v HardAn');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(EasyAVStrf(:).CausalDensity,EasyAVnStrf(:).CausalDensity);MetaTitle(gca,'EasyAV v EasynAV');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(HardAVStrf(:).CausalDensity,HardAVnStrf(:).CausalDensity);MetaTitle(gca,'HardAV v HardnAV');MakeXEqualY(xlim,ylim)

h=figure(105); sgtitle('Efficiency');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(EasyAStrf(:).Efficiency,EasyAnStrf(:).Efficiency);MetaTitle(gca,'EasyA v EasyAn');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(HardAStrf(:).Efficiency,HardAnStrf(:).Efficiency);MetaTitle(gca,'HardA v HardAn');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(EasyAVStrf(:).Efficiency,EasyAVnStrf(:).Efficiency);MetaTitle(gca,'EasyAV v EasynAV');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(HardAVStrf(:).Efficiency,HardAVnStrf(:).Efficiency);MetaTitle(gca,'HardAV v HardnAV');MakeXEqualY(xlim,ylim)

h=figure(106); sgtitle('SigGranger');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(EasyAStrf(:).SigGranger,EasyAnStrf(:).SigGranger);MetaTitle(gca,'EasyA v EasyAn');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(HardAStrf(:).SigGranger,HardAnStrf(:).SigGranger);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(EasyAVStrf(:).SigGranger,EasyAVnStrf(:).SigGranger);MetaTitle(gca,'EasyAV v EasynAV');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(HardAVStrf(:).SigGranger,HardAVnStrf(:).SigGranger);MetaTitle(gca,'HardAV v HardnAV');MakeXEqualY(xlim,ylim)

h=figure(206); sgtitle('PercentSubNetworkSize');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on; 
histogram(EasyAStrf.PercentSubNetworkSize(:)); histogram(EasyAnStrf.PercentSubNetworkSize(:));title('EasyA v EasynA');
subplot(2,2,2);hold on; 
histogram(HardAStrf(:).PercentSubNetworkSize); histogram(HardAnStrf(:).PercentSubNetworkSize);title('HardA v HardnAV');
subplot(2,2,3);hold on; 
histogram(EasyAVStrf(:).PercentSubNetworkSize); histogram(EasyAVnStrf(:).PercentSubNetworkSize);title('EasyAV v EasynAV');
subplot(2,2,4);hold on; 
histogram(HardAVStrf(:).PercentSubNetworkSize); histogram(HardAVnStrf(:).PercentSubNetworkSize);title('HardAV v HardnAV');
legend

h=figure(2066); sgtitle('SigGranger');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on; 
histogram(EasyAStrf.SigGranger(:)); histogram(EasyAnStrf.SigGranger(:));title('EasyA v EasynA');
[p1,h]=ranksum(EasyAStrf.SigGranger(:),EasyAnStrf.SigGranger(:))
subplot(2,2,2);hold on; 
histogram(HardAStrf(:).SigGranger); histogram(HardAnStrf(:).SigGranger);title('HardA v HardnAV');
[p2,h]=ranksum(HardAStrf(:).SigGranger,HardAnStrf.SigGranger(:))
subplot(2,2,3);hold on; 
histogram(EasyAVStrf(:).SigGranger); histogram(EasyAVnStrf(:).SigGranger);title('EasyAV v EasynAV');
[p3,h]=ranksum(EasyAVStrf(:).SigGranger,EasyAVnStrf.SigGranger(:))
subplot(2,2,4);hold on; 
histogram(HardAVStrf(:).SigGranger); histogram(HardAVnStrf(:).SigGranger);title('HardAV v HardnAV');
[p4,h]=ranksum(HardAVStrf(:).SigGranger,HardAVnStrf(:).SigGranger(:))
legend

h=figure(107); sgtitle('Connectedness');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on
scatter(EasyAStrf(:).Connectedness,EasyAnStrf(:).Connectedness);MetaTitle(gca,'EasyA v EasyAn');MakeXEqualY(xlim,ylim)
subplot(2,2,2); hold on
scatter(HardAStrf(:).Connectedness,HardAnStrf(:).Connectedness);MetaTitle(gca,'HardA v HardAn');MakeXEqualY(xlim,ylim)
subplot(2,2,3); hold on
scatter(EasyAVStrf(:).Connectedness,EasyAVnStrf(:).Connectedness);MetaTitle(gca,'EasyAV v EasynAV');MakeXEqualY(xlim,ylim)
subplot(2,2,4); hold on
scatter(HardAVStrf(:).Connectedness,HardAVnStrf(:).Connectedness);MetaTitle(gca,'HardAV v HardnAV');MakeXEqualY(xlim,ylim)

h=figure(108); sgtitle('Betweenness');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on
scatter(EasyAStrf(:).Betweenness,EasyAnStrf(:).Betweenness);MetaTitle(gca,'EasyA v EasyAn');MakeXEqualY(xlim,ylim)
subplot(2,2,2); hold on
scatter(HardAStrf(:).Betweenness,HardAnStrf(:).Betweenness);MetaTitle(gca,'HardA v HardAn');MakeXEqualY(xlim,ylim)
subplot(2,2,3); hold on
scatter(EasyAVStrf(:).Betweenness,EasyAVnStrf(:).Betweenness);MetaTitle(gca,'EasyAV v EasynAV');MakeXEqualY(xlim,ylim)
subplot(2,2,4); hold on
scatter(HardAVStrf(:).Betweenness,HardAVnStrf(:).Betweenness);MetaTitle(gca,'HardAV v HardnAV');MakeXEqualY(xlim,ylim)

h=figure(109); sgtitle('Network entropy');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on
scatter(EasyAStrf(:).NetworkEntropy,EasyAnStrf(:).NetworkEntropy);MetaTitle(gca,'EasyA v EasyAn');MakeXEqualY(xlim,ylim)
subplot(2,2,2); hold on
scatter(HardAStrf(:).NetworkEntropy,HardAnStrf(:).NetworkEntropy);MetaTitle(gca,'HardA v HardAn');MakeXEqualY(xlim,ylim)
subplot(2,2,3); hold on
scatter(EasyAVStrf(:).NetworkEntropy,EasyAVnStrf(:).NetworkEntropy);MetaTitle(gca,'EasyAV v EasynAV');MakeXEqualY(xlim,ylim)
subplot(2,2,4); hold on
scatter(HardAVStrf(:).NetworkEntropy,HardAVnStrf(:).NetworkEntropy);MetaTitle(gca,'HardAV v HardnAV');MakeXEqualY(xlim,ylim)

h=figure(110); sgtitle('Network Heterogeneity');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on
scatter(EasyAStrf(:).NetworkHeterogeneity,EasyAnStrf(:).NetworkHeterogeneity);MetaTitle(gca,'EasyA v EasyAn');MakeXEqualY(xlim,ylim)
subplot(2,2,2); hold on
scatter(HardAStrf(:).NetworkHeterogeneity,HardAnStrf(:).NetworkHeterogeneity);MetaTitle(gca,'HardA v HardAn');MakeXEqualY(xlim,ylim)
subplot(2,2,3); hold on
scatter(EasyAVStrf(:).NetworkHeterogeneity,EasyAVnStrf(:).NetworkHeterogeneity);MetaTitle(gca,'EasyAV v EasynAV');MakeXEqualY(xlim,ylim)
subplot(2,2,4); hold on
scatter(HardAVStrf(:).NetworkHeterogeneity,HardAVnStrf(:).NetworkHeterogeneity);MetaTitle(gca,'HardAV v HardnAV');MakeXEqualY(xlim,ylim)

