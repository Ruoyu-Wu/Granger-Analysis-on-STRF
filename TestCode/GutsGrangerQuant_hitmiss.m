function [EasyA,EasyAV,HardA,HardAV] = GutsGrangerQuant(subname,Monk,offset,EasyA,EasyAV,HardA,HardAV)



subname=unique(subname);
fn=dir();
for i=1:length(subname)
  %check file by file [some may not have misses
   disp(['Processing ' Monk ':' num2str(subname(i))])
   % Easy A trials
   currfile=['GrangerEasy' Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_A-miss.mat']; 
   fexist = eval(['exist(' char(39) currfile char(39) ');']);
   if fexist ~=0
   eval(['load ' currfile])
   EasyA.PercentExcitatory(offset+i)=PEorPI(Output,1);
   EasyA.PercentInhibitory(offset+i)=PEorPI(Output,-1);
   EasyA.PercentSubNetworkSize(offset+i)=PEorPI(Output,2);
   EasyA.CausalDensity(offset+i)=CausalDensity(Output);
   EasyA.Efficiency(offset+i)=Efficiency(Output);
   SigGranger = find (Output.Psi2 == -1 | Output.Psi2 ==1); %also look at Phi values for significant connections and compare as function of hard v easy or A v V or whatever
   EasyA.SigGranger(offset+i)= length(SigGranger);
   EasyA.Connectedness(offset+i)=Connectedness(Output);
   EasyA.Betweenness(offset+i)=Betweenness(Output);
   [EasyA.NetworkEntropy(offset+i), EasyA.NetworkHeterogeneity(offset+i)] = Dani(Output);
   else
   EasyA.PercentExcitatory(offset+i)=NaN;
   EasyA.PercentInhibitory(offset+i)=NaN;
   EasyA.PercentSubNetworkSize(offset+i)=NaN;
   EasyA.CausalDensity(offset+i)=NaN;
   EasyA.Efficiency(offset+i)=NaN;
   EasyA.SigGranger(offset+i)= NaN;
   EasyA.Connectedness(offset+i)=NaN;
   EasyA.Betweenness(offset+i)=NaN;
   EasyA.NetworkEntropy(offset+i)= NaN;
   EasyA.NetworkHeterogeneity(offset+i) = NaN;
   end

   % Easy AV trials
   currfile=['GrangerEasy' Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_AV-miss.mat'];
   fexist = eval(['exist(' char(39) currfile char(39) ');']);
   if fexist ~=0
   eval(['load ' currfile])
   EasyAV.PercentExcitatory(offset+i)=PEorPI(Output,1);
   EasyAV.PercentInhibitory(offset+i)=PEorPI(Output,-1);
   EasyAV.PercentSubNetworkSize(offset+i)=PEorPI(Output,2);
   EasyAV.CausalDensity(offset+i)=CausalDensity(Output);
   EasyAV.Efficiency(offset+i)=Efficiency(Output);
   SigGranger = find (Output.Psi2 == -1 | Output.Psi2 ==1); %also look at Phi values for significant connections and compare as function of hard v easy or A v V or whatever
   EasyAV.SigGranger(offset+i)= length(SigGranger);
   EasyAV.Connectedness(offset+i)=Connectedness(Output);
   EasyAV.Betweenness(offset+i)=Betweenness(Output);
   [EasyAV.NetworkEntropy(offset+i), EasyAV.NetworkHeterogeneity(offset+i)] = Dani(Output);
   else
   EasyAV.PercentExcitatory(offset+i)=NaN;
   EasyAV.PercentInhibitory(offset+i)=NaN;
   EasyAV.PercentSubNetworkSize(offset+i)=NaN;
   EasyAV.CausalDensity(offset+i)=NaN;
   EasyAV.Efficiency(offset+i)=NaN;
   EasyAV.SigGranger(offset+i)= NaN;
   EasyAV.Connectedness(offset+i)=NaN;
   EasyAV.Betweenness(offset+i)=NaN;
   EasyAV.NetworkEntropy(offset+i)= NaN;
   EasyAV.NetworkHeterogeneity(offset+i) = NaN;
   end

   % Hard A trials
   currfile=['GrangerHard' Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_A-miss.mat']; 
   fexist = eval(['exist(' char(39) currfile char(39) ');']);
   if fexist ~=0
   eval(['load ' currfile])
   HardA.PercentExcitatory(offset+i)=PEorPI(Output,1);
   HardA.PercentInhibitory(offset+i)=PEorPI(Output,-1);
   HardA.PercentSubNetworkSize(offset+i)=PEorPI(Output,2);
   HardA.CausalDensity(offset+i)=CausalDensity(Output);
   HardA.Efficiency(offset+i)=Efficiency(Output);
   SigGranger = find (Output.Psi2 == -1 | Output.Psi2 ==1); %also look at Phi values for significant connections and compare as function of hard v easy or A v V or whatever
   HardA.SigGranger(offset+i)= length(SigGranger);
   HardA.Connectedness(offset+i)=Connectedness(Output);
   HardA.Betweenness(offset+i)=Betweenness(Output);
   [HardA.NetworkEntropy(offset+i), HardA.NetworkHeterogeneity(offset+i)] = Dani(Output);
   else
   HardA.PercentExcitatory(offset+i)=NaN;
   HardA.PercentInhibitory(offset+i)=NaN;
   HardA.PercentSubNetworkSize(offset+i)=NaN;
   HardA.CausalDensity(offset+i)=NaN;
   HardA.Efficiency(offset+i)=NaN;
   HardA.SigGranger(offset+i)= NaN;
   HardA.Connectedness(offset+i)=NaN;
   HardA.Betweenness(offset+i)=NaN;
   HardA.NetworkEntropy(offset+i)= NaN;
   HardA.NetworkHeterogeneity(offset+i) = NaN;   
   end

   % HardAV trials
    currfile=['GrangerHard' Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_AV-miss.mat']; 
    fexist = eval(['exist(' char(39) currfile char(39) ');']);
    if fexist ~=0
    eval(['load ' currfile])
    HardAV.PercentExcitatory(offset+i)=PEorPI(Output,1);
    HardAV.PercentInhibitory(offset+i)=PEorPI(Output,-1);
    HardAV.PercentSubNetworkSize(i)=PEorPI(Output,2);
    HardAV.CausalDensity(offset+i)=CausalDensity(Output);
    HardAV.Efficiency(offset+i)=Efficiency(Output);
    SigGranger = find (Output.Psi2 == -1 | Output.Psi2 ==1); %also look at Phi values for significant connections and compare as function of hard v easy or A v V or whatever
    HardAV.SigGranger(offset+i)= length(SigGranger);
    HardAV.Connectedness(offset+i)=Connectedness(Output);
    HardAV.Betweenness(offset+i)=Betweenness(Output);
    [HardAV.NetworkEntropy(offset+i), HardAV.NetworkHeterogeneity(offset+i)] = Dani(Output);
    else
    HardAV.PercentExcitatory(offset+i)=NaN;
    HardAV.PercentInhibitory(offset+i)=NaN;
    HardAV.PercentSubNetworkSize(offset+i)=NaN;
    HardAV.CausalDensity(offset+i)=NaN;
    HardAV.Efficiency(offset+i)=NaN;
    HardAV.SigGranger(offset+i)= NaN;
    HardAV.Connectedness(offset+i)=NaN;
    HardAV.Betweenness(offset+i)=NaN;
    HardAV.NetworkEntropy(offset+i)= NaN;
    HardAV.NetworkHeterogeneity(offset+i) = NaN;
    end
end