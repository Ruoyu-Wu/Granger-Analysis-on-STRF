function nPhi = NormalizePhi(Phi)

%normalize weights between 0-1
A=min(min(Phi));
B=max(max(Phi));
d=-1*A/(B-A);

nPhi=Phi.*1/(B-A)+d;
