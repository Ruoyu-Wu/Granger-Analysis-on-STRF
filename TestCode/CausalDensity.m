function Cd = CausalDensity(Output)

%Cd is a measure of causal interactions involving dynamical 
% integration (neurons coordinate with each other) and 
% differentiation (neurons contribute in different ways) 
% among network nodes. 
%causal density
%Seth, A. K. (2010). A MATLAB toolbox for Granger causal connectivity analysis. J. Neurosci. Methods 186, 262–273. doi: 10.1016/j.jneumeth.2009.11.020
if ~isempty(Output)
G=MakeG(Output);
Nodes=numnodes(G);
Edges=numedges(G);
NumSig=length(find(Output.Psi2~=0));
Cd=NumSig/(Nodes*(Nodes-1)); %check formulation not sure if everything is 
                            %denomintor
else
Cd = NaN;
end
