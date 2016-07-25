% DrawFittedSpectra
% Make Fig 2 for DeltaGP paper with example spectra fitted to Gamma
% function


spectra = xlsread('\\149.171.80.222\users\Joanna Kwiatek\spectral analysis\Paper\Figures\Spectra 27.05.2014.xlsx');
LoWavelength = 440;
LdWavelength = 490;


LoColor = [36, 204, 113]/255;
LdColor = [155, 60, 182]/255;
ExColor = [44, 62, 80]/255;



LoMarker = 'o';
LdMarker = 's';
ExMarker = 'd';

spectrum = linspace(spectra(1), spectra(32), 33); % Spectrum edges
spectrum = (spectrum + circshift(spectrum, [1, 1]))/2;
spectrum(1) = []; % Spectrum centers
LoChannel = (LoWavelength - spectrum(1))/mean(diff(spectrum)) + 1;
LdChannel = (LdWavelength - spectrum(1))/mean(diff(spectrum)) + 1;




for x = 2:4
    
    nlinfitOptions = statset('Display', 'off');
    spectrum = spectra(:,1);
    f = figure(x);
    clf
    ax  = axes('parent', f);

    lH = (spectra(:,x)/sum(spectra(:,x)));

    initGuess = [max(lH) spectra(1+find(lH == max(lH), 1, 'first'),1) 1];
    try
        [fitVars, r, J] = nlinfit(1:32, lH', @GammaFunction, initGuess, nlinfitOptions);

    catch
        fitVars = nan(1,3);
        r = 0;
        J = 0;
    end
    %                 fitVars = lsqcurvefit(@GammaFunction, initGuess, 1:32, lH');
    fitCurve = GammaFunction(fitVars, [LoChannel, LdChannel]);
    rsq2 = 1 - sum(r.^2) / sum((lH - mean(lH)).^2);


    ft{x} = fitVars;

    Lo = fitCurve(1);
    Ld = fitCurve(2);

    GPValOut(x,:) = [(Lo - Ld)/(Lo + Ld), rsq2];

    %     GPValOut(x,2) = rsq2;

    plot(ax, spectra(:,1), lH);
    set(ax, 'NextPlot', 'add')
    plot(ax, spectra(:,1), GammaFunction(fitVars, 1:32), 'g')
    set(ax, 'NextPlot', 'replace')
end


sx = linspace(min(spectra(:,1)), max(spectra(:,1)), 100);
cx = linspace(1, 32, 100);

% Make plot
fig = figure(5);
clf(fig);
set(fig, 'color', [1 1 1], 'paperpositionmode', 'auto');
ax = axes('parent', fig, 'fontsize', 14);
plot(spectra(:,1), spectra(:,2)/max(spectra(:,2)), 'color', LoColor, 'marker', LoMarker, 'linestyle', '--', 'markersize', 8);
hold on
plot(spectra(:,1), spectra(:,3)/max(spectra(:,3)), 'color', LdColor, 'marker', LdMarker, 'linestyle', '--', 'markersize', 8);
plot(spectra(:,1), spectra(:,4)/max(spectra(:,4)), 'color', ExColor, 'marker', ExMarker, 'linestyle', '--', 'markersize', 8);
plot(sx, GammaFunction(ft{2}, cx)/max(GammaFunction(ft{2}, cx)), 'color', LoColor, 'linewidth', 2);
plot(sx, GammaFunction(ft{3}, cx)/max(GammaFunction(ft{3}, cx)), 'color', LdColor, 'linewidth', 2);
plot(sx, GammaFunction(ft{4}, cx)/max(GammaFunction(ft{4}, cx)), 'color', ExColor, 'linewidth', 2);

patch([spectra(floor(LoChannel),1), spectra(floor(LoChannel),1), spectra(ceil(LoChannel),1), spectra(ceil(LoChannel),1)], ...
    [0 2 2 0], LoColor, 'edgecolor', 'none', 'facealpha', 0.3);

patch([spectra(floor(LdChannel),1), spectra(floor(LdChannel),1), spectra(ceil(LdChannel),1), spectra(ceil(LdChannel),1)], ...
    [0 2 2 0], LdColor, 'edgecolor', 'none', 'facealpha', 0.3);

hold off

set(ax, 'xlim', spectra([1 end],1), 'ylim', [0 1.05], 'xtick', 400:50:700, 'fontsize', 12);
xlabel(ax, 'Emission Wavelength (nm)'); ylabel('Normalized Intensity (a.u.)');

text(540, 0.8, '$GP = \frac{L_o - L_d}{L_o + L_d}$', 'interpreter', 'latex', 'fontsize', 36);

%%
set(fig, 'paperpositionmode', 'auto');
print(fig, 'D:\Dropbox\Proposals\DeltaGP\Figures\GPIntroFig.png', '-dpng', '-r300');
print(fig, 'D:\Dropbox\Proposals\DeltaGP\Figures\GPIntroFig.eps', '-depsc', '-r300');



    