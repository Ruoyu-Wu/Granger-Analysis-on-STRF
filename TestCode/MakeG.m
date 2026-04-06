function G=MakeG(Output)

X = Output.Psi2;
Phi=Output.Phi;
[r c]= (find(X ~=0));
nPhi=NormalizePhi(Phi);
w=[];
for(i=1:length(c))
  w= [w ; nPhi(r(i),c(i))]; 
end
G=digraph(r,c,w);
