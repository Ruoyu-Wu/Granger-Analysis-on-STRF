%QuantifyGrangerGraphs(X)
close all;
EasyA=[];EasyAV=[];HardA=[];HardAV=[];

subname=[];
fn=dir();
for i=1:length(fn)
  if ~isempty(findstr('Granger',fn(i).name)) &&  ~isempty(findstr('Elay',fn(i).name)) ...
       &&   ~isempty(findstr('hit',fn(i).name))
    str2=findstr('_',fn(i).name);
    cf=char(fn(i).name);
    cf=cf(str2(1)+1:str2(2)-1);
    subname=[ subname str2num(cf)];
  end
end

[EasyA,EasyAV,HardA,HardAV] = GutsGrangerQuant(subname,'Elay',0,EasyA,EasyAV,HardA,HardAV);

subname2=[];
for i=1:length(fn)
  if ~isempty(findstr('Granger',fn(i).name)) &&  ~isempty(findstr('Wu',fn(i).name)) ... 
       &&   ~isempty(findstr('hit',fn(i).name))
    str2=findstr('_',fn(i).name);
    cf=char(fn(i).name);
    cf=cf(str2(1)+1:str2(2)-1);
    subname2=[ subname2 str2num(cf)];
  end
end

[fEasyA,fEasyAV,fHardA,fHardAV] = GutsGrangerQuant(subname2,'Wu',length(subname),EasyA,EasyAV,HardA,HardAV);

save EasyA.mat EasyA;
save EasyAV.mat EasyAV;
save HardA.mat HardA;
save HardAV.mat HardAV;
save Elaysubname.mat subname; %save these so get datums for MISSes in correct order
save Wusubname.mat subname2; %same as above

h=figure(1); sgtitle('PercentExcitatory');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on; 
scatter(EasyA.PercentExcitatory(:),EasyAV.PercentExcitatory(:));MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim);
subplot(2,2,2);hold on; 
scatter(HardA(:).PercentExcitatory,HardAV(:).PercentExcitatory);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim);
subplot(2,2,3);hold on; 
scatter(EasyA(:).PercentExcitatory,HardA(:).PercentExcitatory);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim);
subplot(2,2,4);hold on; 
scatter(EasyAV(:).PercentExcitatory,HardAV(:).PercentExcitatory);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim);

h=figure(2); sgtitle('PercentInhibitory');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(EasyA(:).PercentInhibitory,EasyAV(:).PercentInhibitory);MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(HardA(:).PercentInhibitory,HardAV(:).PercentInhibitory);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(EasyA(:).PercentInhibitory,HardA(:).PercentInhibitory);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(EasyAV(:).PercentInhibitory,HardAV(:).PercentInhibitory);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(3); sgtitle('PercentSubNetworkSize');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(EasyA(:).PercentSubNetworkSize,EasyAV(:).PercentSubNetworkSize);MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(HardA(:).PercentSubNetworkSize,HardAV(:).PercentSubNetworkSize);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(EasyA(:).PercentSubNetworkSize,HardA(:).PercentSubNetworkSize);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(EasyAV(:).PercentSubNetworkSize,HardAV(:).PercentSubNetworkSize);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(4); sgtitle('CausalDensity');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(EasyA(:).CausalDensity,EasyAV(:).CausalDensity);MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(HardA(:).CausalDensity,HardAV(:).CausalDensity);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(EasyA(:).CausalDensity,HardA(:).CausalDensity);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(EasyAV(:).CausalDensity,HardAV(:).CausalDensity);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(5); sgtitle('Efficiency');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(EasyA(:).Efficiency,EasyAV(:).Efficiency);MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(HardA(:).Efficiency,HardAV(:).Efficiency);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(EasyA(:).Efficiency,HardA(:).Efficiency);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(EasyAV(:).Efficiency,HardAV(:).Efficiency);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(6); sgtitle('SigGranger');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(EasyA(:).SigGranger,EasyAV(:).SigGranger);MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(HardA(:).SigGranger,HardAV(:).SigGranger);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(EasyA(:).SigGranger,HardA(:).SigGranger);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(EasyAV(:).SigGranger,HardAV(:).SigGranger);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(7); sgtitle('Connectedness');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on
scatter(EasyA(:).Connectedness,EasyAV(:).Connectedness);MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,2); hold on
scatter(HardA(:).Connectedness,HardAV(:).Connectedness);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3); hold on
scatter(EasyA(:).Connectedness,HardA(:).Connectedness);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,4); hold on
scatter(EasyAV(:).Connectedness,HardAV(:).Connectedness);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(8); sgtitle('Betweenness');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on
scatter(EasyA(:).Betweenness,EasyAV(:).Betweenness);MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,2); hold on
scatter(HardA(:).Betweenness,HardAV(:).Betweenness);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3); hold on
scatter(EasyA(:).Betweenness,HardA(:).Betweenness);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,4); hold on
scatter(EasyAV(:).Betweenness,HardAV(:).Betweenness);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(9); sgtitle('Network entropy');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on
scatter(EasyA(:).NetworkEntropy,EasyAV(:).NetworkEntropy);MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,2); hold on
scatter(HardA(:).NetworkEntropy,HardAV(:).NetworkEntropy);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3); hold on
scatter(EasyA(:).NetworkEntropy,HardA(:).NetworkEntropy);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,4); hold on
scatter(EasyAV(:).NetworkEntropy,HardAV(:).NetworkEntropy);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(10); sgtitle('Network Heterogeneity');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on
scatter(EasyA(:).NetworkHeterogeneity,EasyAV(:).NetworkHeterogeneity);MetaTitle(gca,'EasyA v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,2); hold on
scatter(HardA(:).NetworkHeterogeneity,HardAV(:).NetworkHeterogeneity);MetaTitle(gca,'HardA v HardAV');MakeXEqualY(xlim,ylim)
subplot(2,2,3); hold on
scatter(EasyA(:).NetworkHeterogeneity,HardA(:).NetworkHeterogeneity);MetaTitle(gca,'EasyA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,4); hold on
scatter(EasyAV(:).NetworkHeterogeneity,HardAV(:).NetworkHeterogeneity);MetaTitle(gca,'EasyAV v HardAV');MakeXEqualY(xlim,ylim)