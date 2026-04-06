function [EasyA,EasyAV,HardA,HardAV] = GutsGrangerQuantStrf(subname,Monk,Strf,start,offset)

EasyA=[];EasyAV=[];HardA=[];HardAV=[];

subname=unique(subname);
fn=dir();
for i=1:length(subname)
  if(eval(['exist(' char(39) 'GrangerEasy' Strf Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_A-hit.mat' char(39)  ')']) ~=0 ...
          && eval(['exist(' char(39) 'GrangerEasy' Strf Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_AV-hit.mat' char(39)  ')']) ~=0 ...
          && eval(['exist(' char(39) 'GrangerHard' Strf Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_A-hit.mat' char(39)  ')']) ~=0 ...
          && eval(['exist(' char(39) 'GrangerHard' Strf Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_AV-hit.mat' char(39)  ')']) ~=0)
  
   disp(['Processing ' Monk ':' num2str(subname(i))])
   % Easy A trials
   currfile=['GrangerEasy' Strf Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_A-hit.mat'];
   eval(['load ' currfile])
   EasyA.PercentExcitatory(start+i)=PEorPI(Output,1);
   EasyA.PercentInhibitory(start+i)=PEorPI(Output,-1);
   EasyA.PercentSubNetworkSize(start+i)=PEorPI(Output,2);
   EasyA.CausalDensity(start+i)=CausalDensity(Output);
   EasyA.Efficiency(start+i)=Efficiency(Output);
   if ~isempty(Output)
   SigGranger = find (Output.Psi2 == -1 | Output.Psi2 ==1); %also look at Phi values for significant connections and compare as function of hard v easy or A v V or whatever
   EasyA.SigGranger(start+i)= length(SigGranger);
   else
      EasyA.SigGranger(start+i) = NaN;
   end
   EasyA.Connectedness(start+i)=Connectedness(Output);
   EasyA.Betweenness(start+i)=Betweenness(Output);
   [EasyA.NetworkEntropy(start+i), EasyA.NetworkHeterogeneity(start+i)] = Dani(Output);
  
   % Easy AV trials
   currfile=['GrangerEasy' Strf Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_AV-hit.mat']; 
   eval(['load ' currfile])
   EasyAV.PercentExcitatory(start+i)=PEorPI(Output,1);
   EasyAV.PercentInhibitory(start+i)=PEorPI(Output,-1);
   EasyAV.PercentSubNetworkSize(start+i)=PEorPI(Output,2);
   EasyAV.CausalDensity(start+i)=CausalDensity(Output);
   EasyAV.Efficiency(start+i)=Efficiency(Output);
   if ~isempty(Output)
   SigGranger = find (Output.Psi2 == -1 | Output.Psi2 ==1); %also look at Phi values for significant connections and compare as function of hard v easy or A v V or whatever
   EasyAV.SigGranger(start+i)= length(SigGranger);
   else
      EasyAV.SigGranger(start+i) = NaN;
   end   
   EasyAV.Connectedness(start+i)=Connectedness(Output);
   EasyAV.Betweenness(start+i)=Betweenness(Output);
   [EasyAV.NetworkEntropy(start+i), EasyAV.NetworkHeterogeneity(start+i)] = Dani(Output);


   % Hard A trials
   currfile=['GrangerHard' Strf Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_A-hit.mat']; 
   eval(['load ' currfile])
   HardA.PercentExcitatory(start+i)=PEorPI(Output,1);
   HardA.PercentInhibitory(start+i)=PEorPI(Output,-1);
   HardA.PercentSubNetworkSize(start+i)=PEorPI(Output,2);
   HardA.CausalDensity(start+i)=CausalDensity(Output);
   HardA.Efficiency(start+i)=Efficiency(Output);
   if ~isempty(Output)
   SigGranger = find (Output.Psi2 == -1 | Output.Psi2 ==1); %also look at Phi values for significant connections and compare as function of hard v easy or A v V or whatever
   HardA.SigGranger(start+i)= length(SigGranger);
   else
      HardA.SigGranger(start+i) = NaN;
   end
   HardA.Connectedness(start+i)=Connectedness(Output);
   HardA.Betweenness(start+i)=Betweenness(Output);
   [HardA.NetworkEntropy(start+i), HardA.NetworkHeterogeneity(start+i)] = Dani(Output);


   % HardAV trials
    currfile=['GrangerHard' Strf Monk '_' num2str(subname(i)) '_cooOnsetIndwithVirtual_AV-hit.mat']; 
    eval(['load ' currfile])
    HardAV.PercentExcitatory(start+i)=PEorPI(Output,1);
    HardAV.PercentInhibitory(start+i)=PEorPI(Output,-1);
    HardAV.PercentSubNetworkSize(start+i)=PEorPI(Output,2);
    HardAV.CausalDensity(start+i)=CausalDensity(Output);
    HardAV.Efficiency(start+i)=Efficiency(Output);
    if ~isempty(Output)
     SigGranger = find (Output.Psi2 == -1 | Output.Psi2 ==1); %also look at Phi values for significant connections and compare as function of hard v easy or A v V or whatever
     HardAV.SigGranger(start+i)= length(SigGranger);
   else
      HardAV.SigGranger(start+i) = NaN;
   end
    HardAV.Connectedness(start+i)=Connectedness(Output);
    HardAV.Betweenness(start+i)=Betweenness(Output);
    [HardAV.NetworkEntropy(start+i), HardAV.NetworkHeterogeneity(start+i)] = Dani(Output);
  else
    disp(['Skipping ' Monk ':' num2str(subname(i))])    
  end
end