function [EasyA,EasyAV,HardA,HardAV] = GutsGrangerQuant(subname,Monk,offset,EasyA,EasyAV,HardA,HardAV)



subname=unique(subname);
fn=dir();
for i=1:length(subname)
  %to allow analyses while code runs, only do if all 4 files exist
  if(eval(['exist(' char(39) 'GrangerEasy' Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_A-hit.mat' char(39)  ')']) ~=0 ...
          && eval(['exist(' char(39) 'GrangerEasy' Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_AV-hit.mat' char(39)  ')']) ~=0 ...
          && eval(['exist(' char(39) 'GrangerHard' Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_A-hit.mat' char(39)  ')']) ~=0 ...
          && eval(['exist(' char(39) 'GrangerHard' Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_AV-hit.mat' char(39)  ')']) ~=0)
  
   disp(['Processing ' Monk ':' num2str(subname(i))])
   % Easy A trials
   currfile=['GrangerEasy' Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_A-hit.mat']; 
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
  
   % Easy AV trials
   currfile=['GrangerEasy' Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_AV-hit.mat']; 
   eval(['load ' currfile])
   EasyAV.PercentExcitatory(offset+i)=PEorPI(Output,1);
   EasyAV.PercentInhibitory(offset+i)=PEorPI(Output,-1);
   EasyAV.PercentSubNetworkSize(offset+i)=PEorPI(Output,2);
   EasyAV.CausalDensity(offset+i)=CausalDensity(Output);
   EasyAV.Efficiency(offset+i)=Efficiency(Output);
   SigGranger = find(Output.Psi2 == -1 | Output.Psi2 ==1); %also look at Phi values for significant connections and compare as function of hard v easy or A v V or whatever
   EasyAV.SigGranger(offset+i)= length(SigGranger);
   EasyAV.Connectedness(offset+i)=Connectedness(Output);
   EasyAV.Betweenness(offset+i)=Betweenness(Output);
   [EasyAV.NetworkEntropy(offset+i), EasyAV.NetworkHeterogeneity(offset+i)] = Dani(Output);


   % Hard A trials
   currfile=['GrangerHard' Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_A-hit.mat']; 
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


   % HardAV trials
    currfile=['GrangerHard' Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_AV-hit.mat']; 
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
    disp(['Skipping ' Monk ':' num2str(subname(i))])    
  end
end