function eff= Efficiency(Output)

if ~isempty(Output)
%global E is a measure of the capacity for nodes to propagate information in parallel across a network                            

%see eqn 15 of https://www.frontiersin.org/journals/behavioral-neuroscience/articles/10.3389/fnbeh.2015.00002/full
% X = abs(X);  %ignore excit and inhib and focus on connectivity
G=MakeG(Output);

Nodes=numnodes(G);
Edges=numedges(G);
L=[];
for i=1:Nodes
  for j=1:Nodes
    if(i~=j)
        [p,d]=shortestpath(G,i,j);
      L = [L 1/d];
    end
  end
end

sumL=sum(L); %because directional i-->j may not be same as j-->i
eff=sumL/(Nodes*(Nodes-1));

%another formulation of E
%Latora and Marchiori (2001) Phys Rev Lett 87:198701.
%               Onnela et al. (2005) Phys Rev E 71:065103
%               Fagiolo (2007) Phys Rev E 76:026107.
%               Rubinov M, Sporns O (2010) NeuroImage 52:1059-69

%eff=efficiency_wei(X);
else
   eff = NaN;
end


