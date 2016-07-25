% Draw DeltaGP comparision figure between two data sets
% Figure 3 in manuscript


panelBfile = 'D:\Dropbox\Proposals\DeltaGP\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\6.9-Cav1-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';
panelCfile = 'D:\Dropbox\Proposals\DeltaGP\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\6.4-TfR-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';

panelBlines = strcat(panelBfile(1:(strfind(panelBfile, '_mCherryVsGPValue')-1)), '_cumDistGPVal.txt');
panelClines = strcat(panelCfile(1:(strfind(panelCfile, '_mCherryVsGPValue')-1)), '_cumDistGPVal.txt');


pB = dlmread(panelBfile, '\t', 8, 0);
pC = dlmread(panelCfile, '\t', 8, 0);

pBl = dlmread(panelBlines, '\t', 12, 0);
pCl = dlmread(panelClines, '\t', 12, 0);

disp(mean(pB(:,1)));
disp(mean(pC(:,1)));

% Panel B (Cav1) image
figure(1)
clf(gcf);
set(gcf, 'color', [1 1 1]);
pBAx = dscatter(pB(:,1), pB(:,2));
colormap(gca, 'jet');
pBcumAx = axes('parent', gcf);
set(pBcumAx, 'nextplot', 'add', 'YAxisLocation', 'right');
plot(pBcumAx, pBl(:,1), pBl(:,2), 'k');
plot(pBcumAx, pBl(:,1), pBl(:,3), 'r');
plot(pBcumAx, pBl(:,1), pBl(:,4), 'r:');
plot(pBcumAx, pBl(:,1), pBl(:,5), 'r:');
plot(pBcumAx, [-0.1 -0.1 0.03 0.03 -0.1], [0.4 0.6 0.6 0.4 0.4], 'color', [0.7 0.7 0.7], 'linewidth', 2);
set(pBcumAx, 'nextplot', 'replace', 'xtick', [], 'xlim', [-1 1], 'ylim', [0 1], 'color', 'none', 'ytick', 0:.2:1, 'fontsize', 12);
set(pBAx, 'xtick', -1:0.5:1, 'xlim', [-1 1], 'ytick', 0:200:4000, 'color', 'none', 'fontsize', 12);
xlabel(pBAx, 'GP Value', 'fontsize', 12);
ylabel(pBAx, 'mCherry Intensity', 'fontsize', 12);
ylabel(pBcumAx, 'Cumulative mCherry Intensity', 'fontsize', 12);

drawnow;

% Panel B (Cav1) zoomed inset
figure(2)
clf(gcf);
set(gcf, 'color', [1 1 1]);
pBAx = dscatter(pB(:,1), pB(:,2));
colormap(gca, 'jet');
pBcumAx = axes('parent', gcf);
set(pBcumAx, 'nextplot', 'add', 'YAxisLocation', 'right');
plot(pBcumAx, pBl(:,1), pBl(:,2), 'k', 'linewidth', 2);
plot(pBcumAx, pBl(:,1), pBl(:,3), 'r', 'linewidth', 2);
plot(pBcumAx, pBl(:,1), pBl(:,4), 'r:', 'linewidth', 2);
plot(pBcumAx, pBl(:,1), pBl(:,5), 'r:', 'linewidth', 2);
plot(pBcumAx, [0.03 -0.036], [0.5 0.5], 'k--');
plot(pBcumAx, [-.036 -0.036], [0.4 0.5], 'k--');
plot(pBcumAx, [-.036-.017 -0.036-.017], [0.4 0.5], 'r--');
plot(pBcumAx, [-.036-.017 -0.036], [0.5 0.5], 'r--', 'linewidth', 1);
set(pBcumAx, 'nextplot', 'replace', 'xtick', [], 'color', 'none');
xlabel(pBAx, 'GP Value', 'fontsize', 12);
ylabel(pBAx, 'mCherry Intensity', 'fontsize', 12);
ylabel(pBcumAx, 'Cumulative mCherry Intensity', 'fontsize', 12);
set(pBcumAx, 'xlim', [-0.1 0.03], 'ylim', [0.4 0.6], 'xtick', [], 'ytick', [0.4 0.5 0.6], 'fontsize', 12);
set(pBAx, 'xlim', get(pBcumAx, 'xlim'), 'ylim', [max(pB(:,2))*0.4, max(pB(:,2))*0.6], 'xtick', [-.15:.05:.2], 'ytick', [0:200:20000], 'fontsize', 12);
text(-0.09, 0.51, '\Delta GP', 'parent', pBcumAx, 'Fontsize', 20);

% Panel C (TfR) image
figure(3)
clf(gcf);
set(gcf, 'color', [1 1 1]);
pBAx = dscatter(pC(:,1), pC(:,2));
colormap(gca, 'jet');
pBcumAx = axes('parent', gcf);
set(pBcumAx, 'nextplot', 'add', 'YAxisLocation', 'right');
plot(pBcumAx, pCl(:,1), pCl(:,2), 'k');
plot(pBcumAx, pCl(:,1), pCl(:,3), 'r');
plot(pBcumAx, pCl(:,1), pCl(:,4), 'r:');
plot(pBcumAx, pCl(:,1), pCl(:,5), 'r:');
plot(pBcumAx, [-0.120 -0.120 -0.02 -0.02 -0.120], [0.4 0.6 0.6 0.4 0.4], 'color', [0.7 0.7 0.7], 'linewidth', 2);
set(pBcumAx, 'nextplot', 'replace', 'xtick', [], 'xlim', [-1 1], 'ylim', [0 1], 'color', 'none', 'ytick', 0:.2:1, 'fontsize', 12);
set(pBAx, 'xtick', -1:0.5:1, 'xlim', [-1 1], 'ytick', 0:200:4000, 'color', 'none', 'fontsize', 12);
xlabel(pBAx, 'GP Value', 'fontsize', 12);
ylabel(pBAx, 'mCherry Intensity', 'fontsize', 12);
ylabel(pBcumAx, 'Cumulative mCherry Intensity', 'fontsize', 12);

drawnow;

% Panel C (TfR) zoomed inset
figure(4)
clf(gcf);
set(gcf, 'color', [1 1 1]);
pBAx = dscatter(pC(:,1), pC(:,2));
colormap(gca, 'jet');
pBcumAx = axes('parent', gcf);
set(pBcumAx, 'nextplot', 'add', 'YAxisLocation', 'right');
plot(pBcumAx, pCl(:,1), pCl(:,2), 'k', 'linewidth', 2);
plot(pBcumAx, pCl(:,1), pCl(:,3), 'r', 'linewidth', 2);
plot(pBcumAx, pCl(:,1), pCl(:,4), 'r:', 'linewidth', 2);
plot(pBcumAx, pCl(:,1), pCl(:,5), 'r:', 'linewidth', 2);
plot(pBcumAx, [-0.02 -0.073], [0.5 0.5], 'k--');
plot(pBcumAx, [-.073 -0.073], [0.4 0.5], 'k--');
plot(pBcumAx, [-.073+.022 -0.073+.022], [0.4 0.5], 'r--');
plot(pBcumAx, [-.073+.022 -0.073], [0.5 0.5], 'r--', 'linewidth', 1);
set(pBcumAx, 'nextplot', 'replace', 'xtick', [], 'color', 'none');
xlabel(pBAx, 'GP Value', 'fontsize', 12);
ylabel(pBAx, 'mCherry Intensity', 'fontsize', 12);
ylabel(pBcumAx, 'Cumulative mCherry Intensity', 'fontsize', 12);
set(pBcumAx, 'xlim', [-0.120 -.02], 'ylim', [0.4 0.6], 'xtick', [], 'ytick', [0.4 0.5 0.6], 'fontsize', 12);
set(pBAx, 'xlim', get(pBcumAx, 'xlim'), 'ylim', [max(pC(:,2))*0.4, max(pC(:,2))*0.6], 'xtick', [-.15:.05:.2], 'ytick', [0:50:20000], 'fontsize', 12);
text(-0.09, 0.51, '\Delta GP', 'parent', pBcumAx, 'Fontsize', 20);

