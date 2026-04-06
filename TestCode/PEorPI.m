function out = PEorPI(Output,flag)

if ~isempty(Output)
   %figure(1); clf; hold on; subplot(1,2,1);imagesc(Output.Phi); subplot(1,2,2);imagesc(Output.Psi2);
X = Output.Psi2;
if flag==1
  out=find(X==1);
  if isempty(out)
    out=0;
  else
    out=length(out);
  end
end

if flag==-1
  out=find(X==-1);
  if isempty(out)
    out=0;
  else
    out=length(out);
  end
end

if flag==2
  out=find(X~=0);
  if isempty(out)
    out=0;
  else
    out=length(out);
  end
end


out=out/(size(X,1)*size(X,2));
else
 out=NaN;
end
