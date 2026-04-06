function [NetworkEntropy, NetworkHeterogeneity] = Dani(Output)

%based on analyses from: https://journals.aps.org/prresearch/abstract/10.1103/PhysRevResearch.6.013136#fulltext
%for network entropy
if ~isempty(Output)
%needs to be unweighted and undirected for closed form.
X = Output.Psi2;
[r c]=find(X~=0);
G=graph(r,c);
k = degree(G);

entropy=[];

for i=1:length(k)
  entropy=[entropy k(i)*log2(k(i))];
end
entropy=sum(entropy);
E=numedges(G);
NetworkEntropy =entropy/(2*E);

NetworkHeterogeneity = var(k)/(mean(k))^2;
else
 NetworkEntropy = NaN;
 NetworkHeterogeneity=NaN;
end