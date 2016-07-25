% DrawDeltaGPvsGPPlotv2
% Draws GP vs Cum GP vs Delta GP Figure for manuscript
% Figure 4

GPIColor = [142, 68, 173]/255;
CavColor = [52, 152, 219]/255;

CtrlPMMark = 's';
CtrlWhMark = 's';
KCPMMark = '^';
KCWhMark = '^';

barColor = [0 0 0];

ebarWidth = 0.1;

SpreadAmp = 2;

MarkerSize = 6;

%%%%%%%%%%%%%%%%%%


Cav1CtrlFiles = {'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\4.1-Cav-1-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\4.10-Cav-1-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\4.2-Cav-1-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\4.3-Cav-1-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\4.4-Cav-1-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\4.5-Cav-1-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\4.7-Cav-1-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\4.8-Cav-1-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.1-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.10-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.2-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.3-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.4-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.5-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.6-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.7-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.8-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\0.9-Cav1-mCherry-migration-Laurdan-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'};


Cav17KCFiles = {'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\1.1-Cav1-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\1.2-Cav1-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\1.3-Cav1-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\1.4-Cav1-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\1.5-Cav1-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\6.1-Cav1-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\6.10-Cav1-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\6.2-Cav1-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\6.3-Cav1-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\6.4-Cav1-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\6.6-Cav1-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\6.7-Cav1-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'};

GPICtrlFiles = {'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\2.1-GPI-AP-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\2.2-GPI-AP-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\2.5-GPI-AP-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\2.6-GPI-AP-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.1-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.10-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.11-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.12-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.2-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.4-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.5-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.6-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.8-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\4.9-GPI-AP-mCherry-Laurdan-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'};

GPI7KCFiles = {'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\3.1-GPI-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\3.2-GPI-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\3.3-GPI-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.05 Spectral Phasro Laurdan mCherry\whole cells analysed\5.11.2015\GP-spectral\3.5-GPI-mCherry-Laurdan-7KC-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.1-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.10-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.11-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.3-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.5-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.6-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.7-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.8-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.9-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt'};

cutDueToNotMatchingOtherDataSets = {'\15.11.20 Spectral Phasor Laurdan mCherry\whole cells analysed\20.11.2015\GP\3.2-GPI-AP-mCherry-Laurdan-7KC-4PFA-COS7 ex 405 em 410-695_mCherryVsGPValue.txt';...
    '\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\2.3-GPI-AP-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt';...
    '\15.10.16 Spectral Phasro Laurdan mCherry\whole cells analysed\16.10.2015\GP-spectral\2.4-GPI-AP-mCherry-Laurdan-COS7-4PFA-RT ex 405 em410-695._mCherryVsGPValue.txt'};

%%

masterFileList = {GPICtrlFiles, GPI7KCFiles, Cav1CtrlFiles, Cav17KCFiles};

% For each file name given, load up that data file and the corresponding
% _cumDistGPVal.txt file.
% _mCherryVsGPValue gives mean value of GP histogram, number of pixels
% that's pulled from (and therefore SEM).
% _cmDistGPVal gives cumulative GP value, DeltaGP value
% Pool into a single output txt file, also a cell for plotting

% poolData cell same structure as masterFileList, but for each file, matrix
% containing;
% [mean of GP, standard deviation, num pixels;
%  cumulative GP, standard deviation, num pixels from above;
% DeltaGP, 0.05 CI, 99.5 CI];

poolData = cell(4, 1);

for m = 1:length(masterFileList)
    
    for f = 1:length(masterFileList{m})
        
      % fileHere = strcat('Y:\Gaus\[ To Long-term Store ]\Joanna Kwiatek\My documents\imaging- raw data', masterFileList{m}{f});
      fileHere = strcat(pwd, masterFileList{m}{f});
       
       if exist(fileHere, 'file') == 2

           GPmCherry = dlmread(fileHere, '\t', 8, 0);

           poolData{m}{f} = zeros(3,3);
           poolData{m}{f}(1,:) = [mean(GPmCherry(:,1)), std(GPmCherry(:,1)), numel(GPmCherry(:,1))];

           % String formatting for filename and load data for _cumDistGPVal file
           uscore = strfind(fileHere, '_mCherry');
           fcum = strcat(fileHere(1:uscore-1), '_cumDistGPVal.txt');
           fID = fopen(fcum);
           fgetl(fID);
           fgetl(fID);

           InfLine = fgetl(fID);
           InfPoint = str2double(InfLine(strfind(InfLine, '=')+1:end));
           % DeltaGP on fourth line
           DeltaGPLine = fgetl(fID);
           numTok = DeltaGPLine(strfind(DeltaGPLine, ' = ')+3:end);
           textData = textscan(numTok, '%f %s %f %s %f');

           fclose(fID);

           poolData{m}{f}(2,:) = [InfPoint, std(GPmCherry(:,1)), numel(GPmCherry(:,1))];
           poolData{m}{f}(3,:) = [textData{1}, textData{3}, textData{5}];
       
       else
           fprintf(1, 'File %s not found.\n', masterFileList{m}{f});
      
       end
       

    end
   
    
    
end

%%

% DeltaGP plot

clear meanVal;
for m = 1:length(masterFileList)
    k = 1;
    for f = 1:length(masterFileList{m})
        
        meanVal{m}(k) = poolData{m}{f}(3,1);
        errorVal{m}(k, 1:2) = poolData{m}{f}(3, 2:3);
        k = k+1;
        
    end
end

dFig = figure();
a = plotSpread(meanVal);
for m = 1:length(meanVal)
    
    spreadX{m} = get(a{1}(m), 'XData');
    spreadX{m} = m + SpreadAmp*(spreadX{m}-m);
       
end
close(dFig);


% Then do some plotting.
f2 = figure(2);
clf(f2);
set(f2, 'color', [1 1 1], 'position', [100 300 250 500]);

ax1 = axes('parent', f2, 'position', [0.26 0.11 0.70 0.82], 'nextplot', 'add');
% DeltaGP plot
m = 1;
plot(spreadX{m}, meanVal{m}, 'color', GPIColor, 'Marker', CtrlPMMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax1, spreadX{m}(:)', meanVal{m}(:), errorVal{m}(:,1), errorVal{m}(:,2), ebarWidth);
set(hands, 'color', GPIColor);

invUncertMean = sum(meanVal{m}'./errorVal{m}(:,1))/sum(1./(errorVal{m}(:,1)));

plot(ax1, [m-ebarWidth*3, m+ebarWidth*3], [invUncertMean invUncertMean], 'color', barColor, 'linewidth', 1.5);
hands = eBarControl(ax1, m, invUncertMean, std(meanVal{m})/sqrt(length(meanVal{m})), -std(meanVal{m})/sqrt(length(meanVal{m})), ebarWidth*2);
set(hands, 'color', barColor, 'linewidth', 1.5);

m = m+1;

plot(spreadX{m}, meanVal{m}, 'color', GPIColor, 'Marker', KCPMMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax1, spreadX{m}(:)', meanVal{m}(:), errorVal{m}(:,1), errorVal{m}(:,2), ebarWidth);
set(hands, 'color', GPIColor);

invUncertMean = sum(meanVal{m}'./errorVal{m}(:,1))/sum(1./(errorVal{m}(:,1)));

plot(ax1, [m-ebarWidth*3, m+ebarWidth*3], [invUncertMean invUncertMean], 'color', barColor, 'linewidth', 1.5);
hands = eBarControl(ax1, m, invUncertMean, std(meanVal{m})/sqrt(length(meanVal{m})), -std(meanVal{m})/sqrt(length(meanVal{m})), ebarWidth*2);
set(hands, 'color', barColor, 'linewidth', 1.5);

m = m+1;

plot(spreadX{m}, meanVal{m}, 'color', CavColor, 'Marker', CtrlPMMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax1, spreadX{m}(:)', meanVal{m}(:), errorVal{m}(:,1), errorVal{m}(:,2), ebarWidth);
set(hands, 'color', CavColor);

invUncertMean = sum(meanVal{m}'./errorVal{m}(:,1))/sum(1./(errorVal{m}(:,1)));

plot(ax1, [m-ebarWidth*3, m+ebarWidth*3], [invUncertMean invUncertMean], 'color', barColor, 'linewidth', 1.5);
hands = eBarControl(ax1, m, invUncertMean, std(meanVal{m})/sqrt(length(meanVal{m})), -std(meanVal{m})/sqrt(length(meanVal{m})), ebarWidth*2);
set(hands, 'color', barColor, 'linewidth', 1.5);

m = m+1;

plot(spreadX{m}, meanVal{m}, 'color', CavColor, 'Marker', KCPMMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax1, spreadX{m}(:)', meanVal{m}(:), errorVal{m}(:,1), errorVal{m}(:,2), ebarWidth);
set(hands, 'color', CavColor);

invUncertMean = sum(meanVal{m}'./errorVal{m}(:,1))/sum(1./(errorVal{m}(:,1)));

plot(ax1, [m-ebarWidth*3, m+ebarWidth*3], [invUncertMean invUncertMean], 'color', barColor, 'linewidth', 1.5);
hands = eBarControl(ax1, m, invUncertMean, std(meanVal{m})/sqrt(length(meanVal{m})), -std(meanVal{m})/sqrt(length(meanVal{m})), ebarWidth*2);
set(hands, 'color', barColor, 'linewidth', 1.5);

m = m+1;

set(ax1, 'ylim', [-.05 .04], 'ytick', -.05:.02:0.06, 'fontsize', 12);
set(ax1, 'xlim', [0.4 4.6], 'xticklabels', [], 'fontsize', 12, 'xtick', [1 2 3 4]);
 
plot(ax1, [0 5], [0 0], '--', 'color', [0.8 0.8 0.8], 'linewidth', 1);
ylabel(ax1, '\Delta GP');
% 
tex = axes('parent', f2, 'position', [0.26 0 0.70 0.13]);
set(tex, 'xlim', [0.4 4.6], 'ylim', [0 1]);
text(1, 0.6, '-', 'parent', tex, 'FontSize', 16, 'horizontalalignment', 'center');
text(2, 0.6, '+', 'parent', tex, 'FontSize', 16, 'horizontalalignment', 'center');
text(3, 0.6, '-', 'parent', tex, 'FontSize', 16, 'horizontalalignment', 'center');
text(4, 0.6, '+', 'parent', tex, 'FontSize', 16, 'horizontalalignment', 'center');
text(0.5, 0.6, '7KC', 'parent', tex, 'FontSize', 12, 'horizontalalignment', 'right');
text(0.5, 0.15, 'Target', 'parent', tex, 'FontSize', 12, 'horizontalalignment', 'right');
text(1.5, 0.15, 'GPI-AP', 'parent', tex, 'FontSize', 12, 'horizontalalignment', 'center');
text(3.5, 0.15, 'Cav1', 'parent', tex, 'FontSize', 12, 'horizontalalignment', 'center');

hold on
plot(tex, [0.8 2.2], [0.4 0.4], 'color', 'k');
plot(tex, [2.8 4.2], [0.4 0.4], 'color', 'k');
hold off
set(tex, 'visible', 'off')

%%


% mean GP plot

clear meanVal;
for m = 1:length(masterFileList)
    k = 1;
    for f = 1:length(masterFileList{m})
        
        meanVal{m}(k) = poolData{m}{f}(1,1);
        
        semVal = poolData{m}{f}(1, 2)/sqrt(poolData{m}{f}(1,3));
        
        errorVal{m}(k, 1:2) = [semVal -semVal];
        k = k+1;
        
    end
end

dFig = figure();
a = plotSpread(meanVal);
for m = 1:length(meanVal)
    
    spreadX{m} = get(a{1}(m), 'XData');
    spreadX{m} = m + SpreadAmp*(spreadX{m}-m);
       
end
close(dFig);

% Then do some plotting.
f3 = figure(3);
clf(f3);
set(f3, 'color', [1 1 1], 'position', [100 300 250 500]);

ax1 = axes('parent', f3, 'position', [0.26 0.11 0.70 0.82], 'nextplot', 'add');
% average GP plot
m = 1;
plot(spreadX{m}, meanVal{m}, 'color', GPIColor, 'Marker', CtrlPMMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax1, spreadX{m}(:)', meanVal{m}(:), errorVal{m}(:,1), errorVal{m}(:,2), ebarWidth);
set(hands, 'color', GPIColor);

invUncertMean = sum(meanVal{m}'./errorVal{m}(:,1))/sum(1./(errorVal{m}(:,1)));

plot(ax1, [m-ebarWidth*3, m+ebarWidth*3], [invUncertMean invUncertMean], 'color', barColor, 'linewidth', 1.5);
hands = eBarControl(ax1, m, invUncertMean, std(meanVal{m})/sqrt(length(meanVal{m})), -std(meanVal{m})/sqrt(length(meanVal{m})), ebarWidth*2);
set(hands, 'color', barColor, 'linewidth', 1.5);

m = m+1;

plot(spreadX{m}, meanVal{m}, 'color', GPIColor, 'Marker', KCPMMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax1, spreadX{m}(:)', meanVal{m}(:), errorVal{m}(:,1), errorVal{m}(:,2), ebarWidth);
set(hands, 'color', GPIColor);

invUncertMean = sum(meanVal{m}'./errorVal{m}(:,1))/sum(1./(errorVal{m}(:,1)));

plot(ax1, [m-ebarWidth*3, m+ebarWidth*3], [invUncertMean invUncertMean], 'color', barColor, 'linewidth', 1.5);
hands = eBarControl(ax1, m, invUncertMean, std(meanVal{m})/sqrt(length(meanVal{m})), -std(meanVal{m})/sqrt(length(meanVal{m})), ebarWidth*2);
set(hands, 'color', barColor, 'linewidth', 1.5);

m = m+1;

plot(spreadX{m}, meanVal{m}, 'color', CavColor, 'Marker', CtrlPMMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax1, spreadX{m}(:)', meanVal{m}(:), errorVal{m}(:,1), errorVal{m}(:,2), ebarWidth);
set(hands, 'color', CavColor);

invUncertMean = sum(meanVal{m}'./errorVal{m}(:,1))/sum(1./(errorVal{m}(:,1)));

plot(ax1, [m-ebarWidth*3, m+ebarWidth*3], [invUncertMean invUncertMean], 'color', barColor, 'linewidth', 1.5);
hands = eBarControl(ax1, m, invUncertMean, std(meanVal{m})/sqrt(length(meanVal{m})), -std(meanVal{m})/sqrt(length(meanVal{m})), ebarWidth*2);
set(hands, 'color', barColor, 'linewidth', 1.5);

m = m+1;

plot(spreadX{m}, meanVal{m}, 'color', CavColor, 'Marker', KCPMMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax1, spreadX{m}(:)', meanVal{m}(:), errorVal{m}(:,1), errorVal{m}(:,2), ebarWidth);
set(hands, 'color', CavColor);

invUncertMean = sum(meanVal{m}'./errorVal{m}(:,1))/sum(1./(errorVal{m}(:,1)));

plot(ax1, [m-ebarWidth*3, m+ebarWidth*3], [invUncertMean invUncertMean], 'color', barColor, 'linewidth', 1.5);
hands = eBarControl(ax1, m, invUncertMean, std(meanVal{m})/sqrt(length(meanVal{m})), -std(meanVal{m})/sqrt(length(meanVal{m})), ebarWidth*2);
set(hands, 'color', barColor, 'linewidth', 1.5);

m = m+1;

set(ax1, 'ylim', [-.25 .1], 'ytick', -.25:.05:0.1, 'fontsize', 12);
set(ax1, 'xlim', [0.4 4.6], 'xticklabels', [], 'fontsize', 12, 'xtick', [1 2 3 4]);
 
% plot(ax1, [0 5], [0 0], '--', 'color', [0.8 0.8 0.8], 'linewidth', 1);
ylabel(ax1, 'GP');
% 
tex = axes('parent', f3, 'position', [0.26 0 0.70 0.13]);
set(tex, 'xlim', [0.4 4.6], 'ylim', [0 1]);
text(1, 0.6, '-', 'parent', tex, 'FontSize', 16, 'horizontalalignment', 'center');
text(2, 0.6, '+', 'parent', tex, 'FontSize', 16, 'horizontalalignment', 'center');
text(3, 0.6, '-', 'parent', tex, 'FontSize', 16, 'horizontalalignment', 'center');
text(4, 0.6, '+', 'parent', tex, 'FontSize', 16, 'horizontalalignment', 'center');
text(0.5, 0.6, '7KC', 'parent', tex, 'FontSize', 12, 'horizontalalignment', 'right');
text(0.5, 0.15, 'Target', 'parent', tex, 'FontSize', 12, 'horizontalalignment', 'right');
text(1.5, 0.15, 'GPI-AP', 'parent', tex, 'FontSize', 12, 'horizontalalignment', 'center');
text(3.5, 0.15, 'Cav1', 'parent', tex, 'FontSize', 12, 'horizontalalignment', 'center');

hold on
plot(tex, [0.8 2.2], [0.4 0.4], 'color', 'k');
plot(tex, [2.8 4.2], [0.4 0.4], 'color', 'k');
hold off
set(tex, 'visible', 'off')

%%
% Cumulative GP plot


clear meanVal;
for m = 1:length(masterFileList)
    k = 1;
    for f = 1:length(masterFileList{m})
        
        meanVal{m}(k) = poolData{m}{f}(2,1);
        
        semVal = poolData{m}{f}(2, 2)/sqrt(poolData{m}{f}(2,3));
        
        errorVal{m}(k, 1:2) = [semVal -semVal];
        k = k+1;
        
    end
end

dFig = figure();
a = plotSpread(meanVal);
for m = 1:length(meanVal)
    
    spreadX{m} = get(a{1}(m), 'XData');
    spreadX{m} = m + SpreadAmp*(spreadX{m}-m);
       
end
close(dFig);

% Then do some plotting.
f4 = figure(4);
clf(f4);
set(f4, 'color', [1 1 1], 'position', [100 300 250 500]);

ax1 = axes('parent', f4, 'position', [0.26 0.11 0.70 0.82], 'nextplot', 'add');
% cumulative GP plot
m = 1;
plot(spreadX{m}, meanVal{m}, 'color', GPIColor, 'Marker', CtrlPMMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax1, spreadX{m}(:)', meanVal{m}(:), errorVal{m}(:,1), errorVal{m}(:,2), ebarWidth);
set(hands, 'color', GPIColor);

invUncertMean = sum(meanVal{m}'./errorVal{m}(:,1))/sum(1./(errorVal{m}(:,1)));

plot(ax1, [m-ebarWidth*3, m+ebarWidth*3], [invUncertMean invUncertMean], 'color', barColor, 'linewidth', 1.5);
hands = eBarControl(ax1, m, invUncertMean, std(meanVal{m})/sqrt(length(meanVal{m})), -std(meanVal{m})/sqrt(length(meanVal{m})), ebarWidth*2);
set(hands, 'color', barColor, 'linewidth', 1.5);

m = m+1;

plot(spreadX{m}, meanVal{m}, 'color', GPIColor, 'Marker', KCPMMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax1, spreadX{m}(:)', meanVal{m}(:), errorVal{m}(:,1), errorVal{m}(:,2), ebarWidth);
set(hands, 'color', GPIColor);

invUncertMean = sum(meanVal{m}'./errorVal{m}(:,1))/sum(1./(errorVal{m}(:,1)));

plot(ax1, [m-ebarWidth*3, m+ebarWidth*3], [invUncertMean invUncertMean], 'color', barColor, 'linewidth', 1.5);
hands = eBarControl(ax1, m, invUncertMean, std(meanVal{m})/sqrt(length(meanVal{m})), -std(meanVal{m})/sqrt(length(meanVal{m})), ebarWidth*2);
set(hands, 'color', barColor, 'linewidth', 1.5);

m = m+1;

plot(spreadX{m}, meanVal{m}, 'color', CavColor, 'Marker', CtrlPMMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax1, spreadX{m}(:)', meanVal{m}(:), errorVal{m}(:,1), errorVal{m}(:,2), ebarWidth);
set(hands, 'color', CavColor);

invUncertMean = sum(meanVal{m}'./errorVal{m}(:,1))/sum(1./(errorVal{m}(:,1)));

plot(ax1, [m-ebarWidth*3, m+ebarWidth*3], [invUncertMean invUncertMean], 'color', barColor, 'linewidth', 1.5);
hands = eBarControl(ax1, m, invUncertMean, std(meanVal{m})/sqrt(length(meanVal{m})), -std(meanVal{m})/sqrt(length(meanVal{m})), ebarWidth*2);
set(hands, 'color', barColor, 'linewidth', 1.5);

m = m+1;

plot(spreadX{m}, meanVal{m}, 'color', CavColor, 'Marker', KCPMMark, 'linestyle', 'none', 'markersize', MarkerSize);
hands = eBarControl(ax1, spreadX{m}(:)', meanVal{m}(:), errorVal{m}(:,1), errorVal{m}(:,2), ebarWidth);
set(hands, 'color', CavColor);

invUncertMean = sum(meanVal{m}'./errorVal{m}(:,1))/sum(1./(errorVal{m}(:,1)));

plot(ax1, [m-ebarWidth*3, m+ebarWidth*3], [invUncertMean invUncertMean], 'color', barColor, 'linewidth', 1.5);
hands = eBarControl(ax1, m, invUncertMean, std(meanVal{m})/sqrt(length(meanVal{m})), -std(meanVal{m})/sqrt(length(meanVal{m})), ebarWidth*2);
set(hands, 'color', barColor, 'linewidth', 1.5);

m = m+1;

set(ax1, 'ylim', [-.25 .1], 'ytick', -.25:.05:0.1, 'fontsize', 12);
set(ax1, 'xlim', [0.4 4.6], 'xticklabels', [], 'fontsize', 12, 'xtick', [1 2 3 4]);
 
% plot(ax1, [0 5], [0 0], '--', 'color', [0.8 0.8 0.8], 'linewidth', 1);
ylabel(ax1, 'Cumulative GP');
% 
tex = axes('parent', f4, 'position', [0.26 0 0.70 0.13]);
set(tex, 'xlim', [0.4 4.6], 'ylim', [0 1]);
text(1, 0.6, '-', 'parent', tex, 'FontSize', 16, 'horizontalalignment', 'center');
text(2, 0.6, '+', 'parent', tex, 'FontSize', 16, 'horizontalalignment', 'center');
text(3, 0.6, '-', 'parent', tex, 'FontSize', 16, 'horizontalalignment', 'center');
text(4, 0.6, '+', 'parent', tex, 'FontSize', 16, 'horizontalalignment', 'center');
text(0.5, 0.6, '7KC', 'parent', tex, 'FontSize', 12, 'horizontalalignment', 'right');
text(0.5, 0.15, 'Target', 'parent', tex, 'FontSize', 12, 'horizontalalignment', 'right');
text(1.5, 0.15, 'GPI-AP', 'parent', tex, 'FontSize', 12, 'horizontalalignment', 'center');
text(3.5, 0.15, 'Cav1', 'parent', tex, 'FontSize', 12, 'horizontalalignment', 'center');

hold on
plot(tex, [0.8 2.2], [0.4 0.4], 'color', 'k');
plot(tex, [2.8 4.2], [0.4 0.4], 'color', 'k');
hold off
set(tex, 'visible', 'off')

%% Mean GP vs Delta GP plot

clear meanVal;
for m = 1:length(masterFileList)
    k = 1;
    for f = 1:length(masterFileList{m})
        
        meanGPVal{m}(k) = poolData{m}{f}(1,1);
        
        semVal = poolData{m}{f}(1, 2)/sqrt(poolData{m}{f}(1,3));
        
        meanGPerrorVal{m}(k, 1:2) = [semVal -semVal];
        k = k+1;
        
    end
end

for m = 1:length(masterFileList)
    k = 1;
    for f = 1:length(masterFileList{m})
        
        delGPVal{m}(k) = poolData{m}{f}(3,1);
        delGPerrorVal{m}(k, 1:2) = poolData{m}{f}(3, 2:3);
        k = k+1;
        
    end
end

figure()
hold on
plot(meanGPVal{1}, delGPVal{1}, 'kx')
plot(meanGPVal{2}, delGPVal{2}, 'rx')
plot(meanGPVal{3}, delGPVal{3}, 'gx')
plot(meanGPVal{4}, delGPVal{4}, 'mx')



% %% Print them!
% 
% set(f2, 'paperpositionmode', 'auto');
% print(f2, 'D:\Dropbox\Proposals\DeltaGP\Figures\ComparisonPointsDelGP.png', '-dpng', '-r300');
% print(f2, 'D:\Dropbox\Proposals\DeltaGP\Figures\ComparisonPointsDelGP.eps', '-depsc', '-r300');
% 
% set(f3, 'paperpositionmode', 'auto');
% print(f3, 'D:\Dropbox\Proposals\DeltaGP\Figures\ComparisonPointsAvgGP.png', '-dpng', '-r300');
% print(f3, 'D:\Dropbox\Proposals\DeltaGP\Figures\ComparisonPointsAvgGP.eps', '-depsc', '-r300');
% 
% set(f4, 'paperpositionmode', 'auto');
% print(f4, 'D:\Dropbox\Proposals\DeltaGP\Figures\ComparisonPointsCumGP.png', '-dpng', '-r300');
% print(f4, 'D:\Dropbox\Proposals\DeltaGP\Figures\ComparisonPointsCumGP.eps', '-depsc', '-r300');