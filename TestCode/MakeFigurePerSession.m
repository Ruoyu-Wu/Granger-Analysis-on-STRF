%plot each Granger connectivity graph on the same graph


load ('GrangerHardWu_240708_CooOnsetIndwithVirtual_AV-hit.mat')
hAV = Output;
load ('GrangerHardWu_240708_CooOnsetIndwithVirtual_A-hit.mat')
hA = Output;


load ('GrangerEasyWu_240708_CooOnsetIndwithVirtual_AV-hit.mat')
eAV = Output;
load ('GrangerEasyWu_240708_CooOnsetIndwithVirtual_A-hit.mat')
eA = Output;


colormap(jet(128)); 

minV = min([min(min(eAV.Phi)) min(min(eA.Phi))  ...
    min(min(hAV.Phi)) min(min(hA.Phi)) ]);
maxV = max([max(max(eAV.Phi)) max(max(eA.Phi))  ...
    max(max(hAV.Phi)) max(max(hA.Phi)) ]);

rangeV = maxV - minV;
thismap = colormap();
maxcol = size(thismap, 1) - 1;


% AVs = uint8(floor((AV.Phi - minV) ./ rangeV .* maxcol));
% As = uint8(floor((A.Phi - minV) ./ rangeV .* maxcol));
% Vs = uint8(floor((V.Phi - minV) ./ rangeV .* maxcol));


h=figure(111);
f1=subplot(2,3,1);
image(eAV.Phi);
colormap(f1, thismap); colormap(f1, thismap); xlabel('Trigger');ylabel('Target');title('AV \phi')
colorbar
subplot(2,3,2)
imagesc(eAV.Psi2);xlabel('Trigger');ylabel('Target');title('AV \psi')


figure(111)
subplot(2,3,3)
[r c]= (find(abs(eAV.Psi2) == 1));
G=MakeG(eAV); plot(G)
title('Graph representation of \psi matrix')

f1=subplot(2,3,4);
image(eA.Phi);
colormap(f1, thismap); xlabel('Trigger');ylabel('Target');title('A \phi')
colorbar
subplot(2,3,5)
imagesc(eA.Psi2);xlabel('Trigger');ylabel('Target');title('A \psi')


figure(111111)
imagesc(eA.Psi2);xlabel('Trigger Neurons','FontSize',15);ylabel('Target','FontSize',15)
axis square

figure(111)
subplot(2,3,6)
[r c]= (find(abs(eA.Psi2) == 1));
G=MakeG(eA); plot(G)
set(h, 'Position', [455 112 893 703])

sgtitle('EASY Wu.230814.CooOnset')


figure(1111)
h=figure(1111);
f1=subplot(2,3,1);
image(hAV.Phi);
colormap(f1, thismap); colormap(f1, thismap); xlabel('Trigger');ylabel('Target');title('AV \phi')
colorbar
subplot(2,3,2)
imagesc(hAV.Psi2);xlabel('Trigger');ylabel('Target');title('AV \psi')
subplot(2,3,3)
[r c]= (find(abs(hAV.Psi2) == 1));



G=MakeG(hAV); plot(G)
title('Graph representation of \psi matrix')

f1=subplot(2,3,4);
image(hA.Phi);
colormap(f1, thismap); xlabel('Trigger');ylabel('Target');title('A \phi')
colorbar
subplot(2,3,5)
imagesc(hA.Psi2);xlabel('Trigger');ylabel('Target');title('A \psi')
subplot(2,3,6)
[r c]= (find(abs(hA.Psi2) == 1));
G=MakeG(hA); plot(G)



set(h, 'Position', [455 112 893 703])

sgtitle('HARD Wu.230814.CooOnset')

