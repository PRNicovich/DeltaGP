% Plot delta GP value as points all with included error bars
% Figure 6 of manuscript
% Make two plots - one for Whole Cell and one for PM only

dataFile = 'D:\Dropbox\Proposals\DeltaGP\Delat GP for all conditionsCross-checked.xlsx';
% dataFile = 'C:\Users\Rusty\Dropbox\Proposals\DeltaGP\Delat GP for all conditionsCross-checked.xlsx';

dt = xlsread(dataFile);
%%

proteins = {'GPI-AP', 'Cav1', 'TfR'};
treatments = {'Control', '7KC'};
areas = {'Whole Cell', 'PM'};


GPIColor = [142, 68, 173]/255;
CavColor = [52, 152, 219]/255;
TfRColor = [26, 188, 156]/255;

CtrlPMMark = 's';
CtrlWhMark = 's';
KCPMMark = '^';
KCWhMark = '^';

MarkerSize = 5;
ebarWidth = 0.05;
SpreadAmp = 1.3;
overallWidth = 0.25;
overallLinewidth = 1.5;
FS = 12;

significanceLevels = [0.05; 0.01; 0.005];

eBarColor = [52, 73, 94]/255;

fig1 = figure(3);
clf(fig1);
set(fig1, 'color', [1 1 1], 'position', [100 300 350 600], 'PaperPositionMode', 'auto');
ax1 = axes('parent', fig1, 'fontsize', 12, 'nextplot', 'add');
currAx1 = get(ax1, 'Position');
set(ax1, 'position', [0.20 0.15 0.75 0.8]);

fig2 = figure(4);
clf(fig2);
set(fig2, 'color', [1 1 1], 'position', [500 300 350 600], 'PaperPositionMode', 'auto');
ax2 = axes('parent', fig2, 'fontsize', 12, 'nextplot', 'add');
currAx2 = get(ax2, 'Position');
set(ax2, 'position', [0.20 0.15 0.75 0.8]);

cols = [1 4 7 10 15 18 21 24 29 32 35 38];
MeanPoints = {dt(:,1), dt(:,4), dt(:,7), dt(:,10), dt(:,15), dt(:,18), dt(:,21), dt(:,24), dt(:,29), dt(:,32), dt(:,35), dt(:,38)};

a = plotSpread(MeanPoints, 'binWidth', 2);
meanVals = zeros(length(MeanPoints), 1);
devVals = zeros(length(MeanPoints), 1);
pctileVals = zeros(length(MeanPoints), 2);
ttestVals = zeros(length(MeanPoints), 1);
sigVect = zeros(length(MeanPoints)/2, 2);
invUncertMean = zeros(length(MeanPoints), 1);
invUncertUncert = zeros(length(MeanPoints), 2);
LR = 1;
for m = 1:length(MeanPoints)
    
    spreadX{m} = get(a{1}(m), 'XData');
    spreadX{m} = m + SpreadAmp*(spreadX{m}-m);
    
    %%%% Find mean, errorbars of data values
    % Use inverse-variance-weighted mean and inverse of sum of inverse stdevs 

    meanVals(m) = nanmean(dt(:,cols(m)));
    
    dthere = dt(:,cols(m):cols(m)+2);
    dthere(isnan(dthere(:,1)), :) = [];
    invUncertMean(m) = sum(dthere(:,1)./(dthere(:,2)))/sum(1./(dthere(:,2)));
%     invUncertUncert(m) = sqrt(1/sum(1./((abs(dthere(:,2)) + abs(dthere(:,3))).^2)));
%     invUncertUncert(m,1) = sqrt(sum(dthere(:,2).^2))/(length(dthere(:,2)));
%     invUncertUncert(m,2) = sqrt(sum(dthere(:,3).^2))/(length(dthere(:,3)));
    
    devVals(m, 1) = nanstd(dt(:,cols(m)))/sqrt(sum(~isnan(dt(:,cols(m))))); % SEM
    devVals(m, 2) = nanstd(dt(:,cols(m)))/sqrt(sum(~isnan(dt(:,cols(m))))); % SEM
%     devVals(m) = nanstd(dt(:,cols(m)));  % std dev
    pctileVals(m, :) = prctile(dt(~isnan(dt(:,cols(m))), cols(m)), [5 95]);
    
    [~, ttestVals(m)] = ttest(dt(~isnan(dt(:,cols(m))), cols(m)));
    whichSig = find(ttestVals(m) < significanceLevels, 1, 'last');
    if isempty(whichSig)
        sigVect(ceil(m/2), LR) = 0;
    else
        sigVect(ceil(m/2), LR) = whichSig;
    end
    
    if LR == 1;
        LR = 2;
    elseif LR == 2
        LR = 1;
    end
    
end

meanVals = invUncertMean;
devVals = devVals;

delete(findobj('parent', ax1, 'marker', '.'));
delete(findobj('parent', ax2, 'marker', '.'));

plot(ax1, [0 length(MeanPoints)/2+1], [0 0], '--', 'color', [0.8 0.8 0.8], 'linewidth', 1);
plot(ax2, [0 length(MeanPoints)/2+1], [0 0], '--', 'color', [0.8 0.8 0.8], 'linewidth', 1);


m = 1;

plot(ax1, spreadX{m}, MeanPoints{m}(1:numel(spreadX{m})), 'color', GPIColor, 'Marker', CtrlPMMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax1, spreadX{1}, dt(1:numel(spreadX{m}), 1), dt(1:numel(spreadX{m}), 2), dt(1:numel(spreadX{m}), 3), ebarWidth);
set(hands, 'color', GPIColor);
m = m+1;

plot(ax2, spreadX{m}-1, MeanPoints{m}(1:numel(spreadX{m})), 'color', GPIColor, 'Marker', CtrlWhMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax2, spreadX{m}-1, dt(1:numel(spreadX{m}), 4), dt(1:numel(spreadX{m}), 5), dt(1:numel(spreadX{m}), 6), ebarWidth);
set(hands, 'color', GPIColor);
m = m+1;

plot(ax1, spreadX{m}-1, MeanPoints{m}(1:numel(spreadX{m})), 'color', GPIColor, 'Marker', KCPMMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax1, spreadX{m}-1, dt(1:numel(spreadX{m}), 7), dt(1:numel(spreadX{m}), 8), dt(1:numel(spreadX{m}), 9), ebarWidth);
set(hands, 'color', GPIColor);
m = m+1;

plot(ax2, spreadX{m}-2, MeanPoints{m}(1:numel(spreadX{m})), 'color', GPIColor, 'Marker', KCWhMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax2, spreadX{m}-2, dt(1:numel(spreadX{m}), 10), dt(1:numel(spreadX{m}), 11), dt(1:numel(spreadX{m}), 12), ebarWidth);
set(hands, 'color', GPIColor);
m = m+1;

%

plot(ax1, spreadX{m}-2, MeanPoints{m}(1:numel(spreadX{m})), 'color', CavColor, 'Marker', CtrlPMMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax1, spreadX{m}-2, dt(1:numel(spreadX{m}), 15), dt(1:numel(spreadX{m}), 16), dt(1:numel(spreadX{m}), 17), ebarWidth);
set(hands, 'color', CavColor);
m = m+1;

plot(ax2, spreadX{m}-3, MeanPoints{m}(1:numel(spreadX{m})), 'color', CavColor, 'Marker', CtrlWhMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax2, spreadX{m}-3, dt(1:numel(spreadX{m}), 18), dt(1:numel(spreadX{m}), 19), dt(1:numel(spreadX{m}), 20), ebarWidth);
set(hands, 'color', CavColor);
m = m+1;

plot(ax1, spreadX{m}-3, MeanPoints{m}(1:numel(spreadX{m})), 'color', CavColor, 'Marker', KCPMMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax1, spreadX{m}-3, dt(1:numel(spreadX{m}), 21), dt(1:numel(spreadX{m}), 22), dt(1:numel(spreadX{m}), 23), ebarWidth);
set(hands, 'color', CavColor);
m = m+1;

plot(ax2, spreadX{m}-4, MeanPoints{m}(1:numel(spreadX{m})), 'color', CavColor, 'Marker', KCWhMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax2, spreadX{m}-4, dt(1:numel(spreadX{m}), 24), dt(1:numel(spreadX{m}), 25), dt(1:numel(spreadX{m}), 26), ebarWidth);
set(hands, 'color', CavColor);
m = m+1;

%

plot(ax1, spreadX{m}-4, MeanPoints{m}(1:numel(spreadX{m})), 'color', TfRColor, 'Marker', CtrlPMMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax1, spreadX{m}-4, dt(1:numel(spreadX{m}), 29), dt(1:numel(spreadX{m}), 30), dt(1:numel(spreadX{m}), 31), ebarWidth);
set(hands, 'color', TfRColor);
m = m+1;

plot(ax2, spreadX{m}-5, MeanPoints{m}(1:numel(spreadX{m})), 'color', TfRColor, 'Marker', CtrlWhMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax2, spreadX{m}-5, dt(1:numel(spreadX{m}), 32), dt(1:numel(spreadX{m}), 33), dt(1:numel(spreadX{m}), 34), ebarWidth);
set(hands, 'color', TfRColor);
m = m+1;

plot(ax1, spreadX{m}-5, MeanPoints{m}(1:numel(spreadX{m})), 'color', TfRColor, 'Marker', KCPMMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax1, spreadX{m}-5, dt(1:numel(spreadX{m}), 35), dt(1:numel(spreadX{m}), 36), dt(1:numel(spreadX{m}), 37), ebarWidth);
set(hands, 'color', TfRColor);
m = m+1;

plot(ax2, spreadX{m}-6, MeanPoints{m}(1:numel(spreadX{m})), 'color', TfRColor, 'Marker', KCWhMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax2, spreadX{m}-6, dt(1:numel(spreadX{m}), 38), dt(1:numel(spreadX{m}), 39), dt(1:numel(spreadX{m}), 40), ebarWidth);
set(hands, 'color', TfRColor);
m = m+1;

% 
plot(ax1, [1.2*overallWidth+(1:numel(meanVals)/2)' ((1:numel(meanVals)/2)-1.2*overallWidth)']', [meanVals(1:2:end) meanVals(1:2:end)]', 'color', eBarColor...
    , 'MarkerSize', 10, 'linewidth', overallLinewidth);
plot(ax2, [1.2*overallWidth+(1:numel(meanVals)/2)' ((1:numel(meanVals)/2)-1.2*overallWidth)']', [meanVals(2:2:end) meanVals(2:2:end)]', 'color', eBarColor...
    , 'MarkerSize', 10, 'linewidth', overallLinewidth);
% hands = eBarControl(ax, 1:numel(meanVals), meanVals, pctileVals(:,2)-meanVals, pctileVals(:,1)-meanVals, overallWidth);
hands = eBarControl(ax1, 1:(numel(meanVals)/2), meanVals(1:2:end), devVals(1:2:end, 1), -devVals(1:2:end, 2), overallWidth);
set(hands, 'color', eBarColor, 'linewidth', overallLinewidth);

hands = eBarControl(ax2, 1:(numel(meanVals)/2), meanVals(2:2:end), devVals(2:2:end, 1), -devVals(2:2:end, 2), overallWidth);
set(hands, 'color', eBarColor, 'linewidth', overallLinewidth);





set(ax1, 'ylim', [-.05 .04], 'ytick', -.05:.02:0.06, 'fontsize', 12);
set(ax2, 'ylim', [-.05 .04], 'ytick', -.05:.02:0.06, 'fontsize', 12);

set(ax1, 'xlim', [.5 numel(meanVals)/2 + 0.5], 'xtick', 1:6);
set(ax2, 'xlim', [.5 numel(meanVals)/2 + 0.5], 'xtick', 1:6);

title(ax1, 'Plasma Membrane');
title(ax2, 'Entire Cell Area');

%%% Labels
for axVal = 1:2
    
    if axVal == 1
        
        fig = fig1;
        ax = ax1;
        
        
    elseif axVal == 2
        ax = ax2;
        fig = fig2;
    end
    
    ylabel(ax, '\DeltaGP', 'FontSize', 12);
    set(ax, 'xticklabel', []);
    currAx = get(ax, 'position');
    tax = axes('parent', fig);
    set(tax, 'position', [currAx(1) 0 currAx(3) currAx(2)], 'xlim', [0 6], 'ylim', [0 1], 'nextplot', 'add');

    text(1, 0.35, 'GPI-AP', 'parent', tax, 'horizontalalignment', 'center', 'fontsize', FS);
    text(3, 0.35, 'Cav1', 'parent', tax, 'horizontalalignment', 'center', 'fontsize', FS);
    text(5, 0.35, 'TfR', 'parent', tax, 'horizontalalignment', 'center', 'fontsize', FS);

    plot(tax, [0.25 1.75], [0.5 .5], 'k');
    plot(tax, [2.25 3.75], [0.5 0.5], 'k');
    plot(tax, [4.25 5.75], [0.5 0.5], 'k');

    text(0.5, 0.7, '-', 'parent', tax, 'horizontalalignment', 'center', 'fontsize', FS+2);
    text(1.5, 0.7, '+', 'parent', tax, 'horizontalalignment', 'center', 'fontsize', FS+2);
    text(2.5, 0.7, '-', 'parent', tax, 'horizontalalignment', 'center', 'fontsize', FS+2);
    text(3.5, 0.7, '+', 'parent', tax, 'horizontalalignment', 'center', 'fontsize', FS+2);
    text(4.5, 0.7, '-', 'parent', tax, 'horizontalalignment', 'center', 'fontsize', FS+2);
    text(5.5, 0.7, '+', 'parent', tax, 'horizontalalignment', 'center', 'fontsize', FS+2);
% 
%     plot(ax, [1 2], [0.6 .6], 'k');
%     plot(ax, [3 4], [0.6 .6], 'k');
%     plot(ax, [5 6], [0.6 .6], 'k');
%     plot(ax, [7 8], [0.6 .6], 'k');
%     plot(ax, [9 10], [0.6 .6], 'k');
%     plot(ax, [11 12], [0.6 .6], 'k');

    % for m = 1:12
    %     
    %     if mod(m, 2) == 0
    %         text(m, 0.85, 'P', 'parent', tax, 'horizontalalignment', 'center', 'fontsize', FS);
    %     else
    %         text(m, 0.85, 'W', 'parent', tax, 'horizontalalignment', 'center', 'fontsize', FS);
    %     end
    % end

    set(tax, 'visible', 'off');

    text(0, 0.35, 'Target', 'parent', tax, 'horizontalalignment', 'right', 'fontsize', FS-2);
    text(0, 0.7, '7KC', 'parent', tax, 'horizontalalignment', 'right', 'fontsize', FS-2);
    %text(0, 0.85, 'Cell Area', 'parent', tax, 'horizontalalignment', 'right', 'fontsize', FS-2);
    
    
    % Significance plots
    for k = 1:numel(significanceLevels)

        whichOnes = find(sigVect(:,axVal) == k);

        for m = 1:numel(whichOnes)
            text(whichOnes(m), 0.035, repmat('*', 1, k), 'horizontalAlignment', 'center', 'fontsize', FS, 'parent', ax);
        end

    end

end


%% 
print(fig1, 'D:\Dropbox\Proposals\DeltaGP\Figures\SummaryPointsPM.png', '-dpng', '-r300');
print(fig1, 'D:\Dropbox\Proposals\DeltaGP\Figures\SummaryPointsPM.eps', '-depsc', '-r300');

print(fig2, 'D:\Dropbox\Proposals\DeltaGP\Figures\SummaryPointsWhole.png', '-dpng', '-r300');
print(fig2, 'D:\Dropbox\Proposals\DeltaGP\Figures\SummaryPointsWhole.eps', '-depsc', '-r300');