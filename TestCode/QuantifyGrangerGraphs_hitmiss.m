%QuantifyGrangerGraphs_hitmiss(X)
close all;
missEasyA=[];missEasyAV=[];missHardA=[];missHardAV=[];

load Elaysubname.mat;
[missEasyA,missEasyAV,missHardA,missHardAV] = GutsGrangerQuant_hitmiss(subname,'Elay',0,missEasyA,missEasyAV,missHardA,missHardAV);

load Wusubname.mat;
[fEasyA,fEasyAV,fHardA,fHardAV] = GutsGrangerQuant_hitmiss(subname2,'Wu',length(subname),missEasyA,missEasyAV,missHardA,missHardAV);

save missEasyA.mat missEasyA;
save missEasyAV.mat missEasyAV;
save missHardA.mat missHardA;
save missHardAV.mat missHardAV;

load EasyA.mat; load EasyAV.mat; load HardA.mat; load HardAV.mat

h=figure(1); sgtitle('PercentExcitatory');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on; 
scatter(missEasyA.PercentExcitatory(:),EasyA.PercentExcitatory(:),'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyA v EasyA');MakeXEqualY(xlim,ylim);
subplot(2,2,2);hold on; 
scatter(missHardA(:).PercentExcitatory,HardA(:).PercentExcitatory,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardA v HardA');MakeXEqualY(xlim,ylim);
subplot(2,2,3);hold on; 
scatter(missEasyAV(:).PercentExcitatory,EasyAV(:).PercentExcitatory,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyAV v EasyAV');MakeXEqualY(xlim,ylim);
subplot(2,2,4);hold on; 
scatter(missHardAV(:).PercentExcitatory,HardAV(:).PercentExcitatory,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardAV v HardAV');MakeXEqualY(xlim,ylim);

h=figure(2); sgtitle('PercentInhibitory');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(missEasyA(:).PercentInhibitory,EasyA(:).PercentInhibitory,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyA v EasyA');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(missHardA(:).PercentInhibitory,HardA(:).PercentInhibitory,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(missEasyAV(:).PercentInhibitory,EasyAV(:).PercentInhibitory,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyAV v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(missHardAV(:).PercentInhibitory,HardAV(:).PercentInhibitory,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(3); sgtitle('PercentSubNetworkSize');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(missEasyA(:).PercentSubNetworkSize,EasyA(:).PercentSubNetworkSize,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyA v EasyA');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(missHardA(:).PercentSubNetworkSize,HardA(:).PercentSubNetworkSize,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(missEasyAV(:).PercentSubNetworkSize,EasyAV(:).PercentSubNetworkSize,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyAV v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(missHardAV(:).PercentSubNetworkSize,HardAV(:).PercentSubNetworkSize,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(4); sgtitle('CausalDensity');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(missEasyA(:).CausalDensity,EasyA(:).CausalDensity,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyA v EasyA');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(missHardA(:).CausalDensity,HardA(:).CausalDensity,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(missEasyAV(:).CausalDensity,EasyAV(:).CausalDensity,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyAV v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(missHardAV(:).CausalDensity,HardAV(:).CausalDensity,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(5); sgtitle('Efficiency');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(missEasyA(:).Efficiency,EasyA(:).Efficiency,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyA v EasyA');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(missHardA(:).Efficiency,HardA(:).Efficiency,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(missEasyAV(:).Efficiency,EasyAV(:).Efficiency,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyAV v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(missHardAV(:).Efficiency,HardAV(:).Efficiency,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(6); sgtitle('SigGranger');set(h, 'Position', [455 112 893 703])
subplot(2,2,1);hold on;
scatter(missEasyA(:).SigGranger,EasyA(:).SigGranger,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyA v HitEasyA');MakeXEqualY(xlim,ylim)
subplot(2,2,2);hold on;
scatter(missHardA(:).SigGranger,HardA(:).SigGranger,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardA v HitHardA');MakeXEqualY(xlim,ylim)
subplot(2,2,3);hold on;
scatter(missEasyAV(:).SigGranger,EasyAV(:).SigGranger,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyAV v HitEasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,4);hold on;
scatter(missHardAV(:).SigGranger,HardAV(:).SigGranger,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardAV v HiyHardAV');MakeXEqualY(xlim,ylim)

h=figure(7); sgtitle('Connectedness');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on
scatter(missEasyA(:).Connectedness,EasyA(:).Connectedness,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyA v EasyA');MakeXEqualY(xlim,ylim)
subplot(2,2,2); hold on
scatter(missHardA(:).Connectedness,HardA(:).Connectedness,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,3); hold on
scatter(missEasyAV(:).Connectedness,EasyAV(:).Connectedness,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyAV v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,4); hold on
scatter(missHardAV(:).Connectedness,HardAV(:).Connectedness,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(8); sgtitle('Betweenness');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on
scatter(missEasyA(:).Betweenness,EasyA(:).Betweenness,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyA v EasyA');MakeXEqualY(xlim,ylim)
subplot(2,2,2); hold on
scatter(missHardA(:).Betweenness,HardA(:).Betweenness,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,3); hold on
scatter(missEasyAV(:).Betweenness,EasyAV(:).Betweenness,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyAV v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,4); hold on
scatter(missHardAV(:).Betweenness,HardAV(:).Betweenness,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(9); sgtitle('Network entropy');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on
scatter(missEasyA(:).NetworkEntropy,EasyA(:).NetworkEntropy,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyA v EasyA');MakeXEqualY(xlim,ylim)
subplot(2,2,2); hold on
scatter(missHardA(:).NetworkEntropy,HardA(:).NetworkEntropy,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,3); hold on
scatter(missEasyAV(:).NetworkEntropy,EasyAV(:).NetworkEntropy,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyAV v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,4); hold on
scatter(missHardAV(:).NetworkEntropy,HardAV(:).NetworkEntropy,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardAV v HardAV');MakeXEqualY(xlim,ylim)

h=figure(10); sgtitle('Network Heterogeneity');set(h, 'Position', [455 112 893 703])
subplot(2,2,1); hold on
scatter(missEasyA(:).NetworkHeterogeneity,EasyA(:).NetworkHeterogeneity,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyA v EasyA');MakeXEqualY(xlim,ylim)
subplot(2,2,2); hold on
scatter(missHardA(:).NetworkHeterogeneity,HardA(:).NetworkHeterogeneity,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardA v HardA');MakeXEqualY(xlim,ylim)
subplot(2,2,3); hold on
scatter(missEasyAV(:).NetworkHeterogeneity,EasyAV(:).NetworkHeterogeneity,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missEasyAV v EasyAV');MakeXEqualY(xlim,ylim)
subplot(2,2,4); hold on
scatter(missHardAV(:).NetworkHeterogeneity,HardAV(:).NetworkHeterogeneity,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);MetaTitle(gca,'missHardAV v HardAV');MakeXEqualY(xlim,ylim)
