function MetaTitle(g,SmallTitle)

h=findobj(gca,'type','scatter');
xdata=h.XData;
foo=find(isinf(xdata));
xdata(foo)=NaN;
ydata=h.YData;
foo=find(isinf(ydata));
ydata(foo)=NaN;
[H,p]=ttest(xdata,ydata);


title(['p=' num2str(p)])

WhereV=findstr('v',SmallTitle);
xname=SmallTitle(1:WhereV-1);
yname=SmallTitle(WhereV+1:end);
xlabel(xname);ylabel(yname);