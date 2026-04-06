function connected = Connectedness(Output)

if ~isempty(Output)
G=MakeG(Output);
bins = conncomp(G);
connected=sum(bins)/2;
else
    connected = NaN;
end