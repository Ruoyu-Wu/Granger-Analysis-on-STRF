function BtnStructEntropy = Betweenness(Output)

if ~isempty(Output)
G=MakeG(Output);

%betweenness structural entropy
%see: https://www.sciencedirect.com/science/article/pii/S096007792200474X#bb0190
b = centrality(G,'betweenness'); %betweenness
foo=find(b~=0);
b=b(foo);
for i = 1:length(b)
  P(i) = b(i)/sum(b);
end

BtnStructEntropy=0;
for i=1:length(b)
  BtnStructEntropy = P(i)*log(P(i)) + BtnStructEntropy;
end
BtnStructEntropy = -1*BtnStructEntropy;
else
  BtnStructEntropy = NaN;
end